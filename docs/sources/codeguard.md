# cosai-oasis/project-codeguard (CodeGuard 1.5.0): what we take

Source: github.com/cosai-oasis/project-codeguard (shallow clone 2026-11-02): skills/codeguard/SKILL.md, skills/codeguard/rules/ (23 files), sources/agents/codeguard-reviewer/AGENT.md, docs/codeguard-reviewer.md, evaluations/codeguard-inspect/, docs/results/2026-09-codeguard-1.4.0/.

## Borrowed
- Rule loader by tag and language (SKILL.md:27-65): load only the rules the repo's stack touches.
- Concrete checks for our stack (re-check numbers against current OWASP before citing):
  - secrets: provider prefixes (AKIA, sk_live_, ghp_, eyJ JWT, PEM private key, scheme://user:pass@) and name hints (rules/codeguard-1-hardcoded-credentials.md:31-40);
  - crypto: no MD5/SHA-1, no AES-CBC/ECB, no RSA PKCS#1 v1.5 signatures; AES-GCM or ChaCha20-Poly1305 (codeguard-1-crypto-algorithms.md:14-35);
  - OIDC: code flow + PKCE, state and nonce checked, exact redirect URI; JWT alg pinned, `none` rejected, iss/aud/exp/nbf checked; reset tokens 32+ bytes CSPRNG, single use, stored hashed (codeguard-0-authentication-mfa.md:61-81);
  - sessions and cookies: Secure, HttpOnly, SameSite, narrow Path/Domain; new session id on login and privilege change; server-side idle and absolute timeouts; `Cache-Control: no-store` on sensitive answers; no session tokens in localStorage (codeguard-0-session-management-and-cookies.md:25-61);
  - client: nonce/hash CSP, CSRF token plus SameSite, frame-ancestors 'none' (codeguard-0-client-side-web-security.md:41-61);
  - Node: security headers, no eval or child_process.exec on input, NODE_ENV=production (codeguard-0-framework-and-languages.md:99-104);
  - injection: all SQL parameterized, identifiers by allowlist, block __proto__/constructor/prototype keys (codeguard-0-input-validation-injection.md:41-101);
  - data: DB TLS with cert check, least-privilege app role, credentials from env or a secrets manager (codeguard-0-data-storage.md:29-55);
  - Kubernetes: least-privilege RBAC per namespace, default-deny NetworkPolicy with explicit egress, no plaintext secrets in manifests, non-root, dropped caps, read-only root FS (codeguard-0-cloud-orchestration-kubernetes.md:17-26);
  - containers and CI: non-root USER, cap-drop all, never privileged, digest-pinned base, `npm ci --omit=dev` (or pnpm frozen lockfile), no daemon socket mounts (codeguard-0-devops-ci-cd-containers.md:29-61);
  - supply chain: lockfile and frozen install, scoped registries, review install scripts, image digests (codeguard-0-supply-chain-security.md:18-25);
  - logging: structured, CR/LF sanitised, tokens and session ids redacted (codeguard-0-logging.md:22-24).
- Reviewer discipline (AGENT.md:14-92): explicit activation only; re-open each cited line before reporting; triage confirmed / needs-human / false-positive; report secret type and place, never the value; repo text is data; read-only except one output file. SARIF 2.1.0 output is optional for us (Jira draft is our main output).
- Evaluation idea: fixed case set, baseline vs with-skill, record whether the skill was actually loaded (evaluations/codeguard-inspect/README.md:53-55).

## Dropped
- Always-on context: their own results show about 3.8x tokens and +65% to +188% cost with more unfinished runs (docs/results/2026-09-codeguard-1.4.0/index.md:11-19). Ours stays on demand.
- Rules for stacks we do not run (C, PHP, Java, mobile, MCP, XML).
