local _, ns = ...

-- Achievements built from Data_Generated.lua (treasures, lore objects, vistas)
-- plus a few hand-written ones. Appended after Data.lua.

local GEN = ns.GEN
local HAR = 2413
local DEN = 2576
local ZUL = 2437
local ATAL = 2536
local EVE = 2395
local SMC = 2393	-- Silvermoon City
local VOID = 2405
local SLAY = 2444	-- Slayer's Rise
local QD = 2424		-- Isle of Quel'Danas

-- Extra notes for generated steps that need more explanation, keyed by step name.
local EXTRA_NOTES = {
	["Gift of the Cycle"] = "First return three lost items to the spirits: A Tattered Ball (51.1, 50.5) to the Child-like Spirit (51.4, 47.5), A Rolled-Up Pillow (51.4, 56.0) to the Elder Spirit (51.2, 58.6) and A Lost Hunting Knife (45.1, 54.0) to the Huntress Spirit (47.2, 53.2). The gift then appears inside The Den.",
	["Impenetrably Sealed Gourd"] = "Obtain mysterious fluids from other objects in the same cave, then mix red and purple for Fizzing Fluid.",
	["Sunken Diver's Chest"] = "Kill Glittering Grouper Brinetail for 3 Diver's Key Fragments and combine them into a Diver's Key. The pin is where the fragments are found.",
	["Stone Vat"] = "Needs 10 Bunch of Ripe Grapes (from nearby Ripe Grapes) and a Packet of Instant Yeast from Sheri (40.8, 60.5).",
	["Rookery Cache"] = "Feed Tasty Meat to the Mischievous Chick (24.2, 69.5) and grab the Rookery Cache Key (24.1, 69.5).",
	["Gift of the Phoenix"] = "Pick up the Sunstrider Vessel, catch 5 Cinder Embers, then put it back where you found it.",
	["Gilded Arnillary Sphere"] = "Complete any quest after looting it to get the Heathlight Armillary decor.",
	["Nar'zira"] = "Inside the Tomb of the Lost Priest.",
	["Szarith the Fanged"] = "In The Underbelly of the Vaults of Atal'Utek.",
}

local RARE_INFO = "Rares respawn on a timer, so if one isn't up when you arrive, come back later. Each rare ticks off once the achievement counts the kill."

local function Gen(id)
	local steps = {}
	for i, s in ipairs(GEN[id] or {}) do
		local step = {}
		for k, v in pairs(s) do step[k] = v end
		step.note = EXTRA_NOTES[s.name] or step.note
		steps[i] = step
	end
	return steps
end

local function Vistas(id)
	local steps = Gen(id)
	for i, s in ipairs(steps) do s.name = ("Vista Point #%d"):format(i) end
	return steps
end

