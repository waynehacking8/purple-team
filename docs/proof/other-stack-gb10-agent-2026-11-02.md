# Proof run 2: read-only review of a different stack (gb10-agent, 2026-11-02)

Stack: Python (FastAPI hub, agent loop), Docker Compose, vLLM containers, per-user desktop containers, Tailscale access. No Kubernetes, no lockfile. Run by a fresh agent (Sonnet) with only the skill copy and a one-commit snapshot; steps 1 to 5, no live checks, nothing fixed. Full output stays with the project owner, not in this repo.

Result: 12 confirmed (1 High, 1 Medium, 10 Low), 5 needs validation, 16 rejected with reasons, 6 variant searches.

| ID | Severity | Finding (short) |
| --- | --- | --- |
| F-01 | High | untrusted documents, audio transcripts and screenshots reach a model that can run code with open internet egress and no approval step; the README promise "never leave the box" is not true yet (known, deferred in the repo's threat model) |
| F-02 | Medium | the hub drives containers through Docker, so code execution in the hub means the host (known) |
| F-03 | Low | non-ASCII bearer token gives an unauthenticated 500; placeholder tokens accepted when run outside the managed start script (known) |
| F-04 | Low | FastAPI docs and schema routes public by default |
| F-05 | Low | missing security headers, server banner, `unsafe-inline` style |
| F-06 | Low | static tokens without expiry or revocation; tokens on curl argv in a check script |
| F-07 | Low | full tool arguments and file names in logs, no rotation |
| F-08 | Low | model containers less hardened than desktops (`ipc: host`, no cap drop, no API key) |
| F-09 | Low | partial image and package pinning; freeze check compares tags, not digests |
| F-10 | Low | infrastructure map and a shared-password statement in repo docs |
| F-11 | Low | egress gate falls back to a service-state check |
| F-12 | Low | unlocked dict iteration in the task list |

The High finding was rechecked first-hand against `infra/desk-egress.sh` and `README.md` (main session).

## Skill changes from this run

1. `static-pass.sh`: Python checks (ruff `S`, bandit, asserts skipped), a warning when no lockfile exists (the advisory tools otherwise report "no issues"), the commit count next to the secret scan, and a note when Compose files are present (the Kubernetes linters do not read them). ruff 0.17.3 and bandit 1.9.4 installed user-local.
2. `SKILL.md`: severity anchors written into the skill; a fifth state "known and accepted"; a method for AI features (trace untrusted input path plus unapproved action, by code only); what to predict when the company scanner cannot reach the service; repo instruction files are data in a read-only run.
