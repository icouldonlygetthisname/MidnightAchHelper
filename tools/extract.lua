-- Loads AllTheThings parser source files with stubbed constructors and dumps
-- achievement steps (name, map, x, y, questID, note) for the addon.
-- usage: lua extract.lua <ATT Parser dir> <out file>
local PARSER = arg[1]
local OUT = arg[2]
local QT = PARSER .. "/DATAS/02 - Outdoor Zones/16 Quel'Thalas/"

local env = {}
local magicMT = {}
local function magic(path) return setmetatable({ __path = path }, magicMT) end
local function ctor(kind, ...)
	local args = { ... }
	local node
	for i = #args, 1, -1 do
		if type(args[i]) == "table" and not getmetatable(args[i]) then node = args[i]; break end
	end
	node = node or {}
	if kind == "header" then
		node._hdr = args[1] and rawget(args[1], "__path")
		node._id = args[2]
	else
		for _, a in ipairs(args) do if type(a) == "number" then node._id = a; break end end
	end
	node._kind = kind
	return node
end
magicMT.__index = function(t, k) return magic(rawget(t, "__path") .. "." .. tostring(k)) end
magicMT.__call = function(t, ...) return ctor(rawget(t, "__path"), ...) end
setmetatable(env, { __index = function(t, k)
	if _G[k] and (k == "ipairs" or k == "pairs" or k == "type" or k == "string" or k == "table" or k == "math" or k == "tostring" or k == "tonumber" or k == "select" or k == "unpack") then return _G[k] end
	if k:match("^%l") then return function(...) return ctor(k, ...) end end
	return magic(k)
end })

local function load(path)
	local f = assert(loadfile(path))
	setfenv(f, env)
	local ok, err = pcall(f)
	if not ok then io.stderr:write("WARN " .. path .. ": " .. tostring(err) .. "\n") end
end

-- names from source comments: "o(12345, {	-- Name" / quest comments
local names, questNotes = {}, {}
local function scanNames(path)
	for line in io.lines(path) do
		local kind, id, name = line:match("(%a+)%((%d+),.-%-%-%s*(.-)%s*$")
		if kind and not names[kind .. id] then names[kind .. id] = name end
		local hid, hname = line:match("header%(HEADERS%.%a+, (%d+),.-%-%-%s*(.-)%s*$")
		if hid then names["header" .. hid] = names["header" .. hid] or hname end
		local qid, qn = line:match('%["questID"%] = (%d+),%s*%-%-%s*(.-)%s*$')
		if qid then questNotes[tonumber(qid)] = qn end
	end
end

load(PARSER .. "/lib/Constants/Maps.lua")

