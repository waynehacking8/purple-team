# trailofbits/skills: what we take

Source: github.com/trailofbits/skills plugins/ (read 2026-11-02): differential-review, insecure-defaults, static-analysis, supply-chain-risk-auditor, fp-check, post-patch-validation, variant-analysis, sharp-edges, vulnerability-triage-brocards, audit-context-building.

| Plugin | Borrowed | Dropped |
| --- | --- | --- |
| differential-review | size the change (<20 files deep, 20-200 focused, 200+ surgical); `git log -S "<removed code>" --all` to see whether removed security code came from a fix/CVE commit; `git log -S "<added code>" --all -p` for re-introduced code; blast radius = caller count | gh pr plumbing, Solidity examples |
| insecure-defaults | fail-open rule: report when the unconfigured state is the insecure one (`process.env.X || '*'`); six categories (debug features, default creds, fail-open, fallback secrets, permissive access, weak crypto); refutation chain: reachable in prod, the value that really runs, really insecure, reaches a security decision, does deploy always set it (only the last changes severity) | Claude workflow runtime |
| static-analysis | semgrep with `--metrics=off` always; rulesets p/security-audit, p/secrets, p/javascript, p/typescript, p/nodejs, p/nextjs, p/kubernetes, trailofbits/semgrep-rules; record failed/skipped scans so a partial run never reads as clean; CodeQL only via generated .qls suites | subagent plumbing |
| supply-chain-risk-auditor | never report unassessable data as clean; OSV querybatch, deps.dev, OpenSSF Scorecard, npm has_install_script; coverage table | uv/python runner (it reads only package-lock.json/uv.lock, not pnpm-lock.yaml) |
| fp-check | restate the claim, trace source to sink, try to refute; six gates and the FP checklist | Task/Team tooling, C bug classes |
| post-patch-validation | each fix gets a baseline-vs-patched pair; prove the check really executed (a reached marker) | the runner |
| variant-analysis | the exact match must hit first, then generalise one element at a time | parallel subagents |
| sharp-edges | JS: `==` in role checks, prototype pollution through merges, ReDoS nested quantifiers, parseInt without radix; "does 0 or empty disable the check?" | other languages |
| vulnerability-triage-brocards | threat-model test; "cure worse than the disease"; necessary-and-sufficient test | external-report framing |
| audit-context-building | per-function "must be true / assumes / calls" notes; unmet assumptions written as "nothing found"; find where auth really lives (middleware vs handler) | subagent dispatch |

Gap: nothing in these plugins covers Traefik, k3s or Next.js proxy specifics; those are our own rules (references/company-scanners.md, references/stack-nextjs-k8s.md).
