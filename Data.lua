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
		info = "The writings are small paper and scroll objects lying on the ground, often tucked under huts or spikes, so they are easy to walk past. Hover each step for exactly where to look.",
		steps = {
			{ name = "Discarded Scroll",       obj = 633820, map = ZUL, x = 45.9, y = 66.0, note = "In Amani'Zar Village. It's on the ground UNDER the raised hut, next to a supporting post and hidden behind red ferns." },
			{ name = "Hastily-Scribbled Note", obj = 633805, map = ZUL, x = 46.4, y = 41.3, note = "Not inside the hut - it's outside at the back. Easiest route: enter the hut and jump out of the window on your right; the note is on your left, under the second wooden spike." },
			{ name = "Message in a Bottle",    obj = 633792, map = ZUL, x = 54.9, y = 32.4, note = "At the north end of the little beach, right on the waterline." },
			{ name = "Moldy Diary Found",      obj = 633815, map = ZUL, x = 35.7, y = 25.2, note = "Inside the hut, under the hammock Da Piper is sleeping on. Da Piper and the diary only appear once you're past the bridge cutscene early in the 12.1 Zul'Aman quests." },
			{ name = "Parting Note",           obj = 633823, map = ZUL, x = 34.8, y = 17.2, note = "A flat piece of paper on a rock at one end of the docks." },
			{ name = "Scrap of Singed Paper",  obj = 633814, map = ZUL, x = 54.3, y = 20.6, note = "At the Temple of Jan'alai." },
		},
	},
	{
		id = 61455, name = "Shadowpine Scattered", zone = "Zul'Aman", critByName = true,
		desc = "Find and talk to each Shadowpine Songseeker.",
		steps = {
			{ name = "Songseeker Baz'wa",   npc = 254808, map = ZUL, x = 52.7, y = 79.3, note = "Only appears after you finish the Zul'Aman campaign." },
			{ name = "Songseeker Dova",     npc = 254839, map = ZUL, x = 39.2, y = 56.4 },
			{ name = "Songseeker Far'lan",  npc = 254807, map = ZUL, x = 47.3, y = 81.9, note = "Sitting on top of a rock." },
			{ name = "Songseeker Ikaja",    npc = 254841, map = ZUL, x = 55.2, y = 18.1, note = "On the roof of the Temple of Jan'alai - fly up to the top." },
			{ name = "Songseeker Jebanda",  npc = 254840, map = ZUL, x = 31.6, y = 38.1, note = "Walks the road with a group of Shadowpine Travelers. Fly to this point, then follow the road south (towards 31.6, 46.5) until you spot her." },
		},
	},
	{
		id = 62201, name = "The Frog and the Princesses", zone = "Zul'Aman", critByName = true,
		desc = "Target each 'princess' frog and type /kiss.",
		steps = {
			{ name = "Princess Fita",    npc = 258937, map = ZUL,  x = 31.7, y = 22.6, note = "A small frog - target it (or /tar Princess Fita) and type /kiss." },
			{ name = "Princess Gabiku",  npc = 259684, map = ZUL,  x = 68.3, y = 19.3, note = "A small frog - target it (or /tar Princess Gabiku) and type /kiss." },
			{ name = "Princess Jakobu",  npc = 259682, map = ATAL, x = 27.5, y = 40.1, note = "In Atal'Aman. A small frog - target it (or /tar Princess Jakobu) and type /kiss." },
			{ name = "Princess Tafiki",  npc = 259683, map = ZUL,  x = 53.9, y = 59.6, note = "A small frog - target it (or /tar Princess Tafiki) and type /kiss." },
			{ name = "Princess Zambina", npc = 259685, map = ZUL,  x = 29.8, y = 79.1, note = "A small frog - target it (or /tar Princess Zambina) and type /kiss." },
		},
	},
	{
		id = 62199, name = "Put a Pin in It", zone = "Zul'Aman", ordered = true,
		desc = "Find Chu'ke the possessed doll, fetch its button, then meet it again.",
		info = "Must be done in order: each step only works after the previous one.",
		steps = {
			{ name = "Talk to Chu'ke on a tiny island off the east coast", npc = 258933, crit = "Chu'ke found", quest = 95005, map = ZUL, x = 58.8, y = 70.4, note = "A small doll on a tiny island off the east coast, near Amani'Zar Village. Talk to him; he then leaves for the southwest beach." },
			{ name = "Get the button from Kalika in Witherbark Bluffs", obj = 627489, crit = "Chu'ke joined", quest = 95045, map = ZUL, x = 38.7, y = 23.9, note = "Anyone can do this - you don't need Tailoring. In the round hut, talk to Kalika (the Tailoring trainer) and pick 'I need a button that is about the size of an eye.' The button only appears AFTER she answers '...Just take it. There be one in the corner.' It's a tiny bronze 'Forgotten Button' (looks like a coin) on the floor: behind the jade eagle statue to her right, bottom-left of the three boxes. Stand by the statue and press your Interact key (Options > Keybindings > Targeting) if you can't see it. Still nothing? /reload or relog in case you're out of phase. Picking it up gives NO message or item - it worked if Kalika no longer mentions the button. This step may not tick off by itself: Alt-click it to mark it done, then go to Chu'ke." },
			{ name = "Talk to Chu'ke again on the southwest beach", npc = 258933, crit = "Chu'ke joined", quest = 95046, map = ZUL, x = 37.8, y = 90.1, note = "Funerary Coast. He's by the drum, among a collection of possessed dolls on the southern shore. Pick 'Yes, go ahead.' to get the achievement." },
		},
	},
	{
		id = 62202, name = "Spiritpaw Marathon", zone = "Zul'Aman", ordered = true,
		desc = "Carry a Kapara Pup from Feevra to the Shrine of Filo without mounting.",
		info = "Mounting drops the pup and fails the run. Ghost Wolf, Divine Steed, druid travel/flight form, Stealth and a Goblin Glider all keep it. You have 30 minutes; the walk takes about 5.",
		steps = {
			{ name = "Talk to Feevra, then pick up the Kapara Pup", npc = 258938, crit = "Spiritpaw Runner found", quest = 95450, map = ZUL, x = 32.3, y = 22.4, note = "Talk to the furbolg Feevra and ask if they need help. Then click the Kapara Pup sitting in front of them, just behind the tree (32.2, 22.3). You'll carry it on your head." },
			{ name = "Walk the pup to the Shrine of Filo", crit = "Run completed", quest = 95450, map = ZUL, x = 51.5, y = 32.8, note = "Do NOT mount. Stick to the path and you shouldn't get attacked." },
		},
	},

	-------------------------------------------------------------------------
	-- Eversong Woods
	-------------------------------------------------------------------------
	{
		id = 62185, name = "Ever Painting", zone = "Eversong Woods", critByName = true,
		desc = "Click each painter's easel found outdoors.",
		info = "Each easel stands next to an apprentice painter NPC (look for a 'Plein Air Painter' nametag). Coming from Silvermoon, a good order is: Anar'alah Belore, Lost Lamppost, Elrendar's Song, Babble and Brook, Light Consuming, Sway of Red and Gold, Memories of Ghosts.",
		steps = {
			{ name = "Anar'alah Belore",     obj = 621762, map = EVE, x = 50.8, y = 41.3 },
			{ name = "Babble and Brook",     obj = 621700, map = EVE, x = 46.1, y = 64.3, note = "Also reported at 45.3, 63.9." },
			{ name = "Elrendar's Song",      obj = 621711, map = EVE, x = 42.6, y = 62.6 },
			{ name = "Light Consuming",      obj = 621732, map = EVE, x = 55.1, y = 59.7, note = "Up on a platform, not on the ground." },
			{ name = "Lost Lamppost",        obj = 621734, map = EVE, x = 41.8, y = 56.3, note = "The hardest one. Follow the path west from Runestone Falithas into the lightbloom to a big rock in the middle of the path. Turn southwest to a big tree: the painter is hiding at its base behind yellow plants/bushes. If you can't see the rock, you've gone too far." },
			{ name = "Memories of Ghosts",   obj = 621709, map = EVE, x = 39.0, y = 78.2 },
			{ name = "Sway of Red and Gold", obj = 621707, map = EVE, x = 54.0, y = 75.6 },
		},
	},
	{
		id = 62187, name = "Grand Magister's Sommelier", zone = "Eversong Woods", critByName = true,
		desc = "Talk to every drink vendor during 'Special Assignment: The Grand Magister's Drink'.",
		info = "1) Unlock it: complete 3 Eversong Woods world quests to unlock the Special Assignment 'The Grand Magister's Drink' (40.7, 61.2). Assignments rotate, so it must be the active one; the unlock reportedly needs a level 90, but alts from 80 can then do it.\n2) Join a Raid group BEFORE talking to anyone. In a raid the quest doesn't progress (so it won't end after 3 drinks) but every tasting still counts - you can do all 12 in one go.\n3) Talk to each listed vendor and ask for a tasting; it counts immediately. Hover each drink for which NPC it is - they're normal vendors, and the NPCs standing along the road are NOT the ones you need. The tasting option only appears while the Special Assignment is active.\nTurn off quest-automation addons (e.g. Zygor auto-select) so they don't pick dialog for you.",
		steps = {
			{ name = "Heron's Vision of Cloudwalking",   npc = 249861, map = EVE, x = 39.4, y = 60.2, note = "Talk to Heron Skygaze (food & drink vendor)." },
			{ name = "Areyn's Elrendar Red",             npc = 249879, map = EVE, x = 39.3, y = 61.4, note = "Talk to Innkeeper Areyn." },
			{ name = "Kreynna's Khadgar's Imitation",    npc = 251409, map = EVE, x = 40.7, y = 59.5, note = "Talk to Kyrenna, the cheese vendor, up on the floating platform." },
			{ name = "Lady Marilin's Arcwine Reserve",   npc = 252649, map = EVE, x = 40.3, y = 61.2, note = "Talk to Lady Marilin, on the middle floor." },
			{ name = "Landraelanis' Muskmelon Draught",  npc = 251406, map = EVE, x = 41.5, y = 61.3, note = "Talk to Landraelanis (Tradesman), on the upper floor." },
			{ name = "Limien's Arcane Infusion",         npc = 249426, map = EVE, x = 40.7, y = 60.1, note = "Talk to Limien Bountcask (Fine Vintages), outside." },
			{ name = "Duskwither's Dancing Merlot",      npc = 249862, map = EVE, x = 38.3, y = 58.4, note = "Talk to Magister Duskwither. He's out by the runestone, not in the village with the others." },
			{ name = "Nara's Essence of Butterfly",      npc = 249437, map = EVE, x = 39.6, y = 60.6, note = "Talk to Nara Fadebranch (forage goods)." },
			{ name = "Quarelestra's Sanguine Affair",    npc = 251408, map = EVE, x = 39.8, y = 60.9, note = "Talk to Quarelestra (Cooking trainer), outside." },
			{ name = "Sheri's Laughing Rose",            npc = 251405, map = EVE, x = 40.8, y = 60.5, note = "Talk to Sheri (general goods), up on the floating platform." },
			{ name = "Vehn's Shimmerveil Blanc",         npc = 249436, map = EVE, x = 39.3, y = 61.1, note = "Talk to Vehn Sorrelstride (Alchemical Oddities), outside." },
			{ name = "Zalene's Twilight Claret",         npc = 249882, map = EVE, x = 40.3, y = 61.5, note = "Talk to Zalene Firstlight (food & drink vendor)." },
		},
	},

	-------------------------------------------------------------------------
	-- Harandar
	-------------------------------------------------------------------------
	{
		id = 61344, name = "Chronicler of the Haranir", zone = "Harandar", critByName = true,
		desc = "Click the lore objects that belong to each Legend of the Haranir.",
		info = "Lore objects only appear while you are on that legend's quest (including its dream-phase Vision Walk), so grab all three before you turn the quest in. Pick a legend each week from Zur'ashar Kassameh (54.2, 53.1) through 'Lost Legends'. Missed one? After all the legends have rotated, the weekly lets you redo a legend you've already done.",
		steps = {
			{ name = "Echoes of Our Past--Part 1: Fading History",      obj = 579236, quest = 93475, map = HAR, x = 60.0, y = 20.9, note = "Legend: The Cauldron of Echoes. Outside, before the cave." },
			{ name = "Echoes of Our Past--Part 2: Alndust",             obj = 579237, quest = 93474, map = HAR, x = 59.8, y = 18.5, note = "Legend: The Cauldron of Echoes. Inside the cave." },
			{ name = "Echoes of Our Past--Part 3: Dangerous Memories",  obj = 579238, quest = 93473, map = HAR, x = 61.2, y = 16.0, note = "Legend: The Cauldron of Echoes. Inside the cave, on the 2nd floor at the top." },
			{ name = "Lament of Wey'nan--Part 1: Finding Hope",         obj = 579233, quest = 93470, map = HAR, x = 43.2, y = 37.4, note = "Legend: Wey'nan's Ward." },
			{ name = "Lament of Wey'nan--Part 2: Hunting Purpose",      obj = 579234, quest = 93471, map = HAR, x = 41.5, y = 35.8, note = "Legend: Wey'nan's Ward. Inside the cave after Part 1." },
			{ name = "Lament of Wey'nan--Part 3: There Must Be More",   obj = 579235, quest = 93472, map = HAR, x = 42.3, y = 35.5, note = "Legend: Wey'nan's Ward. In the cave, up the ramp on the left of Part 2." },
			{ name = "Seeker's Trail--Part 1: Call of Aln'hara",        obj = 579239, quest = 93479, map = HAR, x = 53.4, y = 66.9, note = "Legend: Aln'hara's Bloom." },
			{ name = "Seeker's Trail--Part 2: Seeking Peace",           obj = 579240, quest = 93478, map = HAR, x = 54.9, y = 66.7, note = "Legend: Aln'hara's Bloom." },
			{ name = "Seeker's Trail--Part 3: Unending Mission",        obj = 579241, quest = 93476, map = HAR, x = 57.3, y = 66.4, note = "Legend: Aln'hara's Bloom. Inside a cave." },
			{ name = "Tending the Lands--Part 1: The Conflict",         obj = 579242, quest = 93485, map = HAR, x = 63.4, y = 40.1, note = "Legend: Russula's Outreach." },
			{ name = "Tending the Lands--Part 2: The Plan",             obj = 579243, quest = 93484, map = HAR, x = 61.1, y = 39.0, note = "Legend: Russula's Outreach." },
			{ name = "Tending the Lands--Part 3: The Cycle",            obj = 579244, quest = 93483, map = HAR, x = 61.4, y = 37.1, note = "Legend: Russula's Outreach." },
			{ name = "Words of Obayo--Part 1: The Flame",               obj = 579123, quest = 93482, map = HAR, x = 64.9, y = 38.4, note = "Legend: The Echoless Flame." },
			{ name = "Words of Obayo--Part 2: The Rift",                obj = 579130, quest = 93481, map = HAR, x = 62.7, y = 34.5, note = "Legend: The Echoless Flame. Inside a cave." },
			{ name = "Words of Obayo--Part 3: The Silence",             obj = 579131, quest = 93480, map = HAR, x = 62.7, y = 35.9, note = "Legend: The Echoless Flame. Inside the same cave." },
			{ name = "Ways of the Roots--Part 1: Serving",              obj = 579180, quest = 93488, map = HAR, x = 40.8, y = 36.3, note = "Legend: Root of the World. All three are inside the cave." },
			{ name = "Ways of the Roots--Part 2: Growing",              obj = 579182, quest = 93487, map = HAR, x = 41.5, y = 34.2, note = "Legend: Root of the World. Inside the cave." },
			{ name = "Ways of the Roots--Part 3: Pruning",              obj = 579183, quest = 93486, map = HAR, x = 40.5, y = 34.7, note = "Legend: Root of the World. Inside the cave: at quest stage 4, follow the scent trail but turn left." },
			{ name = "Awe'ohna's Path--Part 1: Questions",              obj = 579201, quest = 93491, map = HAR, x = 71.9, y = 58.9, note = "Legend: Sky's Hope. Outside in the open." },
			{ name = "Awe'ohna's Path--Part 2: Answers",                obj = 579202, quest = 93490, map = HAR, x = 73.5, y = 58.2, note = "Legend: Sky's Hope. Inside the caves (entrance at 72.8, 57.7)." },
			{ name = "Awe'ohna's Path--Part 3: The Cradle",             obj = 579203, quest = 93489, map = HAR, x = 73.5, y = 57.4, note = "Legend: Sky's Hope. Inside the caves, on the ramp up to the 2nd NPC you talk to in stage 2." },
		},
	},
	{
		id = 61052, name = "Dust 'Em Off", zone = "Harandar",
		desc = "Catch all 120 Glowing Moths.",
		info = "Moths are small glowing objects and unlock in batches with Hara'ti renown: about 40 from Renown 1-2, 40 more from Renown 4-5 and the last 40 from Renown 9. They only show on the minimap from Renown 2 / 6 / 11. Hit Renown 9 first and then do them all in one sweep. Mothkeeper Wew'tam (49.3, 54.3) has rewards every 10 moths.",
		-- Wowhead object IDs, same order as moths
		mothObjects = {
			571099, 571121, 571122, 571123, 571124, 571125, 571126, 571127, 571128, 571129,
			571130, 571131, 571132, 571133, 571134, 571135, 571136, 571137, 571138, 571139,
			571140, 571141, 571142, 571143, 571144, 571145, 571146, 571147, 571148, 571149,
			571150, 571151, 571152, 571153, 571154, 571155, 571156, 571157, 571158, 571159,
			571162, 571163, 571164, 571165, 571166, 571167, 571168, 571169, 571170, 571171,
			571172, 571173, 571174, 571175, 571176, 571177, 571178, 571179, 571180, 571181,
			571264, 571265, 571266, 571267, 571268, 571269, 571270, 571271, 571272, 571273,
			571274, 571275, 571276, 571277, 571278, 571279, 571280, 571281, 571282, 571283,
			571289, 571290, 571291, 571292, 571293, 571294, 571295, 571296, 571297, 571298,
			571299, 571300, 571301, 571302, 571303, 571304, 571305, 571306, 571307, 571308,
			571310, 571311, 571312, 571313, 571314, 571315, 571316, 571317, 571318, 571319,
			571320, 571321, 571322, 571323, 571324, 571325, 571326, 571327, 571328, 571329,
		},
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
			{ name = "Chonon",  npc = 245103, map = 198,  x = 58.5, y = 30.0, note = "Mount Hyjal. High up on the roots of Nordrassil, not on the ground: fly up to the roots just before the trunk turns straight. Phasing: if you can't see him, try another character (old Hyjal quest progress can hide him)." },
			{ name = "Fuunid",  npc = 245107, map = 2239, x = 34.2, y = 52.6, note = "Amirdrassil. Sitting UP on the world tree, on a big branch with purple leaves above the marker." },
			{ name = "Kawayn",  npc = 251936, map = 116,  x = 50.8, y = 42.6, note = "Grizzly Hills. On top of the fallen tree lying on its side (not the middle part with the furbolgs), so fly up. Look for the grey branch of the world tree overhanging the leafy tree." },
			{ name = "Or'jan",  npc = 245105, map = 62,   x = 33.2, y = 66.8, note = "Darkshore. Reports differ on which Darkshore phase he's in; if he isn't there, try a character in the other phase." },
			{ name = "Zhakir",  npc = 245106, map = 641,  x = 46.7, y = 35.4, note = "Val'sharah. In front of the druid class hall entrance, next to a small lake." },
		},
	},

	-------------------------------------------------------------------------
	-- The Arcantina
	-------------------------------------------------------------------------
	{
		id = 61083, name = "Highly Decorated", zone = "The Arcantina", ordered = "crit",
		desc = "Take each patron's quest, fetch their keepsake, then place it in the Arcantina.",
		info = "Each keepsake object only appears while you are on (or have finished) its patron's quest. Keepsakes inside dungeons are easiest to grab while solo.",
		steps = {
			{ name = "Scarred Spear: accept 'A Favor to Axe' from Danath Trollbane", crit = "Scarred Spear", accept = 92319, map = ARC, x = 46.3, y = 56.7 },
			{ name = "Scarred Spear: loot it in Hellfire Ramparts", crit = "Scarred Spear", item = 250872, obj = 572029, inside = "Hellfire Ramparts", map = 100, x = 47.7, y = 53.6, note = "Hellfire Ramparts dungeon (Hellfire Peninsula). Kill the first boss, go up to the next floor; it's on the platform between the second and last boss, left of the path. You can still grab it after turning the quest in." },
			{ name = "Scarred Spear: display it", crit = "Scarred Spear", quest = 92375, map = ARC, x = 67.0, y = 52.8, note = "In the right-side room of the Arcantina." },

			{ name = "Ebon Banner: accept 'A Frostbitten Tally' from Gidwin Goldbraids", crit = "Ebon Banner", accept = 92321, map = ARC, x = 37.7, y = 53.6, note = "Gidwin moves between 37.7,53.6 / 39.0,55.1 / 43.1,64.3." },
			{ name = "Ebon Banner: loot it in Icecrown Citadel", crit = "Ebon Banner", item = 250873, obj = 572030, inside = "Icecrown Citadel", map = 118, x = 53.7, y = 87.0, note = "Icecrown Citadel raid. On the left side of Lady Deathwhisper's boss room." },
			{ name = "Ebon Banner: display it", crit = "Ebon Banner", quest = 92376, map = ARC, x = 39.8, y = 49.7 },

			{ name = "Corrupted Lantern: accept 'Still Behind Enemy Portals' from Marius Felbane", crit = "Corrupted Lantern", accept = 92320, map = ARC, x = 59.0, y = 78.0 },
			{ name = "Corrupted Lantern: loot the corrupted chest on the Derelict Legion Vessel", crit = "Corrupted Lantern", item = 250874, obj = 613535, map = 646, x = 50.1, y = 53.8, note = "Broken Shore. The quest takes you to the Derelict Legion Vessel: the 'Dark Evil Corrupted Chest of Tormented Darkness' is at the top of the vessel after crossing the tops of the boxes. Did the quest before the hotfix and have no lantern? Pick up another at 48.9, 55.2 on the Broken Shore." },
			{ name = "Corrupted Lantern: display it", crit = "Corrupted Lantern", quest = 92377, map = ARC, x = 75.3, y = 38.9 },

			{ name = "Pylon Fragment: accept 'Uncrowned's Cold Case' from Kelsey Steelspark", crit = "Pylon Fragment", accept = 92324, map = ARC, x = 78.7, y = 60.0 },
			{ name = "Pylon Fragment: loot it in Dire Maul", crit = "Pylon Fragment", item = 250877, obj = 572034, inside = "Dire Maul West", map = 69, x = 60.3, y = 30.2, note = "Dire Maul West - Capital Gardens (Feralas). Run straight down the ramp to the first boss, Tendris Warpwood; the fragment is on your left (the boss's right), in the corner next to some rocks. It's marked on the dungeon map." },
			{ name = "Pylon Fragment: display it", crit = "Pylon Fragment", quest = 92380, map = ARC, x = 23.9, y = 22.0 },

			{ name = "Heavy Anchor: accept 'The Fragrance of the Dunes' from Nisha", crit = "Heavy Anchor", accept = 92326, map = ARC, x = 45.0, y = 81.4 },
			{ name = "Heavy Anchor: loot it in Vol'dun", obj = 572036, crit = "Heavy Anchor", item = 250879, map = 864, x = 35.9, y = 36.1, note = "Leaning against a small boat on the coast near the Alliance harbour. Marked on your map while on the quest." },
			{ name = "Heavy Anchor: display it", crit = "Heavy Anchor", quest = 92382, map = ARC, x = 38.1, y = 73.9 },

			{ name = "Sandy Tapestry: accept 'The Fragrance of the Dunes' from Nisha", crit = "Sandy Tapestry", accept = 92326, map = ARC, x = 45.0, y = 81.4 },
			{ name = "Sandy Tapestry: loot it in Vol'dun", obj = 572037, crit = "Sandy Tapestry", item = 250880, map = 864, x = 58.6, y = 50.3, note = "Just east of the Vulpera Hideaway, past some lizard mobs. Marked on your map while on the quest." },
			{ name = "Sandy Tapestry: display it", crit = "Sandy Tapestry", quest = 92383, map = ARC, x = 45.9, y = 82.4 },

			{ name = "Evergreen Vine: accept 'Where the Fire Once Burned' from Thisalee Crow", crit = "Evergreen Vine", accept = 92323, map = ARC, x = 76.4, y = 39.4 },
			{ name = "Evergreen Vine: loot it in the Firelands", crit = "Evergreen Vine", item = 250876, obj = 572033, inside = "Firelands", map = 198, x = 47.3, y = 78.1, note = "Firelands raid. Up the Path of Corruption in the north-west corner, at the Circle of Thorns (about 27.1, 24.4 on the raid map)." },
			{ name = "Evergreen Vine: display it", crit = "Evergreen Vine", quest = 92379, map = ARC, x = 37.2, y = 29.5 },

			{ name = "Weathered Tome: accept 'Crumbling Legacy' from Gorgonna", crit = "Weathered Tome", accept = 92325, map = ARC, x = 68.2, y = 58.5 },
			{ name = "Weathered Tome: loot it in Nagrand", obj = 572035, crit = "Weathered Tome", item = 250878, map = 107, x = 56.3, y = 34.3, note = "Garadar, Outland Nagrand. Right next to Grandmother Geyah, on the outer wall of the hut by the crates and bags." },
			{ name = "Weathered Tome: display it", crit = "Weathered Tome", quest = 92381, map = ARC, x = 62.1, y = 42.6 },

			{ name = "Clefthoof Hide: accept 'A Generational Moment' from Lord Darius Crowley", crit = "Clefthoof Hide", accept = 92327, map = ARC, x = 48.5, y = 71.4, note = "Crowley can also be at 52.1, 53.8." },
			{ name = "Clefthoof Hide: loot it in Burning Steppes", crit = "Clefthoof Hide", item = 250882, map = 36, x = 31.9, y = 34.6 },
			{ name = "Clefthoof Hide: display it", crit = "Clefthoof Hide", quest = 92385, map = ARC, x = 37.0, y = 53.0 },

			{ name = "Dried Roses: accept 'A Generational Moment' from Lord Darius Crowley", crit = "Dried Roses", accept = 92327, map = ARC, x = 48.5, y = 71.4, note = "Crowley can also be at 52.1, 53.8." },
			{ name = "Dried Roses: loot them in the Ruins of Gilneas", crit = "Dried Roses", item = 250881, map = 217, x = 55.3, y = 52.8 },
			{ name = "Dried Roses: display them", crit = "Dried Roses", quest = 92384, map = ARC, x = 41.7, y = 48.1 },

			{ name = "Ancient Zandalari Scroll: accept 'Timear Foresees a Proof of Demise!' from Archmage Lan'dalock", crit = "Ancient Zandalari Scroll", accept = 92322, map = ARC, x = 30.0, y = 19.3 },
			{ name = "Ancient Zandalari Scroll: loot it in Throne of Thunder", obj = 572032, crit = "Ancient Zandalari Scroll", item = 250875, inside = "Throne of Thunder", map = 504, x = 63.4, y = 32.6, note = "Throne of Thunder raid (Isle of Thunder). After the first boss, in the hallway before the wind bridges. The quest item itself drops from the 3rd boss (the council)." },
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
		id = 63620, name = "Well Decorated", zone = "The Arcantina", ordered = true,
		desc = "Fetch Chen's lantern from Stormstout Brewery and place it in the Arcantina.",
		steps = {
			{ name = "Accept 'Moments in a Mug' from Chen Stormstout", crit = "Stormstout Brewery Lantern", accept = 95779, map = ARC, x = 43.2, y = 61.5 },
			{ name = "Loot the Stormstout Brewery Lantern", crit = "Stormstout Brewery Lantern", item = 275047, obj = 654977, inside = "Stormstout Brewery", map = 376, x = 36.0, y = 69.0, note = "Stormstout Brewery dungeon (Valley of the Four Winds). Just past the first boss, hanging in a doorway." },
			{ name = "Display the lantern", crit = "Stormstout Brewery Lantern", quest = 95782, map = ARC, x = 63.3, y = 44.8, note = "Over the doorway between the main room and the rear-right room. The placeholder only shows while the lantern is in your bags." },
		},
	},
}
