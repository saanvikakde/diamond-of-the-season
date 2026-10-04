---
description: Build and test the next roadmap milestone (or the one named in the arguments)
---

Run one milestone through the full loop. Milestone requested: $ARGUMENTS (if empty, use the first unticked milestone in docs/ROADMAP.md).

1. Tell Saanvi in one line which milestone you're starting.
2. Spawn the `builder` agent with: the milestone id and title, and "Follow .claude/agents/builder.md."
3. When the builder returns, spawn the `tester` agent with: the milestone id, the builder's list of changed files, and "Follow .claude/agents/tester.md." Do not pass the builder's reasoning, only the file list.
4. If the tester says FAIL: send the "Must fix" list back to the builder (SendMessage to the same builder agent), then re-run the tester. Max 3 rounds. If still failing, stop and show Saanvi the remaining issues.
5. On PASS, show Saanvi:
   - What was built (2-3 lines)
   - Anything she has to build/name in Studio
   - The tester's playtest checklist
   - Then ask: "Run the checklist and tell me pass, or what broke."
6. Do NOT tick the roadmap or commit yet.

When Saanvi replies "pass": tick the milestone in docs/ROADMAP.md and commit with message `M<id>: <title>`.
When she describes a bug: hand it to the builder as a fix task, then re-run the tester, then give her an updated checklist.
