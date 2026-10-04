# Diamond of the Season

Bridgerton-inspired Roblox social progression game for teens (13-17). Solo dev (Saanvi) does all visual building in Roblox Studio. Agents write all code and content. Full design lives in `docs/GDD.md`; the build order lives in `docs/ROADMAP.md`.

## How work happens here

1. Saanvi says `/next` (or names a milestone).
2. The **builder** agent implements exactly one milestone from `docs/ROADMAP.md`.
3. The **tester** agent verifies it independently and writes a short playtest checklist.
4. Saanvi runs the checklist in Studio (Rojo synced), then says pass or describes what broke.
5. On pass: tick the milestone, commit.

Content (quiz questions, dialogue, rumors, item catalog) is written by the **content-writer** agent via `/content`.

Never start a second milestone in the same run. Small and working beats big and broken.

## Repo layout (Rojo)

```
src/server/Services/   *.luau ModuleScripts, one per system (DataService, StatService, ...)
src/server/init.server.luau  bootstraps services in order. The ONLY server Script.
src/client/Controllers/  one controller per UI/feature
src/client/init.client.luau  bootstraps controllers. The ONLY LocalScript.
src/client/UI/         UI built in code (no hand-made ScreenGuis needed)
src/shared/Logic/      PURE logic: no game services, no requires, no Instance access
src/shared/Data/       content tables (quiz bank, items, dialogue, rumors, config)
src/shared/Net/        Remotes.luau: single source of truth for every RemoteEvent/Function
tests/                 Lune unit tests for src/shared/Logic
```

Mapping (see `default.project.json`): server → ServerScriptService.Server, client → StarterPlayer.StarterPlayerScripts.Client, shared → ReplicatedStorage.Shared.

## Architecture rules (non-negotiable)

- **Server authoritative.** Clients send *requests* ("I want to buy item X"), never results ("set my Grace to 50"). Every remote handler validates: player exists, args are the right type, player is allowed (rank, location, cooldown).
- **Pure logic is split out.** Any math or rule (rank from stats, Charm from equipped items, quiz scoring, daily reset check, tier lookup) goes in `src/shared/Logic/*.luau` as a function that takes plain values and returns plain values. Services call it. This is what makes it testable outside Roblox.
- Logic modules must not `require` anything and must not touch `game`, `workspace`, `Instance`, `task`, `os.time()` (pass time in as an argument).
- **Charm is never stored.** It is computed from equipped item ids + the item catalog.
- **All tuning numbers live in `src/shared/Data/Config.luau`** (thresholds, rewards, timers, quiz interval). No magic numbers in services.
- Services expose `:Init()` (wire things up, no yielding) and `:Start()` (may yield, start loops). Bootstrap calls all Init, then all Start.
- One RemoteEvent per action, declared in `src/shared/Net/Remotes.luau`. Server creates them; client waits for them.
- Use `--!strict` at the top of every file.
- Studio objects Saanvi builds are found by name under `workspace.Map.<Zone>` (e.g. `workspace.Map.VillageCommons.TeaParlor`). If a script needs a part that does not exist yet, say so in the milestone report; do not create map geometry in code except temporary debug markers.

## Roblox gotchas to respect

- DataStores need "Enable Studio Access to API Services" (Game Settings → Security) to work in Studio. Code must fail gracefully (log, play with defaults, do NOT save over real data) when DataStore calls error.
- Wrap every DataStore call in `pcall` with retry. Save on PlayerRemoving and in `game:BindToClose`. Autosave every ~2-3 min.
- Use `UpdateAsync`, not `SetAsync`, for player saves. Store a `version` field and run migrations on load.
- Tables sent over remotes: arrays OR string-keyed dictionaries, never mixed, no holes in arrays, no Instance keys, no functions, no metatables. Mixed tables silently lose data.
- Any player-written text shown to other players must go through `TextService:FilterStringAsync`. Teen audience; this is a hard requirement.
- `os.date("!*t")` for UTC-based daily resets.
- Don't trust `Humanoid` existing immediately; wait for `CharacterAdded`.

## Definition of done for a milestone

- `selene src` passes
- `stylua --check src tests` passes
- `lune run tests/run` passes (new Logic has tests)
- Tester agent report says PASS
- Saanvi has run the playtest checklist
- `docs/ROADMAP.md` box ticked, commit made

## Style

- Plain, readable Luau. Comments explain *why*, briefly. Saanvi is new to Luau, so prefer obvious code over clever code.
- Reports to Saanvi: short. What was built, what to check in Studio, anything she has to build/name in the map.
