local ADDON, ns = ...

local MAH = CreateFrame("Frame")
ns.MAH = MAH

local PREFIX = "|cff66ccffMidnight Ach Helper:|r "
local ICON_DONE = "Interface\\RaidFrame\\ReadyCheck-Ready"
local ICON_TODO = "Interface\\RaidFrame\\ReadyCheck-NotReady"
local ICON_INFO = "Interface\\RaidFrame\\ReadyCheck-Waiting"
local ROW_HEIGHT = 18

local DB
local active		-- { ach = ach, step = step } currently waypointed step
local critCache = {}

local function Print(...)
	print(PREFIX .. strjoin(" ", tostringall(...)))
end

-------------------------------------------------------------------------------
-- Data setup
-------------------------------------------------------------------------------

local function BuildSteps()
	for _, ach in ipairs(ns.Achievements) do
		if ach.moths then
			ach.steps = {}
			for i, m in ipairs(ach.moths) do
				ach.steps[i] = {
					name = ("Glowing Moth #%d (Renown %d)"):format(i, m[5]),
					map = m[1], x = m[2], y = m[3], quest = m[4], note = m[6],
				}
			end
		elseif ach.critByName then
			for _, step in ipairs(ach.steps) do
				if step.crit == nil then step.crit = step.name end
			end
		end
	end
end

-------------------------------------------------------------------------------
-- Completion
-------------------------------------------------------------------------------

local function GetCriteria(achID)
	local c = critCache[achID]
	if c then return c end
	c = {}
	for i = 1, GetAchievementNumCriteria(achID) or 0 do
		local name, _, done = GetAchievementCriteriaInfo(achID, i)
		if name and name ~= "" then c[strlower(name)] = done end
	end
	critCache[achID] = c
	return c
end

local function IsAchDone(ach)
	return select(4, GetAchievementInfo(ach.id)) and true or false
end

local function IsStepDone(ach, step)
	if ach.done then return true end
	if step.crit and GetCriteria(ach.id)[strlower(step.crit)] then return true end
	if step.quest and C_QuestLog.IsQuestFlaggedCompleted(step.quest) then return true end
	if step.accept and (C_QuestLog.IsOnQuest(step.accept) or C_QuestLog.IsQuestFlaggedCompleted(step.accept)) then return true end
	if step.item and C_Item.GetItemCount(step.item, true) > 0 then return true end
	return false
end

local function UpdateStatus()
	wipe(critCache)
	for _, ach in ipairs(ns.Achievements) do
		ach.done = IsAchDone(ach)
		local n = 0
		for _, step in ipairs(ach.steps) do
			step.done = IsStepDone(ach, step)
			if step.done then n = n + 1 end
		end
		ach.numDone = n
	end
end

-------------------------------------------------------------------------------
-- Positions and waypoints
-------------------------------------------------------------------------------

local function MapName(mapID)
	local info = mapID and C_Map.GetMapInfo(mapID)
	return info and info.name or ("map " .. tostring(mapID))
end

local function WorldPos(mapID, x, y)
	local cont, pos = C_Map.GetWorldPosFromMapPos(mapID, CreateVector2D(x, y))
	if cont and pos then
		local wx, wy = pos:GetXY()
		return cont, wx, wy
	end
end

local function PlayerWorldPos()
	local mapID = C_Map.GetBestMapForUnit("player")
	if not mapID then return end
	local pos = C_Map.GetPlayerMapPosition(mapID, "player")
	if not pos then return end
	return WorldPos(mapID, pos:GetXY())
end

local function StepDistance(step, pc, px, py)
	if not (step.map and pc) then return end
	local c, x, y = WorldPos(step.map, step.x / 100, step.y / 100)
	if c ~= pc then return end
	return math.sqrt((x - px) ^ 2 + (y - py) ^ 2)
end

-- Nearest incomplete step with coordinates on your continent. Limited to one
-- achievement when ach is given, otherwise searches everything.
local function FindNearest(onlyAch)
	local pc, px, py = PlayerWorldPos()
	local bestAch, bestStep, bestDist
	for _, ach in ipairs(ns.Achievements) do
		if (not onlyAch or ach == onlyAch) and not ach.done then
			for _, step in ipairs(ach.steps) do
				if not step.done then
					local d = StepDistance(step, pc, px, py)
					if d and (not bestDist or d < bestDist) then
						bestAch, bestStep, bestDist = ach, step, d
					end
				end
			end
		end
	end
	return bestAch, bestStep
end

local function FirstIncomplete(ach)
	for _, step in ipairs(ach.steps) do
		if not step.done then return step end
	end
end

