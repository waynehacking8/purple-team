# anthropics/claude-plugins-official: security-guidance and claude-security plugins, what we take

Source: github.com/anthropics/claude-plugins-official plugins/security-guidance and plugins/claude-security (sparse clone 2026-11-02). Read only; nothing run.

## What they are
- security-guidance: always-on hooks. Regex pattern warnings after every edit (hooks/patterns.py); a model review of the turn's git diff at Stop, and of commits and pushes (hooks/security_reminder_hook.py). Needs an Anthropic API key or a Claude Code sign-in for the model part; patterns need nothing.
- claude-security: on-demand multi-agent scan (inventory, threat model, research per component and lens, sweep, three-voter panel), output RESULTS.md / .jsonl / .sarif, optional patches never applied (README.md:31-86, workflows/scan.js).

## Borrowed
- Pattern table for JS/TS with a path filter per rule and lookbehind exclusions (patterns.py): child_process exec/execSync (prefer execFile with an argument array), eval and new Function, dangerouslySetInnerHTML, innerHTML/outerHTML/insertAdjacentHTML, document.write, script src without SRI, createCipher without IV, AES-ECB, TLS verification disabled (rejectUnauthorized: false, NODE_TLS_REJECT_UNAUTHORIZED=0); GitHub Actions untrusted `${{ github.event.* }}` in run steps.
- Scope rules for change reviews: only added lines count; a finding that predates the change is its own verdict (PREDATES_CHANGE) (security_reminder_hook.py:1620-1625, scan.js:73).
- Skip generated and vendored paths: node_modules, dist, build, .next, vendor, __generated__, *.min.js, *.d.ts, lockfiles (gitutil.py:1540-1547).
- Never send secret-named files to a model: SSH keys, .env*, .npmrc, .netrc, credentials, secrets.yml (gitutil.py:1549-1660). For us: also kubeconfigs.
- Hardcoded-secret judgement excludes dev fallbacks and non-credential config (security_reminder_hook.py:1555-1556), but our insecure-defaults rule still asks whether a deployed overlay can reach the fallback.
- Verifier panel defaulting to false positive unless it cites file:line for source, sink and the missing mitigation (agents/scan-verifier.md:14-26).
- Coverage accounting: every top-level directory scanned or skipped with a reason, checked in code (scan.js:84-94).
- Stable finding ids so a rescan can match earlier findings.

## Dropped
- Hook loop machinery (asyncRewake, exit 2, recursion counters), the Agent SDK venv bootstrap, model pinning and provider plumbing, telemetry ids, the patch pipeline (we fix in a branch with tests).

Gap: neither plugin has Kubernetes, Traefik or NEXT_PUBLIC_ secret-leak rules; those stay our own.
