# Diamond of the Season: agentic workflow

You build the world in Studio. Agents write the code and content. You playtest.

```
 you: /next
   │
   ▼
 builder ──writes──▶ src/  (one milestone, + tests for pure logic)
   │
   ▼
 tester  ──checks──▶ lint, format, Lune tests, exploit/data-loss review
   │        FAIL → back to builder (max 3 rounds)
   ▼ PASS
 you: 5-min Studio checklist ──▶ "pass" → roadmap ticked + git commit
                             └─▶ "the shop button does nothing" → builder fixes
```

`/content` runs the content writer separately (quiz bank, outfits, dialogue, rumors, daily quests).

## What's in here

| File | Purpose |
|---|---|
| `CLAUDE.md` | Project brain every agent reads: architecture rules, Roblox gotchas, definition of done |
| `docs/GDD.md` | Your design doc + 9 open questions with proposed defaults (read these!) |
| `docs/ROADMAP.md` | 15 small milestones, M0 to M14, in build order |
| `.claude/agents/builder.md` | Writes game code, one milestone at a time |
| `.claude/agents/tester.md` | Separate reviewer: runs checks, hunts exploits, writes your playtest checklist. Can't edit `src/` |
| `.claude/agents/content-writer.md` | Writes all game text/data as Luau tables |
| `.claude/commands/next.md` | `/next` runs build → test → checklist |
| `.claude/commands/content.md` | `/content` runs the content writer |
| `tests/` | Lune test runner for pure logic |

## One-time setup (~20 min)

1. **Install Claude Code** and open this folder in it. (Agents run on your machine so Rojo can sync to Studio.)
2. **Install Rokit** (Roblox toolchain manager): see github.com/rojo-rbx/rokit for the one-line installer.
3. In this folder:
   ```
   rokit init
   rokit add rojo-rbx/rojo
   rokit add Kampfkarren/selene
   rokit add JohnnyMorganz/StyLua
   rokit add lune-org/lune
   ```
4. **Rojo Studio plugin:** `rojo plugin install`, then restart Studio.
5. In Studio, open `DiamondOfTheSeason_Dev`:
   - Game Settings → Security → turn on **Enable Studio Access to API Services** (DataStores).
   - Put your blockout under `Workspace > Map > VillageCommons` (Folder named `Map`, Folder named `VillageCommons`, your parts inside). The scripts find things by these names.
6. `git init && git add . && git commit -m "Workflow setup"` (already done if you got this as a zip with `.git`).
7. Optional: the Roblox Studio MCP server lets the tester start play mode and read the output log itself. Nice to have, not required.

## Daily loop

```
rojo serve            # terminal 1, leave running; click Connect in the Studio Rojo plugin
claude                # terminal 2
> /next               # builds + tests the next milestone
```
Run the checklist it gives you in Studio, reply `pass` or describe what broke.

## Before your first `/next`
Skim `docs/GDD.md` → "Open questions." Two of them matter a lot:
- **#2** Charm drops when you take clothes off, which could drop your rank and lock you out of zones. Default fix: zones use your highest-ever rank.
- **#4** Rank 10 is a threshold lots of people can hit, but the Wall of Fame needs one winner. Default: rank 10 = contender, season points pick the Diamond.

Change anything you disagree with right in the GDD; the agents follow whatever it says.