local function ClearWaypoint()
	if MAH.tomtomUID and TomTom then
		TomTom:RemoveWaypoint(MAH.tomtomUID)
		MAH.tomtomUID = nil
	end
	if active and active.native then
		C_Map.ClearUserWaypoint()
	end
	active = nil
end

local function SetWaypoint(ach, step, quiet)
	ClearWaypoint()
	active = { ach = ach, step = step }
	if not step.map then
		Print(ach.name .. ": " .. step.name .. (step.note and (" - " .. step.note) or ""))
		return
	end
	local title = ach.name .. ": " .. step.name
	if TomTom and TomTom.AddWaypoint then
		MAH.tomtomUID = TomTom:AddWaypoint(step.map, step.x / 100, step.y / 100, {
			title = title, persistent = false, minimap = true, world = true, from = ADDON,
		})
	elseif C_Map.CanSetUserWaypointOnMap(step.map) then
		C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(step.map, step.x / 100, step.y / 100))
		C_SuperTrack.SetSuperTrackedUserWaypoint(true)
		active.native = true
	else
		Print("Can't place a map pin on " .. MapName(step.map) .. ".")
	end
	if not quiet then
		Print(("%s - %s %.1f, %.1f%s"):format(title, MapName(step.map), step.x, step.y, step.note and ("  (" .. step.note .. ")") or ""))
	end
end

-- Called after a status refresh: if the waypointed step got done, move on.
local function AdvanceIfDone()
	if not (active and active.step.done) then return end
	local ach = active.ach
	if ach.done then
		Print("|cff00ff00" .. ach.name .. " complete!|r")
		ClearWaypoint()
		return
	end
	local _, nextStep = FindNearest(ach)
	nextStep = nextStep or FirstIncomplete(ach)
	if nextStep then
		Print(("|cff00ff00Done:|r %s. Next up:"):format(active.step.name))
		SetWaypoint(ach, nextStep)
	else
		ClearWaypoint()
	end
end

-------------------------------------------------------------------------------
-- UI
-------------------------------------------------------------------------------

local frame, content, rows = nil, nil, {}

local function RowOnEnter(self)
	local ach, step = self.ach, self.step
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	if step then
		GameTooltip:AddLine(step.name, 1, 1, 1, true)
		if step.map then
			GameTooltip:AddLine(("%s %.1f, %.1f"):format(MapName(step.map), step.x, step.y), 0.8, 0.8, 0.8)
		end
		if step.note then GameTooltip:AddLine(step.note, 1, 0.82, 0, true) end
		GameTooltip:AddLine(step.map and "Click to set a waypoint." or "Click to print the details.", 0.5, 0.8, 1)
	else
		GameTooltip:AddLine(ach.name, 1, 0.82, 0)
		if ach.desc then GameTooltip:AddLine(ach.desc, 1, 1, 1, true) end
		if ach.info then GameTooltip:AddLine(ach.info, 1, 0.5, 0.25, true) end
		GameTooltip:AddLine("Click: expand/collapse.  Right-click: waypoint to nearest step.  Shift-click: link.", 0.5, 0.8, 1, true)
	end
	GameTooltip:Show()
end

local function RowOnClick(self, button)
	local ach, step = self.ach, self.step
	if step then
		SetWaypoint(ach, step)
	elseif IsShiftKeyDown() then
		ChatEdit_InsertLink(GetAchievementLink(ach.id))
		return
	elseif button == "RightButton" then
		local _, s = FindNearest(ach)
		s = s or FirstIncomplete(ach)
		if s then SetWaypoint(ach, s) end
	else
		DB.collapsed[ach.id] = not DB.collapsed[ach.id]
	end
	MAH:Render()
end

local function GetRow(i)
	local row = rows[i]
	if row then return row end
	row = CreateFrame("Button", nil, content)
	row:SetHeight(ROW_HEIGHT)
	row:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	row:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
	row.icon = row:CreateTexture(nil, "ARTWORK")
	row.icon:SetSize(14, 14)
	row.text = row:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	row.text:SetJustifyH("LEFT")
	row.text:SetWordWrap(false)
	row:SetScript("OnEnter", RowOnEnter)
	row:SetScript("OnLeave", GameTooltip_Hide)
	row:SetScript("OnClick", RowOnClick)
	rows[i] = row
	return row
end

local function SetupRow(row, y, indent, iconPath, text, font)
	row:ClearAllPoints()
	row:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -y)
	row:SetPoint("RIGHT", content, "RIGHT")
	row.icon:ClearAllPoints()
	row.icon:SetPoint("LEFT", indent, 0)
	row.icon:SetTexture(iconPath)
	row.icon:SetShown(iconPath ~= nil)
	row.text:ClearAllPoints()
	row.text:SetPoint("LEFT", indent + (iconPath and 18 or 0), 0)
	row.text:SetPoint("RIGHT", -4, 0)
	row.text:SetFontObject(font)
	row.text:SetText(text)
	row:Show()
