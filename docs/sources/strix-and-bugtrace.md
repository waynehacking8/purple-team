# usestrix/strix and BugTraceAI: what we take (knowledge only, never run)

Sources: github.com/usestrix/strix strix/skills/ (vulnerabilities/, frameworks/nextjs.md, protocols/oauth.md, cloud/kubernetes.md, custom/source_aware_sast.md, counterevidence.md, severity_calibration.md, source_aware_discovery.md, analysis/fix_verification.md); github.com/BugTraceAI/BugTraceAI Documentation/.../specialist-agents.md, validation-system.md. Read 2026-11-02. Both are active pentest tools; we run neither.

## Borrowed
- Class list: SQLi, NoSQLi, SSTI, XSS, XXE, RCE, argument injection, deserialization, path traversal/LFI, SSRF, open redirect, header injection, request smuggling, CSRF, IDOR, BFLA, mass assignment, business logic, race conditions, prototype pollution, JWT/OIDC, information disclosure, file upload, subdomain takeover, LLM prompt injection. BugTraceAI's 15 specialists are a subset.
- Next.js signals (nextjs.md): auth only in middleware/proxy (check each handler enforces it; path variants), Server Actions and Route Handlers trusting client state, personalized fetch/cache without identity in the key, RSC props leaking, broad images.remotePatterns, guessable revalidate secrets, dangerouslySetInnerHTML and user-controlled href/src, CSP coverage.
- OIDC/JWT (oauth.md, authentication_jwt.md): exact redirect_uri, state and nonce bound to the session, PKCE S256, iss/aud/typ checks, algorithm pinned, kid/jku/x5u/jwk not trusted, refresh rotation, revocation on logout.
- Kubernetes static checks (kubernetes.md): wildcard RBAC, automountServiceAccountToken, privileged/hostPID/hostNetwork, runtime sockets, missing NetworkPolicy, :latest images, secrets in env.
- Static recon: route inventory (app/**, pages/**, app/api/**, proxy.ts), route x role auth matrix, Server Action and object-reference inventory, next.config and OIDC client config, manifests.
- Closure rules (counterevidence.md): confirmed / ruled_out (a named control on every attacker path) / open_proof_gap; what does NOT rule a finding out (trust in a library, a control on another route, a control after the effect, fail-open, internal-only, defaults the operator can change).
- Severity calibration: rate the proved weakness; missing headers, open redirect alone, self-XSS are low/medium; internal-only is downgraded, not dropped.
- Discovery discipline: one candidate per reachable call site of a root cause; stored values from other components count as attacker-controlled.
- Fix verification: re-check the closure, the bypass alternatives and the preserved behavior.

## Dropped
- Everything that sends traffic: the agents, sandbox, browser validation ladders (BugTraceAI L0-L6), autonomous discovery.
- Strix's "report only after dynamic validation" (source_aware_sast.md:186-192): conflicts with static-only mode; we use needs_validation instead.
