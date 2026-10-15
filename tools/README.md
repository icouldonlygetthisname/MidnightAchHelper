# tools

`extract.lua` regenerates `Data_Generated.lua` (treasures, lore objects and vista points) from a local checkout of the [AllTheThings](https://github.com/ATTWoWAddon/AllTheThings) source.

It loads ATT's parser source files with stubbed constructors, so it needs nothing beyond Lua 5.1:

```sh
lua tools/extract.lua /path/to/AllTheThings/.contrib/Parser Data_Generated.lua
```

The script prints a step count per achievement and the flight points it found. Flight points are for reference only: `Data_Extra.lua` keeps a hand-written list, because the achievement's criteria names (taken from Wowhead) differ slightly from ATT's.

Rare achievements work differently: ATT lists rares per zone rather than under the achievement, so `rare_criteria.txt` holds each rare achievement's criteria names (`achievementID<TAB>rare name`, taken from the Armory). The extractor looks each name up among the zone's rares (ignoring titles like `<The Snapper>` and case) and warns about any it can't place. Rare kill quests are daily, so no quest ID is emitted; the addon tracks rares through the achievement criteria.

To add another treasure, lore or vista achievement, add its ID to `WANTED` in `extract.lua`, add its zone's file to `files` if needed, re-run the script, then add an entry in `Data_Extra.lua` that uses `Gen(<id>)`.

This folder is excluded from CurseForge packages by `.pkgmeta`.