end

-- Climb the map tree to the zone-level map, so subzones and caves count as their zone.
local zoneCache = {}
local function ZoneOf(mapID)
	if not mapID then return end
	local z = zoneCache[mapID]
	if z ~= nil then return z or nil end
	local id, info = mapID, C_Map.GetMapInfo(mapID)
	while info and info.mapType and info.mapType > Enum.UIMapType.Zone and info.parentMapID and info.parentMapID > 0 do
		id = info.parentMapID
		info = C_Map.GetMapInfo(id)
	end
	zoneCache[mapID] = id or false
	return id
end

local function InPlayerZone(ach, playerZone)
	for _, step in ipairs(ach.steps) do
		if step.map and ZoneOf(step.map) == playerZone then return true end
	end
	return false
end

function MAH:Render()
	if not (frame and frame:IsShown()) then return end
	local i, y = 0, 0
	local remaining = 0
	local playerZone = DB.zoneOnly and ZoneOf(C_Map.GetBestMapForUnit("player"))
	for _, ach in ipairs(ns.Achievements) do
		if (DB.showDone or not ach.done) and (not playerZone or InPlayerZone(ach, playerZone)) then
			if not ach.done then remaining = remaining + 1 end
			i = i + 1
			local row = GetRow(i)
			row.ach, row.step = ach, nil
			local collapsed = DB.collapsed[ach.id]
			local color = ach.done and "|cff00ff00" or "|cffffd100"
			SetupRow(row, y, 0, nil,
				("%s %s%s|r |cff999999(%d/%d) - %s|r"):format(collapsed and "+" or "-", color, ach.name, ach.numDone, #ach.steps, ach.zone),
				"GameFontNormal")
			y = y + ROW_HEIGHT + 2
			if not collapsed then
				for _, step in ipairs(ach.steps) do
					if DB.showDone or not step.done then
						i = i + 1
						row = GetRow(i)
						row.ach, row.step = ach, step
						local icon = step.done and ICON_DONE or (step.map and ICON_TODO or ICON_INFO)
						local text = step.name
						if step.map then
							text = ("%s |cff999999%.1f, %.1f|r"):format(text, step.x, step.y)
						end
						if active and active.step == step then
							text = "|cff00ccff>> |r" .. text
						end
						SetupRow(row, y, 12, icon, text, "GameFontHighlightSmall")
						y = y + ROW_HEIGHT
					end
				end
				y = y + 4
			end
		end
	end
	for j = i + 1, #rows do rows[j]:Hide() end
	content:SetHeight(math.max(y, 1))
	frame.status:SetText(("%d achievement%s left"):format(remaining, remaining == 1 and "" or "s"))
end

local function CreateUI()
	frame = CreateFrame("Frame", "MidnightAchHelperFrame", UIParent, "BasicFrameTemplateWithInset")
	frame:SetSize(540, 560)
	frame:SetFrameStrata("MEDIUM")
	frame:SetClampedToScreen(true)
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		local point, _, relPoint, x, y = self:GetPoint()
		DB.pos = { point, relPoint, x, y }
	end)
	if DB.pos then
		frame:SetPoint(DB.pos[1], UIParent, DB.pos[2], DB.pos[3], DB.pos[4])
	else
		frame:SetPoint("CENTER")
	end
	frame:Hide()
	tinsert(UISpecialFrames, frame:GetName())

	local title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	title:SetPoint("TOP", 0, -5)
	title:SetText("Midnight Achievement Helper")

	local nearest = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	nearest:SetSize(120, 22)
	nearest:SetPoint("TOPLEFT", 12, -30)
	nearest:SetText("Nearest step")
	nearest:SetScript("OnClick", function() MAH:Nearest() end)

	local clear = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	clear:SetSize(110, 22)
	clear:SetPoint("LEFT", nearest, "RIGHT", 6, 0)
	clear:SetText("Clear waypoint")
	clear:SetScript("OnClick", function() ClearWaypoint(); MAH:Render() end)

	local check = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
	check:SetSize(24, 24)
	check:SetPoint("LEFT", clear, "RIGHT", 10, 0)
	check:SetChecked(DB.showDone)
	check:SetScript("OnClick", function(self)
		DB.showDone = self:GetChecked() and true or false
		MAH:Render()
	end)
	local checkText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	checkText:SetPoint("LEFT", check, "RIGHT", 2, 0)
	checkText:SetText("Show completed")

	local zoneCheck = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
	zoneCheck:SetSize(24, 24)
	zoneCheck:SetPoint("LEFT", checkText, "RIGHT", 8, 0)
	zoneCheck:SetChecked(DB.zoneOnly)
	zoneCheck:SetScript("OnClick", function(self)
		DB.zoneOnly = self:GetChecked() and true or false
		MAH:Render()
	end)
	local zoneText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	zoneText:SetPoint("LEFT", zoneCheck, "RIGHT", 2, 0)
	zoneText:SetText("This zone only")

	local scroll = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
	scroll:SetPoint("TOPLEFT", 12, -60)
	scroll:SetPoint("BOTTOMRIGHT", -32, 28)
	content = CreateFrame("Frame", nil, scroll)
	content:SetSize(430, 1)
	scroll:SetScrollChild(content)
	scroll:SetScript("OnSizeChanged", function(self, w) content:SetWidth(w) end)

	frame.status = frame:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
	frame.status:SetPoint("BOTTOMLEFT", 14, 10)

	local hint = frame:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
	hint:SetPoint("BOTTOMRIGHT", -14, 10)
	hint:SetText("Click a step to set a waypoint")

	frame:SetScript("OnShow", function() UpdateStatus(); MAH:Render() end)
