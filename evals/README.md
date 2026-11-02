# Trigger evals

`trigger-eval-set.json`: 10 requests that should load the skill and 10 near misses (status sweep, posting a draft, UI bug, certificate SOP, video cut, plain code review, deck, study notes, k3s plan summary, prose rewrite).

2026-11-02: run 1 scored 19/20 (the pnpm audit request did not trigger); after adding dependency advisories to the description, run 2 scored 20/20, 3 runs per query, model claude-opus-5-5. Run with the patched runner from ~/.claude/skills/wayne-todos-workspace (see its README), because the stock skill-creator runner counts only its temporary command name.
