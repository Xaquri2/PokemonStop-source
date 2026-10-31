Run the progression regression checks from the repository root:

```sh
node tests/progression.cjs
node tests/party-items.cjs
node tests/save-effects.cjs
```

The party-item checks cover Rare Candy's one-level gain, move learning, level-100
limit, fainted targets, battle stat updates, Full Restore status recovery, and
healing benched Pokemon without changing the active Pokemon's HP.

The save-effect checks round-trip area keys, nest return rooms, and Morlock
potion countdowns through all five slots, and check defaults for older saves.

The checks execute selected GML functions through JavaScript adapters and inspect
the encounter and trainer tables. They cover XP overflow, bulk/animated award
equivalence, the level-100 cap, later moves, replacement/decline handling, wild
levels by badge count, and all 75 Dark Tower opponents.

They do not compile the GameMaker project or simulate an entire battle. Playtest
level-up prompts during a trainer battle and on the final knockout, recruitment
after each badge, tower floor transitions, and the unchanged level-40 Godzilla
fight before treating these initial balance targets as final.

Current progression targets:

| Area | Level range |
| --- | --- |
| Mallet Town wild encounters | 1–2 |
| Lower Route Minus One wild encounters | 2–4 |
| Upper Route Minus One wild encounters | 4–7, plus 3 per earned badge |
| Mutant / Shadow / Robot Path wild encounters | 7–10, plus 3 per earned badge |
| Dark Tower floor 1 | 20–23 |
| Dark Tower floor 2 | 23–26 |
| Dark Tower floor 3 | 26–29 |
| Dark Tower floor 4 | 29–32 |

Other wild encounter locations keep a default range of 3–5; key-area nest
encounters retain their separately authored level 25. Existing early moves are
preserved, with two additional moves at levels 24 and 32 for 64 species.
Godzilla and the intentionally inert Green Bubble keep their existing learnsets.
Exp All and participation eligibility are unchanged.
