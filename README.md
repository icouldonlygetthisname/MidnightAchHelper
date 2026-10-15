# Midnight Achievement Helper

A lightweight World of Warcraft addon that walks you through the **Midnight exploration achievements that only need you to collect something, go somewhere or talk to someone**. It covers the treasures, lore objects, telescopes, NPC hunts and Arcantina collections, with a waypoint for every step.

It deliberately leaves out achievements built on combat, rares, RNG, long grinds or other players (Abyss Anglers, Abundance, Vaults of Atal'Utek patrols, rares, Share a Drink and so on).

## Usage

| Command | What it does |
|---|---|
| `/mach` | Toggle the window |
| `/mach nearest` | Set a waypoint to the closest unfinished step on your continent |
| `/mach clear` | Remove the waypoint |
| `/mach list` | Print the achievements you still need |

In the window:

- **Click a step** to set a waypoint. It uses TomTom if you have it, otherwise the built-in map pin.
- **Click an achievement** to expand or collapse it. **Right-click** it to pin its nearest step. **Shift-click** it to link it in chat.
- **Hover** a step for its instructions; multi-step treasures list the full puzzle there.
- **Show completed** shows finished achievements and steps. **This zone only** shows only achievements with steps in your current zone.

When the step you're pinned to is done, the waypoint moves to the nearest remaining step of the same achievement.

## Covered achievements

**Zul'Aman:** Gnome Alone, Shadowpine Scattered, The Frog and the Princesses, Put a Pin in It, Spiritpaw Marathon, Treasures of Zul'Aman, Zul'Aman: The Highest Peaks

**Eversong Woods:** Ever Painting, Grand Magister's Sommelier, Treasures of Eversong Woods, Eversong Woods: The Highest Peaks

**Harandar:** Chronicler of the Haranir, Dust 'Em Off (all 120 moths, tagged with the renown that unlocks them), Treasures of Harandar, Harandar: The Highest Peaks, From The Cradle to the Grave

**Voidstorm:** Treasures of Voidstorm, Voidstorm: The Highest Peaks

**The Coiled Isle:** Treasures of the Coiled Isle, Student of Hissstory, The Honored Dead

**The Arcantina:** Highly Decorated, Well Decorated, Old Soldiers, New Friends

**All of Quel'Thalas / old world:** Midnight Lore Hunter, Midnight Flight Master, More Than Just Their Roots

## How progress is tracked

Each step is marked done from the game's own data: the achievement's criteria, the hidden "tracking" quest flagged when you loot or click something, quests you're on, or items in your bags. Nothing has to be ticked off by hand, and finished steps hide themselves.

## Data and credits

Coordinates, quest IDs and object IDs come from the [AllTheThings](https://github.com/ATTWoWAddon/AllTheThings) database (MIT licensed), cross-checked against Wowhead criteria names. `Data_Generated.lua` is produced by `tools/extract.lua`; see [tools/README.md](tools/README.md).

Found a wrong coordinate or a step that doesn't tick off? Please open an issue with the achievement and step name.

## License

MIT. See [LICENSE](LICENSE).
