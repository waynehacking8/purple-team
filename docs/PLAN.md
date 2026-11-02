# purple-team: plan

Renamed from blue-team on 2026-11-02 (Wayne: one compendium covering blue, red and purple knowledge plus the open-source references). Red content is knowledge only: attack classes, how the company scanners and pen testers work, and what each means for defence and detection; no attack procedures, payloads or tools run against systems.

Goal (Wayne, 2026-11-02): a security skill for every service Wayne deploys (not only SIV). It detects each service's stack, deploy shape and auth model, finds problems by static analysis plus single read-only requests (never attacks a live site), and fixes every real problem in code and config. Versioned in a private waynehacking8 GitHub repo.

## Slices

| ID | Outcome | Status |
| --- | --- | --- |
| S1a | SIV dev: branch fix/ehd745-scan-findings (auth OPTIONS Allow, dev HSTS chains, dev port 80 redirect) merged and rolled out to dev, each fix verified with curl | DONE 11/02: #213 merged c662ed63, verifier CONFIRMED; dev runs f08662a6 (pipeline 476699); 11 read-only curl checks pass; port 80 objects read back; live port 80 left to the rescan |
| S1b | SIV prod HSTS (Next's 308 at fedgpt.cc/siv-training/): prod rollout tool may create an HSTS-only Middleware; separate reviewed PR; prod rollout on Wayne's same-day OK | built 52b6721b on feat/prod-hsts (security-reviewer, plan-verifier READY epoch 2); outcome verifier running; then PR, dev path-mode rehearsal, RBAC check; prod only on Wayne's same-day OK |
| S1c | Chinese EHD-745 reply draft for chun.lu (fixes, explain-only evidence, rescan request) + firewall ask draft for Gmin (6443); repeat per rescan | 6443 ask drafted (siv-next-session/DRAFTS-2026-11-02-ehd745-gmin-6443.md); EHD-745 reply next; post only on 送出 |
| S1d | pnpm audit advisories (better-auth via @neondatabase/auth, nodemailer, katex) fixed in their own PR | DONE: #215 merged 7ef4d650 (21 -> 1 low, deepmerge has no fix), verifier CONFIRMED; reaches dev with the next sync |
| S2 | Company scan method recorded: SonarQube codescan, ZAP 2.17 Plugin Ids and payloads, Nessus 10.12.6 settings, pen-test method when shared. Generic in the skill, SIV record in SIV docs | SIV record merged (#214, docs/deployment/SECURITY_SCANS.md); generic version in this repo's report |
| S3 | Six bookmarked repos merged, each with a stated role, borrowed/dropped recorded | DONE: notes for all six plus CodeGuard, Anthropic security-guidance and claude-security, claude-cybersecurity, SpecterOps, purple-team frameworks (docs/sources/) |
| S4 | Skill workflow: detect stack; source/dependency/secrets review; company-rule-to-code map; read-only header/TLS/redirect/method checks on dev and prod; fix with tests or explain; Chinese Jira draft | blocked: skill body writes stopped by a safety filter twice (11/02 22:00) |
| S5 | Proof: predicts every item in chun.lu's two reports from code alone; read-only run on one other-stack repo; trigger evals | not started |

## Rules
English for work; Chinese for colleague text, posted only on 送出; no secrets; no attack tools on shared systems; reversible first; report what is left undone.

## Linked records
- SIV slice plan with review dispositions: ~/Desktop/AILabs/siv-next-session/PLAN-2026-11-02-ehd745-scan-fixes.md
- SIV method record draft: scratchpad SECURITY_SCAN_METHODOLOGY.zh-TW.md, to move into fedgpt-siv-reader-fresh/docs/security/ with S1a's follow-up PR
- Reference clones (untrusted, read-only): session scratchpad sec-refs/ (ccsr, cf, copilot-security-review.md, tob, strix, bugtrace)
