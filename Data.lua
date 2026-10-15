local _, ns = ...

-- uiMapIDs
local HAR  = 2413	-- Harandar
local DEN  = 2576	-- The Den (Harandar cave)
local ZUL  = 2437	-- Zul'Aman
local ATAL = 2536	-- Atal'Aman
local EVE  = 2395	-- Eversong Woods
local ARC  = 2541	-- The Arcantina

-- Step fields:
--   name   display text
--   crit   achievement criteria name; the step is done once that criteria is done
--   quest  questID; the step is done once flagged completed
--   accept questID; the step is done once you are on (or have completed) that quest
--   item   itemID; the step is done while you have the item in your bags
--   map/x/y waypoint (omit for steps inside instances)
--   note   extra help shown in the tooltip
-- critByName = true on an achievement means each step's crit defaults to its name.

ns.Achievements = {
	-------------------------------------------------------------------------
	-- Zul'Aman
	-------------------------------------------------------------------------
	{
		id = 62200, name = "Gnome Alone", zone = "Zul'Aman", critByName = true,
		desc = "Click each piece of the lost gnome's writings.",
		steps = {
			{ name = "Discarded Scroll",       map = ZUL, x = 45.9, y = 66.0 },
			{ name = "Hastily-Scribbled Note", map = ZUL, x = 46.4, y = 41.4 },
			{ name = "Message in a Bottle",    map = ZUL, x = 54.9, y = 32.4 },
			{ name = "Moldy Diary Found",      map = ZUL, x = 35.7, y = 25.2, note = "The object is called 'Moldy Diary'." },
			{ name = "Parting Note",           map = ZUL, x = 34.8, y = 17.2 },
			{ name = "Scrap of Singed Paper",  map = ZUL, x = 54.3, y = 20.6 },
		},
	},
	{
		id = 61455, name = "Shadowpine Scattered", zone = "Zul'Aman", critByName = true,
		desc = "Find and talk to each Shadowpine Songseeker.",
		steps = {
			{ name = "Songseeker Baz'wa",   map = ZUL, x = 52.7, y = 79.3, note = "Only appears after you finish the Zul'Aman campaign." },
			{ name = "Songseeker Dova",     map = ZUL, x = 39.2, y = 56.4 },
			{ name = "Songseeker Far'lan",  map = ZUL, x = 47.3, y = 81.9 },
			{ name = "Songseeker Ikaja",    map = ZUL, x = 55.2, y = 18.1, note = "On top of the temple." },
			{ name = "Songseeker Jebanda",  map = ZUL, x = 31.6, y = 38.1, note = "Patrols with a group of Shadowpine Travelers between 31.6,38.1 / 31.6,46.5 / 33.1,44.0 / 33.3,39.9." },
		},
	},
	{
		id = 62201, name = "The Frog and the Princesses", zone = "Zul'Aman", critByName = true,
		desc = "Target each 'princess' frog and type /kiss.",
		steps = {
			{ name = "Princess Fita",    map = ZUL,  x = 31.7, y = 22.6, note = "Target her and /kiss." },
			{ name = "Princess Gabiku",  map = ZUL,  x = 68.3, y = 19.3, note = "Target her and /kiss." },
			{ name = "Princess Jakobu",  map = ATAL, x = 27.5, y = 40.1, note = "In Atal'Aman. Target her and /kiss." },
			{ name = "Princess Tafiki",  map = ZUL,  x = 53.9, y = 59.6, note = "Target her and /kiss." },
			{ name = "Princess Zambina", map = ZUL,  x = 29.8, y = 79.1, note = "Target her and /kiss." },
		},
	},
	{
		id = 62199, name = "Put a Pin in It", zone = "Zul'Aman",
		desc = "Find Chu'ke the possessed doll, fetch its button, then meet it again.",
		steps = {
			{ name = "Talk to Chu'ke on a ridge by the coast", crit = "Chu'ke found", quest = 95005, map = ZUL, x = 59.2, y = 71.1 },
			{ name = "Talk to Kalika and take the Forgotten Button", crit = "Chu'ke joined", quest = 95045, map = ZUL, x = 38.7, y = 23.9 },
			{ name = "Talk to Chu'ke again south of the Den of Nalorakk", crit = "Chu'ke joined", quest = 95046, map = ZUL, x = 37.8, y = 90.1 },
		},
	},
	{
		id = 62202, name = "Spiritpaw Marathon", zone = "Zul'Aman",
		desc = "Find the Spiritpaw Runner, talk to it and keep up with it for the whole run.",
		steps = {
			{ name = "Find the Spiritpaw Runner", crit = "Spiritpaw Runner found", quest = 95450, map = ZUL, x = 32.2, y = 22.4, note = "NPC 258938. Talk to it to start the run." },
			{ name = "Complete the run", crit = "Run completed", quest = 95450, map = ZUL, x = 51.6, y = 32.7, note = "Follow the runner to the end. This point is approximate; follow the runner, not the pin." },
		},
	},

	-------------------------------------------------------------------------
	-- Eversong Woods
	-------------------------------------------------------------------------
	{
		id = 62185, name = "Ever Painting", zone = "Eversong Woods", critByName = true,
		desc = "Click each painter's easel found outdoors.",
		steps = {
			{ name = "Anar'alah Belore",     map = EVE, x = 50.8, y = 41.2 },
			{ name = "Babble and Brook",     map = EVE, x = 46.1, y = 64.2 },
			{ name = "Elrendar's Song",      map = EVE, x = 42.6, y = 62.6 },
			{ name = "Light Consuming",      map = EVE, x = 55.1, y = 59.7 },
			{ name = "Lost Lamppost",        map = EVE, x = 41.8, y = 56.3 },
			{ name = "Memories of Ghosts",   map = EVE, x = 39.0, y = 78.2 },
			{ name = "Sway of Red and Gold", map = EVE, x = 54.0, y = 75.6 },
		},
	},
	{
		id = 62187, name = "Grand Magister's Sommelier", zone = "Eversong Woods", critByName = true,
		desc = "Talk to every drink vendor during 'Special Assignment: The Grand Magister's Drink'.",
		info = "Only possible while the Special Assignment 'The Grand Magister's Drink' (40.7, 61.2) is up. Tip: convert to a Raid group so you can go through every dialog without the quest completing early.",
		steps = {
			{ name = "Heron's Vision of Cloudwalking",   map = EVE, x = 39.3, y = 60.2 },
			{ name = "Areyn's Elrendar Red",             map = EVE, x = 39.3, y = 61.4 },
			{ name = "Kreynna's Khadgar's Imitation",    map = EVE, x = 40.7, y = 59.5 },
			{ name = "Lady Marilin's Arcwine Reserve",   map = EVE, x = 40.3, y = 61.2 },
			{ name = "Landraelanis' Muskmelon Draught",  map = EVE, x = 41.5, y = 61.3 },
			{ name = "Limien's Arcane Infusion",         map = EVE, x = 40.7, y = 60.1 },
			{ name = "Duskwither's Dancing Merlot",      map = EVE, x = 38.3, y = 58.4 },
			{ name = "Nara's Essence of Butterfly",      map = EVE, x = 39.6, y = 60.6 },
			{ name = "Quarelestra's Sanguine Affair",    map = EVE, x = 39.8, y = 60.9 },
			{ name = "Sheri's Laughing Rose",            map = EVE, x = 40.8, y = 60.5 },
			{ name = "Vehn's Shimmerveil Blanc",         map = EVE, x = 39.3, y = 61.1 },
			{ name = "Zalene's Twilight Claret",         map = EVE, x = 40.3, y = 61.5 },
		},
	},

	-------------------------------------------------------------------------
	-- Harandar
	-------------------------------------------------------------------------
	{
		id = 61344, name = "Chronicler of the Haranir", zone = "Harandar", critByName = true,
		desc = "Click the lore objects that belong to each Legend of the Haranir.",
		info = "Lore objects only appear while you are on that legend's quest. Pick the legend each week from Zur'ashar Kassameh (54.2, 53.1) through 'Lost Legends'. You can find 3 lore objects per week.",
		steps = {
			{ name = "Echoes of Our Past--Part 1: Fading History",      quest = 93475, map = HAR, x = 60.0, y = 20.9, note = "Legend: The Cauldron of Echoes" },
			{ name = "Echoes of Our Past--Part 2: Alndust",             quest = 93474, map = HAR, x = 59.7, y = 18.5, note = "Legend: The Cauldron of Echoes" },
			{ name = "Echoes of Our Past--Part 3: Dangerous Memories",  quest = 93473, map = HAR, x = 61.1, y = 16.0, note = "Legend: The Cauldron of Echoes" },
			{ name = "Lament of Wey'nan--Part 1: Finding Hope",         quest = 93470, map = HAR, x = 43.2, y = 37.3, note = "Legend: Wey'nan's Ward" },
			{ name = "Lament of Wey'nan--Part 2: Hunting Purpose",      quest = 93471, map = HAR, x = 41.6, y = 35.9, note = "Legend: Wey'nan's Ward" },
			{ name = "Lament of Wey'nan--Part 3: There Must Be More",   quest = 93472, map = HAR, x = 42.3, y = 35.5, note = "Legend: Wey'nan's Ward" },
			{ name = "Seeker's Trail--Part 1: Call of Aln'hara",        quest = 93479, map = HAR, x = 53.7, y = 67.0, note = "Legend: Aln'hara's Bloom" },
			{ name = "Seeker's Trail--Part 2: Seeking Peace",           quest = 93478, map = HAR, x = 55.0, y = 66.3, note = "Legend: Aln'hara's Bloom" },
			{ name = "Seeker's Trail--Part 3: Unending Mission",        quest = 93476, map = HAR, x = 55.9, y = 66.9, note = "Legend: Aln'hara's Bloom" },
			{ name = "Tending the Lands--Part 1: The Conflict",         quest = 93485, map = HAR, x = 63.4, y = 40.1, note = "Legend: Russula's Outreach" },
			{ name = "Tending the Lands--Part 2: The Plan",             quest = 93484, map = HAR, x = 61.0, y = 39.0, note = "Legend: Russula's Outreach" },
			{ name = "Tending the Lands--Part 3: The Cycle",            quest = 93483, map = HAR, x = 61.4, y = 37.2, note = "Legend: Russula's Outreach" },
			{ name = "Words of Obayo--Part 1: The Flame",               quest = 93482, map = HAR, x = 64.9, y = 38.5, note = "Legend: The Echoless Flame" },
			{ name = "Words of Obayo--Part 2: The Rift",                quest = 93481, map = HAR, x = 61.4, y = 35.0, note = "Legend: The Echoless Flame" },
			{ name = "Words of Obayo--Part 3: The Silence",             quest = 93480, map = HAR, x = 62.6, y = 35.7, note = "Legend: The Echoless Flame" },
			{ name = "Ways of the Roots--Part 1: Serving",              quest = 93488, map = HAR, x = 40.8, y = 36.3, note = "Legend: Root of the World" },
			{ name = "Ways of the Roots--Part 2: Growing",              quest = 93487, map = HAR, x = 41.5, y = 34.1, note = "Legend: Root of the World" },
			{ name = "Ways of the Roots--Part 3: Pruning",              quest = 93486, map = HAR, x = 40.5, y = 34.7, note = "Legend: Root of the World" },
			{ name = "Awe'ohna's Path--Part 1: Questions",              quest = 93491, map = HAR, x = 71.9, y = 59.0, note = "Legend: Sky's Hope" },
			{ name = "Awe'ohna's Path--Part 2: Answers",                quest = 93490, map = HAR, x = 73.5, y = 58.2, note = "Legend: Sky's Hope" },
			{ name = "Awe'ohna's Path--Part 3: The Cradle",             quest = 93489, map = HAR, x = 73.5, y = 57.5, note = "Legend: Sky's Hope" },
		},
	},
	{
		id = 61052, name = "Dust 'Em Off", zone = "Harandar",
		desc = "Catch all 120 Glowing Moths.",
		info = "Moths unlock in batches with Hara'ti renown: 40 at Renown 2, 40 more at Renown 4 and the last 40 at Renown 9. Mothkeeper Wew'tam (49.3, 54.3) has rewards every 10 moths.",
		-- { map, x, y, questID, renown, note }
		moths = {
		{ HAR, 36.4, 48.4, 92196, 2 },
		{ HAR, 36.1, 26.4, 92197, 2 },
		{ HAR, 49.9, 25.5, 92198, 2 },
		{ HAR, 55.0, 27.6, 92199, 2 },
		{ HAR, 66.3, 62.8, 92200, 2 },
		{ HAR, 33.4, 63.5, 92201, 2 },
		{ HAR, 33.4, 75.6, 92202, 2 },
		{ HAR, 31.8, 81.8, 92203, 2 },
		{ HAR, 42.2, 66.5, 92204, 2 },
		{ HAR, 52.4, 80.8, 92205, 2 },
		{ HAR, 48.5, 55.3, 92307, 2 },
		{ HAR, 67.7, 68.9, 92306, 2 },
		{ HAR, 60.0, 43.0, 92305, 2 },
		{ HAR, 69.0, 31.2, 92304, 2 },
		{ HAR, 65.4, 27.1, 92303, 2 },
		{ HAR, 50.6, 40.6, 92302, 2 },
		{ HAR, 41.6, 27.4, 92301, 2 },
		{ HAR, 40.4, 34.5, 92300, 2 },
		{ HAR, 56.6, 47.7, 92299, 2 },
		{ HAR, 59.5, 54.3, 92206, 2 },
		{ HAR, 71.4, 58.6, 92215, 2 },
		{ HAR, 52.9, 50.7, 92214, 2, "Also reachable inside The Den (61.2, 32.3)" },
		{ HAR, 32.1, 67.1, 92213, 2 },
		{ HAR, 32.6, 84.8, 92212, 2 },
		{ HAR, 30.3, 73.4, 92211, 2 },
		{ HAR, 43.2, 53.7, 92210, 2 },
		{ HAR, 60.4, 48.6, 92209, 2 },
		{ HAR, 34.0, 44.1, 92208, 2 },
		{ HAR, 38.4, 47.4, 92207, 2 },
		{ HAR, 62.3, 37.1, 92226, 2 },
		{ HAR, 49.3, 75.5, 92235, 2 },
		{ HAR, 50.3, 69.7, 92234, 2 },
		{ HAR, 68.7, 36.3, 92233, 2 },
		{ HAR, 50.3, 33.6, 92232, 2 },
		{ HAR, 47.6, 47.0, 92231, 2 },
		{ HAR, 41.6, 40.1, 92230, 2 },
		{ HAR, 53.8, 59.1, 92229, 2 },
		{ HAR, 67.0, 56.6, 92228, 2 },
		{ HAR, 55.1, 32.9, 92227, 2 },
		{ HAR, 46.4, 24.9, 92225, 2 },
		{ HAR, 43.1, 39.5, 92224, 4 },
		{ HAR, 44.0, 38.1, 92223, 4 },
		{ HAR, 60.3, 17.8, 92222, 4 },
		{ HAR, 71.7, 58.8, 92221, 4 },
		{ HAR, 72.7, 57.7, 92220, 4, "Cave entrance here; moth is inside at 74.0, 57.2" },
		{ HAR, 55.6, 64.3, 92219, 4 },
		{ HAR, 55.8, 66.7, 92218, 4 },
		{ HAR, 61.5, 38.5, 92217, 4, "Cave entrance here; moth is inside at 61.3, 35.2" },
		{ HAR, 63.7, 41.4, 92216, 4 },
		{ HAR, 62.4, 40.8, 92245, 4 },
		{ HAR, 61.5, 38.5, 92244, 4, "Cave entrance here; moth is inside at 61.4, 37.1" },
		{ HAR, 46.9, 48.5, 92243, 4 },
		{ HAR, 43.3, 40.3, 92242, 4 },
		{ HAR, 42.0, 37.7, 92241, 4 },
		{ HAR, 73.7, 61.7, 92240, 4 },
		{ HAR, 73.7, 68.3, 92239, 4 },
		{ HAR, 58.6, 30.2, 92238, 4 },
		{ HAR, 51.4, 20.3, 92237, 4 },
		{ HAR, 44.8, 35.7, 92236, 4 },
		{ HAR, 54.5, 38.9, 92255, 4 },
		{ HAR, 62.5, 44.3, 92254, 4 },
		{ HAR, 60.3, 46.1, 92253, 4, "Cave entrance here; moth is inside at 60.7, 45.4" },
		{ HAR, 61.2, 50.5, 92252, 4 },
		{ HAR, 48.3, 50.6, 92251, 4 },
		{ HAR, 51.9, 76.6, 92250, 4 },
		{ HAR, 36.1, 81.4, 92249, 4 },
		{ HAR, 30.8, 63.7, 92248, 4 },
		{ HAR, 35.9, 74.3, 92247, 4 },
		{ HAR, 41.3, 66.1, 92246, 4 },
		{ HAR, 41.3, 68.1, 92265, 4 },
		{ HAR, 63.1, 58.0, 92264, 4, "Cave entrance here; moth is inside at 65.3, 57.7" },
		{ HAR, 62.5, 58.7, 92263, 4 },
		{ HAR, 64.0, 48.6, 92262, 4 },
		{ HAR, 65.9, 44.7, 92261, 4 },
		{ HAR, 72.9, 37.2, 92260, 4 },
		{ HAR, 42.2, 22.3, 92259, 4 },
		{ HAR, 54.5, 52.1, 92258, 4 },
		{ HAR, 68.0, 20.0, 92257, 4 },
		{ HAR, 37.0, 48.3, 92256, 4 },
		{ HAR, 39.1, 55.1, 92266, 4 },
		{ HAR, 39.4, 61.4, 92308, 9 },
		{ HAR, 75.8, 50.1, 92316, 9 },
		{ HAR, 69.4, 49.0, 92315, 9 },
		{ HAR, 41.1, 67.4, 92314, 9 },
		{ HAR, 40.9, 51.5, 92313, 9 },
		{ HAR, 28.8, 66.9, 92312, 9 },
		{ HAR, 62.5, 53.7, 92311, 9 },
		{ HAR, 74.1, 53.4, 92310, 9 },
		{ HAR, 56.6, 57.2, 92309, 9 },
		{ DEN, 61.9, 75.6, 92277, 9, "Inside The Den" },
		{ HAR, 44.4, 45.2, 92286, 9 },
		{ HAR, 34.6, 24.2, 92285, 9 },
		{ HAR, 47.8, 23.4, 92284, 9 },
		{ HAR, 48.5, 28.3, 92283, 9 },
		{ HAR, 56.0, 24.5, 92282, 9 },
		{ HAR, 68.3, 27.9, 92281, 9 },
		{ HAR, 72.0, 33.1, 92280, 9 },
		{ HAR, 66.5, 33.1, 92279, 9 },
		{ HAR, 43.2, 27.3, 92278, 9 },
		{ HAR, 47.3, 66.1, 92267, 9 },
		{ HAR, 46.1, 71.8, 92276, 9 },
		{ HAR, 50.1, 80.2, 92275, 9 },
		{ HAR, 54.0, 73.0, 92274, 9 },
		{ HAR, 45.0, 58.1, 92273, 9 },
		{ HAR, 67.0, 48.4, 92272, 9 },
		{ HAR, 71.2, 39.1, 92271, 9 },
		{ HAR, 54.5, 31.8, 92270, 9 },
		{ HAR, 52.4, 29.2, 92269, 9 },
		{ HAR, 47.7, 32.9, 92268, 9 },
		{ HAR, 34.5, 69.0, 92296, 9 },
		{ HAR, 34.6, 48.5, 92295, 9 },
		{ HAR, 49.0, 70.7, 92294, 9 },
		{ HAR, 48.6, 26.2, 92293, 9 },
		{ HAR, 69.3, 62.9, 92292, 9 },
		{ HAR, 71.7, 67.5, 92291, 9 },
		{ HAR, 62.6, 64.6, 92290, 9 },
		{ HAR, 65.1, 50.8, 92289, 9 },
		{ HAR, 29.8, 87.7, 92288, 9 },
		{ HAR, 27.4, 70.3, 92287, 9 },
		{ HAR, 39.2, 18.3, 92297, 9 },
		},
	},

	-------------------------------------------------------------------------
	-- Outside Quel'Thalas
	-------------------------------------------------------------------------
	{
		id = 62188, name = "More Than Just Their Roots", zone = "Old world", critByName = true,
		desc = "Talk to the Haranir who travelled to the world trees.",
		steps = {
			{ name = "Chonon",  map = 198,  x = 58.4, y = 30.0, note = "Mount Hyjal" },
			{ name = "Fuunid",  map = 2239, x = 34.2, y = 52.6, note = "Amirdrassil (Emerald Dream)" },
			{ name = "Kawayn",  map = 116,  x = 50.8, y = 42.6, note = "Grizzly Hills" },
			{ name = "Or'jan",  map = 62,   x = 33.2, y = 66.8, note = "Darkshore" },
			{ name = "Zhakir",  map = 641,  x = 46.6, y = 35.6, note = "Val'sharah" },
		},
	},

	-------------------------------------------------------------------------
	-- The Arcantina
	-------------------------------------------------------------------------
	{
		id = 61083, name = "Highly Decorated", zone = "The Arcantina",
		desc = "Take each patron's quest, fetch their keepsake, then place it in the Arcantina.",
		info = "Each keepsake object only appears while you are on (or have finished) its patron's quest. Keepsakes inside dungeons are easiest to grab while solo.",
		steps = {
			{ name = "Scarred Spear: accept 'A Favor to Axe' from Danath Trollbane", crit = "Scarred Spear", accept = 92319, map = ARC, x = 46.3, y = 56.7 },
			{ name = "Scarred Spear: loot it in Hellfire Ramparts", crit = "Scarred Spear", item = 250872, note = "Hellfire Ramparts dungeon (Hellfire Peninsula). It is to the left of the path towards Omar the Unscarred." },
			{ name = "Scarred Spear: display it", crit = "Scarred Spear", quest = 92375, map = ARC, x = 67.0, y = 52.8 },

			{ name = "Ebon Banner: accept 'A Frostbitten Tally' from Gidwin Goldbraids", crit = "Ebon Banner", accept = 92321, map = ARC, x = 37.7, y = 53.6, note = "Gidwin moves between 37.7,53.6 / 39.0,55.1 / 43.1,64.3." },
			{ name = "Ebon Banner: loot it in Icecrown Citadel", crit = "Ebon Banner", item = 250873, note = "Icecrown Citadel raid. On the left side of Lady Deathwhisper's room." },
			{ name = "Ebon Banner: display it", crit = "Ebon Banner", quest = 92376, map = ARC, x = 39.8, y = 49.7 },

			{ name = "Corrupted Lantern: accept 'Still Behind Enemy Portals' from Marius Felbane", crit = "Corrupted Lantern", accept = 92320, map = ARC, x = 59.0, y = 78.0 },
			{ name = "Corrupted Lantern: loot the corrupted chest on the Derelict Legion Vessel", crit = "Corrupted Lantern", item = 250874, map = 646, x = 50.1, y = 53.8, note = "Broken Shore. The quest takes you to the Derelict Legion Vessel; loot the 'Dark Evil Corrupted Chest of Tormented Darkness'." },
			{ name = "Corrupted Lantern: display it", crit = "Corrupted Lantern", quest = 92377, map = ARC, x = 75.3, y = 38.9 },

			{ name = "Pylon Fragment: accept 'Uncrowned's Cold Case' from Kelsey Steelspark", crit = "Pylon Fragment", accept = 92324, map = ARC, x = 78.7, y = 60.0 },
			{ name = "Pylon Fragment: loot it in Dire Maul", crit = "Pylon Fragment", item = 250877, note = "Dire Maul - Capital Gardens (Feralas). On the left side of Tendris Warpwood's room." },
			{ name = "Pylon Fragment: display it", crit = "Pylon Fragment", quest = 92380, map = ARC, x = 23.9, y = 22.0 },

			{ name = "Heavy Anchor: accept 'The Fragrance of the Dunes' from Nisha", crit = "Heavy Anchor", accept = 92326, map = ARC, x = 45.0, y = 81.4 },
			{ name = "Heavy Anchor: loot it in Vol'dun", crit = "Heavy Anchor", item = 250879, map = 864, x = 35.9, y = 36.1 },
			{ name = "Heavy Anchor: display it", crit = "Heavy Anchor", quest = 92382, map = ARC, x = 38.1, y = 73.9 },

			{ name = "Sandy Tapestry: accept 'The Fragrance of the Dunes' from Nisha", crit = "Sandy Tapestry", accept = 92326, map = ARC, x = 45.0, y = 81.4 },
			{ name = "Sandy Tapestry: loot it in Vol'dun", crit = "Sandy Tapestry", item = 250880, map = 864, x = 58.6, y = 50.3 },
			{ name = "Sandy Tapestry: display it", crit = "Sandy Tapestry", quest = 92383, map = ARC, x = 45.9, y = 82.4 },

			{ name = "Evergreen Vine: accept 'Where the Fire Once Burned' from Thisalee Crow", crit = "Evergreen Vine", accept = 92323, map = ARC, x = 76.4, y = 39.4 },
			{ name = "Evergreen Vine: loot it in the Firelands", crit = "Evergreen Vine", item = 250876, note = "Firelands raid (Mount Hyjal)." },
			{ name = "Evergreen Vine: display it", crit = "Evergreen Vine", quest = 92379, map = ARC, x = 37.2, y = 29.5 },

			{ name = "Weathered Tome: accept 'Crumbling Legacy' from Gorgonna", crit = "Weathered Tome", accept = 92325, map = ARC, x = 68.2, y = 58.5 },
			{ name = "Weathered Tome: loot it in Nagrand", crit = "Weathered Tome", item = 250878, map = 107, x = 56.3, y = 34.3 },
			{ name = "Weathered Tome: display it", crit = "Weathered Tome", quest = 92381, map = ARC, x = 62.1, y = 42.6 },

			{ name = "Clefthoof Hide: accept 'A Generational Moment' from Lord Darius Crowley", crit = "Clefthoof Hide", accept = 92327, map = ARC, x = 48.5, y = 71.4, note = "Crowley can also be at 52.1, 53.8." },
			{ name = "Clefthoof Hide: loot it in Burning Steppes", crit = "Clefthoof Hide", item = 250882, map = 36, x = 31.9, y = 34.6 },
			{ name = "Clefthoof Hide: display it", crit = "Clefthoof Hide", quest = 92385, map = ARC, x = 37.0, y = 53.0 },

			{ name = "Dried Roses: accept 'A Generational Moment' from Lord Darius Crowley", crit = "Dried Roses", accept = 92327, map = ARC, x = 48.5, y = 71.4, note = "Crowley can also be at 52.1, 53.8." },
			{ name = "Dried Roses: loot them in the Ruins of Gilneas", crit = "Dried Roses", item = 250881, map = 217, x = 55.3, y = 52.8 },
			{ name = "Dried Roses: display them", crit = "Dried Roses", quest = 92384, map = ARC, x = 41.7, y = 48.1 },

			{ name = "Ancient Zandalari Scroll: accept 'Timear Foresees a Proof of Demise!' from Archmage Lan'dalock", crit = "Ancient Zandalari Scroll", accept = 92322, map = ARC, x = 30.0, y = 19.3 },
			{ name = "Ancient Zandalari Scroll: loot it while on the quest", crit = "Ancient Zandalari Scroll", item = 250875, note = "Follow the quest objective. The scroll appears while you are on (or have finished) the quest." },
			{ name = "Ancient Zandalari Scroll: display it", crit = "Ancient Zandalari Scroll", quest = 92378, map = ARC, x = 25.8, y = 43.4 },
		},
	},
	{
		id = 61082, name = "Old Soldiers", zone = "The Arcantina",
		desc = "Finish a quest for each of the original Arcantina visitors.",
		steps = {
			{ name = "Danath Trollbane: A Favor to Axe",                    quest = 92319, map = ARC, x = 46.3, y = 56.7 },
			{ name = "Marius Felbane: Still Behind Enemy Portals",          quest = 92320, map = ARC, x = 59.0, y = 78.0 },
			{ name = "Gidwin Goldbraids: A Frostbitten Tally",              quest = 92321, map = ARC, x = 37.7, y = 53.6, note = "Gidwin moves between 37.7,53.6 / 39.0,55.1 / 43.1,64.3." },
			{ name = "Archmage Lan'dalock: Timear Foresees a Proof of Demise!", quest = 92322, map = ARC, x = 30.0, y = 19.3 },
			{ name = "Thisalee Crow: Where the Fire Once Burned",           quest = 92323, map = ARC, x = 76.4, y = 39.4 },
			{ name = "Kelsey Steelspark: Uncrowned's Cold Case",            quest = 92324, map = ARC, x = 78.7, y = 60.0 },
			{ name = "Gorgonna: Crumbling Legacy",                          quest = 92325, map = ARC, x = 68.2, y = 58.5 },
			{ name = "Nisha: The Fragrance of the Dunes",                   quest = 92326, map = ARC, x = 45.0, y = 81.4 },
			{ name = "Lord Darius Crowley: A Generational Moment",          quest = 92327, map = ARC, x = 48.5, y = 71.4 },
		},
	},
	{
		id = 63619, name = "New Friends", zone = "The Arcantina",
		desc = "Finish a quest for each of the newer Arcantina visitors.",
		steps = {
			{ name = "Vanessa VanCleef: Hope for the Orphans",  quest = 95780, map = ARC, x = 60.2, y = 50.1, note = "You'll need the Wooden Toy Sword from Shattrath City (74.2, 53.0)." },
			{ name = "Chen Stormstout: Moments in a Mug",        quest = 95779, map = ARC, x = 43.2, y = 61.5 },
		},
	},
	{
		id = 63620, name = "Well Decorated", zone = "The Arcantina",
		desc = "Fetch Chen's lantern from Stormstout Brewery and place it in the Arcantina.",
		steps = {
			{ name = "Accept 'Moments in a Mug' from Chen Stormstout", crit = "Stormstout Brewery Lantern", accept = 95779, map = ARC, x = 43.2, y = 61.5 },
			{ name = "Loot the Stormstout Brewery Lantern", crit = "Stormstout Brewery Lantern", item = 275047, note = "Stormstout Brewery dungeon (Valley of the Four Winds), in the Stormstout Brewhall." },
			{ name = "Display the lantern", crit = "Stormstout Brewery Lantern", quest = 95782, map = ARC, x = 63.6, y = 45.0 },
		},
	},
}
