# purple-team: handoff

Read docs/PLAN.md first. This file holds state, traps and the next step; update it at the end of each work bundle.

## State (2026-11-02 21:30)
- S1a: fix/ehd745-scan-findings at 89255a1f in ~/Desktop/AILabs/fedgpt-siv-reader-fresh (3 commits, pnpm verify:pre-merge green, prod render byte-identical). Not pushed.
- Company scan facts: ZAP 2.17 unauthenticated active scan (Plugin 40018, 6, 43, 90028, 40025, 90027, 10104); Nessus 10.12.6 Advanced Scan, uncredentialed, safe checks, web app tests off, scanner 172.26.30.78, open ports 22/80/443/2000/5060/6443.

## Traps
- Chrome account bookmarks live in Profile 1/AccountBookmarks, not Bookmarks.
- ZAP SQLi on /api/auth/microsoft/start is a false positive: every response carries fresh state/nonce/PKCE, so identical requests already differ.
- Port 80 on staging is not reachable from Wayne's Mac; the scanner subnet reaches it.
- Prod rollout tool allows only rateLimit/inFlightReq/buffering/chain Middlewares and freezes Middlewares on --update (prod-rollout-lib.mjs:66, REPLACE_SET).

## Next
Verifier verdict on S1a, then push, PR, merge, GitLab sync, rollout-dev, curl acceptance.

## 2026-11-02 22:00: skill content blocked
Two attempts to write the skill body (references/company-scanners.md, then SKILL.md) were stopped by a safety filter mid-write; neither file was saved. Do not retry the same content in this session. What exists: docs/PLAN.md, docs/HANDOFF.md, docs/sources/*.md (what each bookmarked repo contributes), the Nessus plugin list. S1 (EHD-745 fixes) continues unaffected.
