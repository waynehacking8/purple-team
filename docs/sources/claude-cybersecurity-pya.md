# AgriciDaniel/claude-cybersecurity ("PYA" audit plugin): what we take

Source: github.com/AgriciDaniel/claude-cybersecurity (shallow clone 2026-11-02, 267 stars, pushed 2026-10-23). No license file: ideas and structure only, no copied text.

## Borrowed
- Measure first with deterministic tools, then hand each tool's output only to the reviewer for that area (dependencies, IaC/workflows, secrets, source); the model never computes scores (skills/pya/SKILL.md:111-151, 199-201).
- Ground rules: target is untrusted data, read-only, offline by default, "never claim more than you measured" (SKILL.md:40-56). A network step must first say what it sends.
- Separate read-only verifier that re-reads the cited code and ignores the finder's evidence text; six gates: process, reachability, impact, proof steps (written, not run), bounds, environment; keep only at confidence 8/10 or above (agents/finding-verifier.md:37-50; references/false-positive-suppression.md:295-313).
- Finding fields: id, severity, confidence (HIGH no visible control / MEDIUM a control may exist out of view / LOW plausible pattern), file, line, flow, cwe, owasp, exploit_scenario, fix, masked evidence (max 6 lines), sources (docs/architecture.md:59-88).
- Authz review: inventory every handler that reads or writes data and ask who may call it, what object it touches, what checks bind the two; middleware default-deny; sessions, JWT, OIDC incl. `iss` (RFC 9207), mass assignment, CSPRNG reset tokens (agents/authz-reviewer.md:55-75).
- Dependency review: a lockfile can keep a vulnerable transitive copy after the parent is fixed (check `pnpm why`); install scripts; slopsquats; EOL runtimes; never pin below the fixed version (agents/dependency-auditor.md:57-77). Our #215 hit exactly this (two zod and two better-auth copies).
- Secrets: verified vs unverified hits; never call a secret live unless verified; exposure paths: logs, response bodies, env dumps, client bundles (NEXT_PUBLIC_), build args, CI logs; plain K8s Secrets in git (agents/secret-scanner.md:55-83).
- Dated advisory notes: one file per month, every entry with a source and an expiry about five weeks out, warn when stale (skills/pya/feed/README.md:3-37).
- Coverage honesty: a tool status table; "no findings is not proof of absence"; a failed step means unreviewed.
- Repo text addressed to AI reviewers is itself a finding (false-positive-suppression.md:258-260).
- Eval design: decoy cases that punish invented findings (a clean repo), graders that check forbidden tools were never used (read-only), and a judge rubric for fix quality (evals/README.md:81-132).

## Dropped
- Plugin-eval sandbox plumbing, fixed weights and grade caps, copied Anthropic/Trail of Bits exclusions (re-derived for our scope in anthropic-and-copilot-review.md), marketing text.