end

function MAH:Toggle()
	if not frame then CreateUI() end
	frame:SetShown(not frame:IsShown())
end

function MAH:Nearest()
	UpdateStatus()
	local ach, step = FindNearest()
	if ach then
		SetWaypoint(ach, step)
	else
		Print("No incomplete steps on this continent.")
	end
	self:Render()
end

-------------------------------------------------------------------------------
-- Events
-------------------------------------------------------------------------------

local pending
local function Refresh()
	pending = nil
	UpdateStatus()
	AdvanceIfDone()
	MAH:Render()
end

local function QueueRefresh()
	if pending then return end
	pending = true
	C_Timer.After(1, Refresh)
end

MAH:SetScript("OnEvent", function(self, event, arg1)
	if event == "ADDON_LOADED" then
		if arg1 ~= ADDON then return end
		self:UnregisterEvent("ADDON_LOADED")
		MidnightAchHelperDB = MidnightAchHelperDB or {}
		DB = MidnightAchHelperDB
		DB.collapsed = DB.collapsed or {}
		BuildSteps()
		-- Moth list is long; start it collapsed.
		if DB.collapsed[61052] == nil then DB.collapsed[61052] = true end
	elseif event == "PLAYER_ENTERING_WORLD" then
		UpdateStatus()
	else
		QueueRefresh()
	end
end)

MAH:RegisterEvent("ADDON_LOADED")
MAH:RegisterEvent("PLAYER_ENTERING_WORLD")
MAH:RegisterEvent("CRITERIA_UPDATE")
MAH:RegisterEvent("ACHIEVEMENT_EARNED")
MAH:RegisterEvent("QUEST_TURNED_IN")
MAH:RegisterEvent("QUEST_ACCEPTED")
MAH:RegisterEvent("LOOT_CLOSED")
MAH:RegisterEvent("BAG_UPDATE_DELAYED")
MAH:RegisterEvent("ZONE_CHANGED_NEW_AREA")

-- Hidden "tracking" quests (moths, lore objects) don't always fire events, so
-- poll lightly while a waypoint is active.
C_Timer.NewTicker(3, function()
	if active and not pending then
		local step = active.step
		if step.quest and C_QuestLog.IsQuestFlaggedCompleted(step.quest) and not step.done then
			QueueRefresh()
		end
	end
end)

-------------------------------------------------------------------------------
-- Slash commands
-------------------------------------------------------------------------------

SLASH_MIDNIGHTACHHELPER1 = "/mach"
SLASH_MIDNIGHTACHHELPER2 = "/midach"
SlashCmdList.MIDNIGHTACHHELPER = function(msg)
	msg = strlower(strtrim(msg or ""))
	if msg == "near" or msg == "nearest" then
		MAH:Nearest()
	elseif msg == "clear" then
		ClearWaypoint()
		MAH:Render()
	elseif msg == "list" then
		UpdateStatus()
		for _, ach in ipairs(ns.Achievements) do
			if not ach.done then
				Print(("%s (%d/%d) - %s"):format(ach.name, ach.numDone, #ach.steps, ach.zone))
			end
		end
	elseif msg == "help" then
		Print("/mach - toggle window, /mach nearest - waypoint to the closest step, /mach clear - remove waypoint, /mach list - print what's left")
	else
		MAH:Toggle()
	end
end