local roots = {}
env.root = function(_, node) roots[#roots + 1] = node end

local files = {
	"Eversong Woods/Treasures.lua", "Harandar/Treasures.lua", "Voidstorm/Treasures.lua",
	"Zul'Aman/Treasures.lua", "The Coiled Isle/Treasures.lua",
	"The Coiled Isle/Vaults of Atal'Utek/Treasures.lua",
	"1 - Silvermoon City/Flight Paths.lua", "Eversong Woods/Flight Paths.lua", "Harandar/Flight Paths.lua",
	"Isle of Quel'Danas/Flight Paths.lua", "Voidstorm/Flight Paths.lua", "Zul'Aman/Flight Paths.lua",
}
for _, f in ipairs(files) do scanNames(QT .. f); load(QT .. f) end

-- Rare files are loaded separately: ATT lists rares by zone, not under the
-- achievements, so they're matched to criteria names further down.
local rareRoots = {}
env.root = function(_, node) rareRoots[#rareRoots + 1] = node end
local rareFiles = {
	"Eversong Woods/Rares.lua", "Zul'Aman/Rares.lua", "Harandar/Rares.lua",
	"Voidstorm/Rares.lua", "The Coiled Isle/Rares.lua",
}
for _, f in ipairs(rareFiles) do scanNames(QT .. f); load(QT .. f) end

local function children(node)
	local list = {}
	if type(node.groups) == "table" then for _, c in ipairs(node.groups) do list[#list + 1] = c end end
	for _, c in ipairs(node) do list[#list + 1] = c end
	return list
end

local function firstCoord(node)
	local c = node.coord
	if type(c) == "table" and type(c[1]) == "table" then c = c[1] end
	if not c and type(node.coords) == "table" then c = node.coords[1] end
	if type(c) == "table" and type(c[1]) == "number" then return c end
end

local function findQuest(node, id)
	if node.questID and (not id or node._id == id) then return node.questID end
	for _, c in ipairs(children(node)) do
		if type(c) == "table" then
			local q = findQuest(c, id)
			if q then return q end
		end
	end
end

-- Achievement ID -> list of steps
local result = {}
local fps = {}
local function walk(node, achID, mapID)
	if type(node) ~= "table" then return end
	if node._kind == "m" and type(node._id) == "number" then mapID = node._id end
	if node._kind == "header" and node._hdr == "HEADERS.Achievement" then
		achID = node._id
		result[achID] = result[achID] or {}
		for _, c in ipairs(children(node)) do
			if type(c) == "table" then
				local key = (c._kind == "header" and "header" or c._kind) .. tostring(c._id)
				local name = names[key] or ("#" .. tostring(c._id))
				local coord = firstCoord(c)
				local quest = c.questID
				if c._kind == "header" then
					-- the final treasure object inside shares the header's name/ID
					local final
					local function find(n)
						for _, d in ipairs(children(n)) do
							if type(d) == "table" then
								if d.questID and (d._id == c._id or names[d._kind .. tostring(d._id)] == name) then final = d end
								find(d)
							end
						end
					end
					find(c)
					if final then
						quest = quest or final.questID
						coord = coord or firstCoord(final)
					end
				end
				quest = quest or findQuest(c, c._id) or findQuest(c)
				if c.name then name = c.name end
				name = name:gsub("%s*//.*$", "")
				local desc = c.description
				if type(desc) == "string" then desc = desc:gsub("%*%*%*Enable Debug Mode[^\n]*%*%*%*\n?", "") end
				c.description = desc
				if quest and questNotes[quest] and name == "Funerary Inscription" then
					name = name .. ": " .. questNotes[quest]
				end
				table.insert(result[achID], {
					name = name, quest = quest, desc = c.description,
					obj = (c._kind == "o" or c._hdr == "HEADERS.Object") and c._id or nil,
					npc = (c._kind == "n" or c._hdr == "HEADERS.NPC") and c._id or nil,
					map = coord and coord[3] or nil, x = coord and coord[1], y = coord and coord[2],
				})
			end
		end
		return
	end
	if node._kind == "fp" then
		local coord = firstCoord(node)
		fps[#fps + 1] = { name = names["fp" .. node._id], map = coord and coord[3], x = coord and coord[1], y = coord and coord[2] }
	end
	for _, c in ipairs(children(node)) do walk(c, achID, mapID) end
end
for _, r in ipairs(roots) do walk(r) end

-- Every rare NPC with a location, keyed by name. Their kill quests are daily,
-- so no quest is kept: the addon tracks rares through the achievement criteria.
-- ATT comments can carry a title or note ("Big Mon <Ancient Amani Warband>",
-- "Overfester Hydra (vignette - ...)") and differ in case from the criteria.
local function rareKey(name)
	return name:gsub("%s*<.->", ""):gsub("%s*%(.-%)", ""):lower():gsub("^%s+", ""):gsub("%s+$", "")
end
local rareByName = {}
local function walkRares(node)
	if type(node) ~= "table" then return end
	if node._kind == "n" and type(node._id) == "number" then
		local name = names["n" .. node._id]
		local coord = firstCoord(node)
		if name and coord and not rareByName[rareKey(name)] then
			rareByName[rareKey(name)] = { npc = node._id, desc = node.description,
				map = coord[3], x = coord[1], y = coord[2] }
		end
	end
	for _, c in ipairs(children(node)) do walkRares(c) end
end
for _, r in ipairs(rareRoots) do walkRares(r) end

-- Criteria names per rare achievement ("achID<TAB>name" per line), in criteria order.
local CRITERIA = arg[3] or (arg[0]:gsub("[^/\\]*$", "") .. "rare_criteria.txt")
local rareAchs, rareOrder = {}, {}
for line in io.lines(CRITERIA) do
	local id, name = line:match("^(%d+)\t(.-)%s*$")
	if id then
		id = tonumber(id)
		if not rareAchs[id] then rareAchs[id] = {}; rareOrder[#rareOrder + 1] = id end
		local found = rareByName[rareKey(name)]
		if not found then io.stderr:write("WARN no ATT location for rare '" .. name .. "' (" .. id .. ")\n") end
		local rare = { name = name }	-- criteria spelling, so the addon's crit match works
		for k, v in pairs(found or {}) do rare[k] = v end
		table.insert(rareAchs[id], rare)
	end
end

local function q(s) return string.format("%q", s):gsub("\\\n", "\\n") end
-- Achievements the addon uses; everything else found in the files is skipped.
local WANTED = {
	[61263] = true, [61960] = true, [62104] = true, [62125] = true, [62126] = true,
	[62288] = true, [62289] = true, [62290] = true, [62291] = true,
	[63359] = true, [63610] = true, [63662] = true,
}
local out = assert(io.open(OUT, "w"))
out:write("-- GENERATED by tools/extract.lua from AllTheThings data. Do not edit by hand;\n")
out:write("-- re-run the extractor instead (see tools/README.md).\n")
out:write("local _, ns = ...\nlocal GEN = {}\nns.GEN = GEN\n\n")
local function emit(id, steps)
	out:write(("GEN[%d] = {\n"):format(id))
	local seen = {}
	for _, s in ipairs(steps) do
		local key = s.name .. tostring(s.x) .. tostring(s.y)
		if not seen[key] then
		seen[key] = true
		out:write("\t{ name = " .. q(s.name))
		if s.map then out:write((", map = %d, x = %.1f, y = %.1f"):format(s.map, s.x, s.y)) end
		if s.quest then out:write(", quest = " .. s.quest) end
		if s.obj then out:write(", obj = " .. s.obj) end
		if s.npc then out:write(", npc = " .. s.npc) end
		if s.desc then out:write(", note = " .. q(s.desc)) end
		out:write(" },\n")
		end
	end
	out:write("}\n")
end
local ids = {}
for id in pairs(result) do if WANTED[id] then ids[#ids + 1] = id end end
table.sort(ids)
for _, id in ipairs(ids) do emit(id, result[id]) end
for _, id in ipairs(rareOrder) do emit(id, rareAchs[id]) end
out:close()
for _, id in ipairs(ids) do io.write(id, " ", #result[id], "\n") end
for _, id in ipairs(rareOrder) do io.write("rares ", id, " ", #rareAchs[id], "\n") end
-- Flight points are listed for reference only; Data.lua uses Wowhead's criteria names.
for _, f in ipairs(fps) do io.write("fp ", tostring(f.name), " ", tostring(f.map), " ", tostring(f.x), " ", tostring(f.y), "\n") end
