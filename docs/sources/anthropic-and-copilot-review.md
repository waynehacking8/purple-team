# anthropics/claude-code-security-review and awesome-copilot security-review: what we take

Sources: github.com/anthropics/claude-code-security-review (claudecode/prompts.py, findings_filter.py, .claude/commands/security-review.md); github.com/github/awesome-copilot skills/security-review (SKILL.md + references/vuln-categories.md, secret-patterns.md, language-patterns.md, vulnerable-packages.md, report-format.md). Read 2026-11-02.

## Borrowed
- Two-stage pipeline: a finder pass, then one fresh check per finding with the false-positive rules; drop below confidence 8/10 (security-review.md:185-189).
- Every finding carries a concrete exploit scenario (who, what input, what result) (prompts.py:138).
- Review order from Copilot: stack detection, dependency audit first, secrets (incl. CI, Docker, IaC), per-category scan, cross-file source-to-sink tracing, self-verification, report (SKILL.md:41-123).
- Category lists: injection, authn/authz (BOLA/IDOR, JWT alg, CSRF, mass assignment), data exposure, crypto (weak hash, static IV, Math.random tokens, TLS verify off), business logic (TOCTOU, money math, predictable IDs).
- Precedents worth keeping: React/Next escape by default, XSS only via dangerouslySetInnerHTML or similar; UUIDs unguessable; env vars and CLI flags trusted; client-side missing authz is not a vuln (server decides); logging secrets is a vuln, logging URLs is not.
- Extension-gated deterministic filters (memory safety only for C/C++; findings in .md dropped) (findings_filter.py:91-152).

## Changed
- Their hard exclusions drop "missing hardening" and outdated libraries. The company scanners (ZAP, Nessus, SonarQube) DO report those (HSTS, Allow header, dependency CVEs), so for us they stay as findings with low severity instead of being dropped.
- Diff-only scope widened to the whole repo plus rendered deploy config.

## Dropped
- GitHub Action plumbing, PR comment scripts, API client/retry code.
- Emoji severity labels.
