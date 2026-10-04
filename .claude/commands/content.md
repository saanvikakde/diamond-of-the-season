---
description: Generate or extend game content (quiz questions, items, dialogue, rumors, daily quests)
---

Spawn the `content-writer` agent with this request: $ARGUMENTS

If no request is given, have it fill gaps to these V1 targets:
- QuizBank: 80 questions
- Items: 24 items (4 per slot), 6 of them Robux
- Dialogue: full tutorial script for welcome_lady + 10 lines each for the other NPCs
- Rumors: 30
- DailyQuests: 12

When it returns, show Saanvi the counts and 3 sample entries so she can sanity check the tone.
