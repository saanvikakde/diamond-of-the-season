# Diamond of the Season: Game Design Doc (V1)

Engine: Roblox (Luau). Audience: teens 13-17. Genre: social progression RPG.

## Core concept
A Bridgerton-inspired game where players climb social ranks, build stats, and compete to earn the Diamond of the Season title. Real progression mechanics, not freeform roleplay.

## Stats
- **Charm**: equipped-based. Sum of `charm` on currently worn items. Computed, never stored.
- **Grace**: persistent counter. Earned through activities (Tea Parlor, Garden Promenade, quests).
- **Wit**: persistent counter. Earned through Etiquette Quiz and Library studying.
- **Score** = Charm + Grace + Wit. No hidden formula.

## Ranks
| Rank | Title | Unlocks |
|---|---|---|
| 1-2 | Debutante | Village Commons |
| 3-5 | Lady of Note | Manor Gardens |
| 6-9 | Diamond Candidate | Grand Ballroom |
| 10 | Diamond of the Season | Crown cosmetic, Wall of Fame |

## Locations
**Village Commons** (rank 1): Tailor Shop + Fitting Room (buy/equip), Welcome NPC (tutorial), Gossip Board (rumors, leaderboard, next event), Tea Parlor (sit near another player → passive Grace), Town Crier (one daily quest).

**Manor Gardens** (rank 3): Library (study → Wit), Grace activity (see open questions).

**Grand Ballroom** (rank 6): Etiquette Quiz (every 15 min, 10 questions, 15 s each, top scorer gets Wit bonus + season points), Diamond Wall of Fame.

## Monetization (design for now, build later)
Premium outfits (Robux, higher Charm, capped), Season Pass (bonus quests, title frames, XP boost), Noble Title gamepass ("Lady [name]", cosmetic only).

## Cut from V1
Social Vote (abuse risk, no moderation capacity). Dance mini-game (animation cost; top priority for V1.5).

---

## Open questions with proposed defaults

Agents: build with the proposed default and flag it. Saanvi: change any of these by editing the line and saying so.

1. **Rank vs score scale.** "Rank = total stat score" but ranks go 1-10, while stat totals will be in the hundreds.
   *Proposed default:* Score is the sum; Rank is a tier looked up from score thresholds in `Config.luau` (starting values: 0, 20, 50, 90, 140, 200, 280, 380, 500, 650 for ranks 1-10). Still no hidden formula, just a visible table.

2. **Rank can drop when you take clothes off.** Charm is equipped-based, so removing an outfit lowers score and rank, which could lock someone out of the Ballroom mid-visit.
   *Proposed default:* Store `peakRank`. Zone access uses `peakRank`. The displayed live rank and leaderboard use current score.

3. **Currency for the Tailor Shop.** Outfits need a non-Robux price.
   *Proposed default:* "Pin Money" soft currency. Earned from daily quests, quiz participation, and small trickle from activities. Stored in DataStore.

4. **What makes someone *the* Diamond?** Rank 10 is a threshold many players could hit, but the Wall of Fame implies one winner.
   *Proposed default:* Rank 10 makes you a Diamond contender and gives the Crown. Each season (4 weeks) the contender with the most **season points** (earned from quiz wins, daily quests, placements) is crowned Diamond of the Season and added to the Wall of Fame. Stats persist across seasons; season points reset.

5. **Manor Gardens Grace activity (TBD).**
   *Proposed default:* "Garden Promenade": walk a looped path through 6 checkpoint arches in order within a time limit. +Grace per lap, 60 s cooldown. Zero animation work; Saanvi builds the arches.

6. **Tea Parlor rules.**
   *Proposed default:* While 2+ players are inside the TeaParlor zone, each gets +1 Grace every 30 s, capped at 40 Grace per day from tea.

7. **Library rules.**
   *Proposed default:* ProximityPrompt on a desk, 20 s hold/study, +2 Wit, 45 s cooldown, cap 40 Wit/day from studying.

8. **Quiz rewards.**
   *Proposed default:* +1 Wit per correct answer for everyone, top scorer +10 Wit and +5 season points, ties all get the bonus. Answer speed breaks nothing in V1 (simpler, fewer edge cases).

9. **Leaderboard scope.** Per server or global?
   *Proposed default:* Gossip Board shows global top 10 by season points (OrderedDataStore, refreshed every 60 s) plus a "this room" list.
