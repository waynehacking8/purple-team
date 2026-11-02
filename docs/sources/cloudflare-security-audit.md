# cloudflare/security-audit-skill: what we take

Source: github.com/cloudflare/security-audit-skill, skills/security-audit/ (read 2026-11-02).

## Borrowed
- Guidance mode by default; the full audit only on an explicit audit request (SKILL.md:12-17).
- Candidate gate (HUNTING.md:141-156): complete repo-relative trace, strongest visible control named, no preventing layer, no same-principal "escalation".
- Three finding states (report-schema.json): confirmed (trace + bounded local proof + independent re-check, has severity), needs_validation (decisive fact outside source; blockers + validation plan; NO severity), rejected (kept so later runs do not repeat the claim).
- Severity anchors and the discriminator "fully defeats the control vs only weakens it" (SKILL.md:154-162).
- Coverage as surface x trust boundary x attack class (RECONNAISSANCE.md:90-94), simplified to a checklist.
- Render every deploy overlay and review the rendered output, not the template (CLOUD-AND-DEPLOYMENT.md:76).
- Domain check lists: WEB-PROTOCOL-AND-AUTH (Host/X-Forwarded-* in URLs, CSRF on cookie mutations, session rotation, cookie scope, OIDC redirect_uri/state/PKCE/iss/aud/nonce, account linking, header injection), CLOUD-AND-DEPLOYMENT (dev defaults in deployed overlays, exposed admin/metrics routes, trusted-proxy headers stripped at ingress, privileged pods, SA token mounts, secret readers), CLIENT-SIDE (DOM sinks, tokens in storage, SW caching, framing, postMessage, credentialed CORS), DATA-ISOLATION (owner/tenant binding on every query path, ORM scope bypass, soft delete, revocation reaching caches, export scope, migration defaults), SUPPLY-CHAIN (floating actions/images, fork-trigger secrets, expression injection, build context leaking .env).
- No live probing beyond the minimum; dummy principals only.

## Dropped
- Write-isolation and artifact promotion procedure, per-agent scratch roots, agent-ID rules: built for many parallel agents; one operator writes one output.
- Coverage-ledger state machine, critic waves, budget reserves: replaced by a plain checklist and one fresh re-check per finding.
- The .cjs validators as a gate: we keep the schema shape only.