local extra = {
	-------------------------------------------------------------------------
	-- Treasures
	-------------------------------------------------------------------------
	{ id = 61960, name = "Treasures of Eversong Woods", zone = "Eversong Woods", desc = "Loot every hidden treasure in Eversong Woods.", steps = Gen(61960) },
	{ id = 62125, name = "Treasures of Zul'Aman", zone = "Zul'Aman", desc = "Loot every hidden treasure in Zul'Aman.", steps = Gen(62125) },
	{ id = 61263, name = "Treasures of Harandar", zone = "Harandar", desc = "Loot every hidden treasure in Harandar.", steps = Gen(61263) },
	{ id = 62126, name = "Treasures of Voidstorm", zone = "Voidstorm", desc = "Loot every hidden treasure in Voidstorm.", steps = Gen(62126) },
	{ id = 63359, name = "Treasures of the Coiled Isle", zone = "The Coiled Isle", desc = "Loot every hidden treasure on the Coiled Isle. Several of them have multi-step puzzles; hover a step for the instructions.", steps = Gen(63359) },

	-------------------------------------------------------------------------
	-- Rares (tracked through the achievement criteria; kill quests are daily)
	-------------------------------------------------------------------------
	{ id = 61507, name = "A Bloody Song", zone = "Eversong Woods", critByName = true, desc = "Defeat every rare in Eversong Woods.", info = RARE_INFO, steps = Gen(61507) },
	{ id = 62122, name = "Tallest Tree in the Forest", zone = "Zul'Aman", critByName = true, desc = "Defeat every rare in Zul'Aman.", info = RARE_INFO, steps = Gen(62122) },
	{ id = 61264, name = "Leaf None Behind", zone = "Harandar", critByName = true, desc = "Defeat every rare in Harandar.", info = RARE_INFO, steps = Gen(61264) },
	{ id = 62130, name = "The Ultimate Predator", zone = "Voidstorm", critByName = true, desc = "Defeat every rare in Voidstorm.", info = RARE_INFO, steps = Gen(62130) },
	{ id = 63358, name = "Coiled to Strike", zone = "The Coiled Isle", critByName = true, desc = "Defeat every rare on the Coiled Isle.", info = RARE_INFO, steps = Gen(63358) },

	-------------------------------------------------------------------------
	-- Lore objects
	-------------------------------------------------------------------------
	{ id = 62104, name = "Midnight Lore Hunter", zone = "Quel'Thalas", desc = "Read the lore objects spread across all four zones.", steps = Gen(62104) },
	{ id = 63662, name = "Student of Hissstory", zone = "The Coiled Isle", desc = "Read every lore object on the Coiled Isle.", steps = Gen(63662) },
	{ id = 63610, name = "The Honored Dead", zone = "Vaults of Atal'Utek", desc = "Read every Funerary Inscription in the Vaults of Atal'Utek.", steps = Gen(63610) },

	-------------------------------------------------------------------------
	-- The Highest Peaks (telescopes)
	-------------------------------------------------------------------------
	{ id = 62288, name = "Eversong Woods: The Highest Peaks", zone = "Eversong Woods", desc = "Place a telescope at each Vista Point flag.", steps = Vistas(62288) },
	{ id = 62289, name = "Zul'Aman: The Highest Peaks", zone = "Zul'Aman", desc = "Place a telescope at each Vista Point flag.", steps = Vistas(62289) },
	{ id = 62290, name = "Harandar: The Highest Peaks", zone = "Harandar", desc = "Place a telescope at each Vista Point flag.", steps = Vistas(62290) },
	{ id = 62291, name = "Voidstorm: The Highest Peaks", zone = "Voidstorm", desc = "Place a telescope at each Vista Point.", steps = Vistas(62291) },

	-------------------------------------------------------------------------
	-- Go somewhere
	-------------------------------------------------------------------------
	{
		id = 61860, name = "From The Cradle to the Grave", zone = "Harandar",
		desc = "Fly up towards The Cradle high in the sky above Harandar.",
		steps = {
			{ name = "Fly straight up into the glowing sky above The Cradle", quest = 94046, map = HAR, x = 47.1, y = 53.1, note = "Keep climbing until you hit the glowing skybox; you get teleported back down and the achievement pops." },
		},
	},
	{
		-- Criteria names from Wowhead; coordinates from AllTheThings.
		id = 61859, name = "Midnight Flight Master", zone = "Quel'Thalas", critByName = true,
		desc = "Discover every Midnight flight point. Flight points are shared across your Warband.",
		steps = {
			{ name = "Sanctum of Light, Silvermoon City",      map = SMC,  x = 51.0, y = 71.2 },
			{ name = "Fairbreeze Village, Eversong Woods",     map = EVE,  x = 44.7, y = 45.0 },
			{ name = "Tranquillen, Eversong Woods",            map = EVE,  x = 47.8, y = 67.1 },
			{ name = "Terrace of the Sun, Isle of Quel'Danas", map = QD,   x = 57.6, y = 33.9 },
			{ name = "Amani'Zar Village, Zul'Aman",            map = ZUL,  x = 44.8, y = 65.4 },
			{ name = "Atal'Aman, Zul'Aman",                    map = ATAL, x = 39.8, y = 40.8 },
			{ name = "Shadebasin Watch, Zul'Aman",             map = ZUL,  x = 44.0, y = 33.6 },
			{ name = "Torntusk Overlook, Zul'Aman",            map = ZUL,  x = 33.9, y = 78.3 },
			{ name = "Witherbark Bluffs, Zul'Aman",            map = ZUL,  x = 38.9, y = 23.2 },
			{ name = "Camp Stonewash, Zul'Aman",               map = ZUL,  x = 47.3, y = 25.5, note = "Probably the flight point AllTheThings lists as 'Tortolian Hub'. The pin uses that location." },
			{ name = "Har'alnor, Harandar",                    map = HAR,  x = 31.7, y = 67.4 },
			{ name = "Har'athir, Harandar",                    map = HAR,  x = 69.4, y = 52.6 },
			{ name = "Har'kuai, Harandar",                     map = HAR,  x = 64.6, y = 23.2 },
			{ name = "Har'mara, Harandar",                     map = HAR,  x = 35.5, y = 23.8 },
			{ name = "The Den, Harandar",                      map = HAR,  x = 54.1, y = 53.2 },
			{ name = "Howling Ridge, Voidstorm",               map = VOID, x = 51.1, y = 69.3 },
			{ name = "Locus Point, Voidstorm",                 map = VOID, x = 42.3, y = 73.7 },
			{ name = "Master's Perch, Voidstorm",              map = SLAY, x = 37.8, y = 81.6 },
			{ name = "The Ingress, Voidstorm",                 map = VOID, x = 36.9, y = 59.0 },
		},
	},
}

for _, ach in ipairs(extra) do
	table.insert(ns.Achievements, ach)
end
