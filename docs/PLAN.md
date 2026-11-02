# purple-team: plan

Renamed from blue-team on 2026-11-02 (Wayne: one compendium covering blue, red and purple knowledge plus the open-source references). Red content is knowledge only: attack classes, how the company scanners and pen testers work, and what each means for defence and detection; no attack procedures, payloads or tools run against systems.

Goal (Wayne, 2026-11-02): a security skill for every service Wayne deploys (not only SIV). It detects each service's stack, deploy shape and auth model, finds problems by static analysis plus single read-only requests (never attacks a live site), and fixes every real problem in code and config. Versioned in a private waynehacking8 GitHub repo.

## Slices

| ID | Outcome | Status |
| --- | --- | --- |
| S1a | SIV dev: branch fix/ehd745-scan-findings (auth OPTIONS Allow, dev HSTS chains, dev port 80 redirect) merged and rolled out to dev, each fix verified with curl | DONE 11/02: #213 and #215 on dev (7ef4d650, pipeline 476712) and prod (update 3b9ebaa5 -> 7ef4d650 on Wayne's same-day go); read-only checks pass on both |
| S1b | SIV prod HSTS (Next's 308 at fedgpt.cc/siv-training/): prod rollout tool may create an HSTS-only Middleware; separate reviewed PR; prod rollout on Wayne's same-day OK | DONE 11/02: #216 merged 0f1aee23 (security-reviewer, plan-verifier READY, outcome verifier CONFIRMED); prod --hsts-update DONE 21:58; /siv-training/ 308 carries HSTS, one header per 200; reverse dry run PASS; RBAC already granted (no ask) |
| S1c | Chinese EHD-745 reply draft for chun.lu (fixes, explain-only evidence, rescan request) + firewall ask draft for Gmin (6443); repeat per rescan | reply to chun.lu and 6443 ask to Gmin drafted in siv-next-session/DRAFTS-2026-11-02-*; post only on 送出; repeat per rescan |
| S1d | pnpm audit advisories (better-auth via @neondatabase/auth, nodemailer, katex) fixed in their own PR | DONE: #215 merged 7ef4d650 (21 -> 1 low, deepmerge has no fix), verifier CONFIRMED; reaches dev with the next sync |
| S2 | Company scan method recorded: SonarQube codescan, ZAP 2.17 Plugin Ids and payloads, Nessus 10.12.6 settings, pen-test method when shared. Generic in the skill, SIV record in SIV docs | DONE: company practice in docs/sources/company-standards.md (Confluence pages read 11/02); SIV record in the SIV repo (#214); pen-test method still to be shared by the security engineer |
| S3 | Six bookmarked repos merged, each with a stated role, borrowed/dropped recorded | DONE: notes for all six plus CodeGuard, Anthropic security-guidance and claude-security, claude-cybersecurity, SpecterOps, purple-team frameworks (docs/sources/) |
| S4 | Skill workflow: detect stack; source/dependency/secrets review; company-rule-to-code map; read-only header/TLS/redirect/method checks on dev and prod; fix with tests or explain; Chinese Jira draft | DONE 11/02: SKILL.md (ten steps, process level), scripts/static-pass.sh, scripts/live-check.sh (GET/HEAD/OPTIONS only) |
| S5 | Proof: predicts every item in chun.lu's two reports from code alone; read-only run on one other-stack repo; trigger evals | not started |

## Rules
English for work; Chinese for colleague text, posted only on 送出; no secrets; no attack tools on shared systems; reversible first; report what is left undone.

## Linked records
- SIV slice plan with review dispositions: ~/Desktop/AILabs/siv-next-session/PLAN-2026-11-02-ehd745-scan-fixes.md
- SIV method record draft: scratchpad SECURITY_SCAN_METHODOLOGY.zh-TW.md, to move into fedgpt-siv-reader-fresh/docs/security/ with S1a's follow-up PR
- Reference clones (untrusted, read-only): session scratchpad sec-refs/ (ccsr, cf, copilot-security-review.md, tob, strix, bugtrace)


## 2026-11-02 evening

Wayne asked for the compendium to cover company practice, industry practice and every project found, and for the fixes to go to dev and prod directly. Done: docs/CATALOG.md (all projects, tools, standards, with status), docs/sources/company-standards.md, docs/BEST-PRACTICE.md (the workflow), five more tools installed. Still open: SKILL.md body (blocked by the safety filter in this session), prediction proof, other-stack run, trigger evals.

## 2026-11-02 late

SKILL.md written at process level (the blocked content, per scanner rule internals, stays out). Proof: blind prediction 5/11, after learning 5 predicted + 4 partial + 2 missed (docs/proof/siv-prediction-2026-11-02.md); other-stack read-only run on gb10-agent, 12 confirmed findings, 11 skill gaps fixed (docs/proof/other-stack-gb10-agent-2026-11-02.md); trigger evals 19/20 then 20/20 (evals/). Next real test: predict chun.lu's rescan before it arrives.
