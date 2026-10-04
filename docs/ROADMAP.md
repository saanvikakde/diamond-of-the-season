# V1 Roadmap

One milestone per `/next` run. Each one should be playable/checkable in Studio on its own. Ticked = Saanvi playtested it.

## Foundation
- [ ] **M0 Bootstrap.** Server/client init scripts that load services/controllers in order, `Remotes.luau`, `Config.luau`, a debug print on join. *Accept:* Play in Studio, output shows each service Init/Start once, no errors.
- [ ] **M1 Player data.** `DataService`: load/save with UpdateAsync, retries, versioned schema + migration, autosave, BindToClose, safe fallback when DataStore is unavailable. Schema: grace, wit, pinMoney, inventory, equipped, peakRank, seasonPoints, dailyQuest, tutorialDone, version. *Accept:* Values persist across rejoin in Studio (API access on). With API access off, game still runs and logs a warning.
- [ ] **M2 Stats + rank.** `StatLogic` (score, rank tier, title from score), `StatService` (add grace/wit, recompute, update peakRank), leaderstats showing Rank and Title, a minimal HUD (Charm/Grace/Wit/Rank). Admin-only debug command to add stats in Studio. *Accept:* Debug +Grace updates HUD and rank tier at exact thresholds.

## Village Commons
- [ ] **M3 Tailor Shop.** `Items.luau` placeholder catalog, `CharmLogic`, `ShopService` (buy with Pin Money, validate price/rank/ownership), equip/unequip per slot, Charm recomputed. Shop UI opened by ProximityPrompt at `workspace.Map.VillageCommons.TailorShop.Counter`. Items are data-only for now (no 3D accessories yet). *Accept:* Buy, equip, unequip; Charm and rank change; persists on rejoin.
- [ ] **M4 Zone gating.** Barrier/teleport doors for Manor Gardens and Grand Ballroom using `peakRank`. Friendly "You must be a Lady of Note" message. *Accept:* Low-rank player bounced, high-rank player passes, can't bypass by firing a remote.
- [ ] **M5 Dialogue + Welcome NPC tutorial.** Reusable `DialogueController` (text box, next button, choices). Tutorial quest: talk, visit Tailor, equip something, read Gossip Board. Rewards Pin Money once. *Accept:* New player completes tutorial once; rejoining doesn't repeat it.
- [ ] **M6 Town Crier daily quest.** `QuestLogic` (UTC day rollover, progress, completion), `QuestService`, objective hooks, quest UI. *Accept:* Quest assigned, progress tracks, reward once, new quest next UTC day (test via debug time offset).
- [ ] **M7 Tea Parlor.** Zone detection, 2+ players present → Grace tick, daily cap. *Accept:* Solo gets nothing; 2-player local server both gain; cap respected.
- [ ] **M8 Gossip Board.** SurfaceGui or ScreenGui: rotating rumors, global top 10 (OrderedDataStore), room list, next quiz countdown. *Accept:* All three panels populate; no errors with DataStore off.

## Manor Gardens
- [ ] **M9 Library.** Study prompt, timer, Wit gain, cooldown, daily cap.
- [ ] **M10 Garden Promenade.** Checkpoint loop, lap timer, Grace reward, cooldown.

## Grand Ballroom
- [ ] **M11 Etiquette Quiz.** `QuizLogic` (pick questions, score, ties), `QuizService` server-wide schedule, join only if inside Ballroom zone, server-timed questions (client can't extend time), results + rewards. *Accept:* 2-player local server, both answer, correct winner rewarded, late answers rejected.
- [ ] **M12 Seasons + Wall of Fame.** Season id from date, season points, crown at rank 10, end-of-season Diamond selection, Wall of Fame display.

## Polish
- [ ] **M13 Rank-up moments.** Notification + sound when rank/title changes, first-time zone unlock message.
- [ ] **M14 Content pass.** `/content` to hit V1 targets; wire everything to real data.

## Notes for later
(Builder adds things here instead of scope-creeping.)
