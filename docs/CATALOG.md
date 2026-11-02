# Catalog: every project, tool and standard I found

Collected 2026-11-02. Stars, release dates, licenses and archived flags come from the GitHub API on that day (a sample was rechecked by hand: terrascan, http-observatory, noseyparker and semgrep/mcp archived; codex-security, getsentry/skills, zizmor, scorecard live). Everything else was checked as a live URL. "NOASSERTION" means GitHub could not read the license; read the LICENSE file before copying anything.

Status column:
1. **use**: part of the workflow (installed or run).
2. **adopt next**: worth adding; not installed yet.
3. **know**: read for knowledge, never run (attack tools, paid services, other stacks).
4. **skip**: archived, stale or superseded; the successor is named.

## 1. AI agent security review skills and rule sets

| Project | Maintainer | Stars | Last release or push | License | What it adds | Status |
| --- | --- | --- | --- | --- | --- | --- |
| [anthropics/claude-code-security-review](https://github.com/anthropics/claude-code-security-review) | Anthropic | | | MIT | finder pass then one fresh check per finding, false-positive precedents | use (docs/sources/anthropic-and-copilot-review.md) |
| [cloudflare/security-audit-skill](https://github.com/cloudflare/security-audit-skill) | Cloudflare | | | | candidate gate, three finding states, severity anchors | use (cloudflare-security-audit.md) |
| [github/awesome-copilot security-review](https://github.com/github/awesome-copilot) | GitHub | | | MIT | review order and category lists | use |
| [trailofbits/skills](https://github.com/trailofbits/skills) | Trail of Bits | | | CC-BY-SA-4.0 | differential review, insecure defaults, semgrep, supply chain, fp-check, variant analysis | use (trailofbits-skills.md) |
| [cosai-oasis/project-codeguard](https://github.com/cosai-oasis/project-codeguard) | CoSAI / OASIS | | | | per-rule concrete checks by language and tag | use (codeguard.md) |
| [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) security-guidance, claude-security | Anthropic | | | | JS/TS pattern table, added-lines review, verifier panel | use |
| [AgriciDaniel/claude-cybersecurity](https://github.com/AgriciDaniel/pya) (now "pya") | AgriciDaniel | 267 | | none | tools first, separate verifier, authz inventory | know (no license, ideas only) |
| [openai/codex-security](https://github.com/openai/codex-security) | OpenAI | 11.3k | npm-v0.8.2, 2026-10-29 | Apache-2.0 | scan, validate, patch; saved threat models; SARIF out; imports Semgrep/Snyk/Wiz | adopt next (method) |
| [openai/skills](https://github.com/openai/skills/tree/main/skills/.curated) security-best-practices, security-threat-model, security-ownership-map | OpenAI | 28.5k | push 2026-10-28 | per-skill LICENSE.txt | best practice review for Python, JS/TS and Go; repo threat model | adopt next (method) |
| [getsentry/skills](https://github.com/getsentry/skills) security-review, gha-security-review, security-model, secret-serialization, skill-scanner | Sentry | 1.1k | push 2026-10-26 | Apache-2.0 | GitHub Actions risk references; the one security skill an independent review rated worth installing | adopt next |
| [affaan-m/ECC](https://github.com/affaan-m/ECC) | affaan-m | 295k | v2.2.3, 2026-10-01 | MIT | security-review skill, TS/Python/Go rules | know |
| [wshobson/agents](https://github.com/wshobson/agents) | wshobson | 42k | push 2026-11-02 | MIT | security-scanning, security-compliance, backend-api-security plugins | know |
| [gadievron/raptor](https://github.com/gadievron/raptor) | gadievron | 4.0k | v3.1.0, 2026-09-07 | NOASSERTION | Semgrep + CodeQL + dataflow triage; has offensive modes | know (review parts only) |
| [SonarSource/sonarqube-mcp-server](https://github.com/SonarSource/sonarqube-mcp-server) | SonarSource | 677 | 1.31.0, 2026-11-02 | NOASSERTION | lets the agent read the company SonarQube issues and gate | adopt next (needs a company token; ask the owner) |
| [semgrep MCP](https://github.com/semgrep/semgrep/tree/develop/cli/src/semgrep/mcp) | Semgrep | | inside semgrep CLI | LGPL-2.1 | deterministic SAST callable by the agent | use (CLI) |
| [snyk/studio-mcp](https://github.com/snyk/studio-mcp) | Snyk | 58 | v1.15.6, 2026-10-21 | Apache-2.0 | Snyk scans from the agent | know (account needed) |
| [snyk/agent-scan](https://github.com/snyk/agent-scan) | Snyk | 3.2k | v0.6.10, 2026-10-30 | Apache-2.0 | vets MCP servers and skills for tool poisoning | adopt next (vet third-party skills) |
| [cisco-ai-defense/skill-scanner](https://github.com/cisco-ai-defense/skill-scanner) | Cisco | 2.7k | 2.3.2, 2026-10-26 | NOASSERTION | scans SKILL.md and scripts before install | adopt next |
| [wiz-sec-public/secure-rules-files](https://github.com/wiz-sec-public/secure-rules-files) | Wiz | 244 | push 2025-12-23 | NOASSERTION | baseline rules files | know |
| [SecureCodeWarrior/ai-security-rules](https://github.com/SecureCodeWarrior/ai-security-rules) | Secure Code Warrior | 67 | 1.2.0, 2026-02-06 | none | rules by domain | know |
| [Arcanum-Sec/sec-context](https://github.com/Arcanum-Sec/sec-context) | Arcanum | 600 | push 2026-02-24 | none | AI code anti-pattern corpus | know |
| [TikiTribe/claude-secure-coding-rules](https://github.com/TikiTribe/claude-secure-coding-rules) | TikiTribe | 144 | push 2026-05-26 | MIT | web, IaC, CI/CD, agentic rules | know |
| [matank001/cursor-security-rules](https://github.com/matank001/cursor-security-rules) | matank001 | 383 | push 2025-08-27 | MIT | Cursor rules | know |
| [OpenSSF guide for AI code assistant instructions](https://best.openssf.org/Security-Focused-Guide-for-AI-Code-Assistant-Instructions) | OpenSSF | | 2025-08-01 | Apache-2.0 | how to write CLAUDE.md and similar files securely | use (standard) |
| [GitLab Duo security agents](https://docs.gitlab.com/user/duo_agent_platform/) | GitLab | | GA 2026-01-15 | proprietary (Ultimate) | triage on GitLab scanner output | know |
| [Copilot coding agent security validation](https://github.blog/changelog/2025-10-28-copilot-coding-agent-now-automatically-validates-code-security-and-quality/) | GitHub | | 2025-10-28 | proprietary | agent checks its own PRs | know |
| [usestrix/strix](https://github.com/usestrix/strix), [BugTraceAI](https://github.com/BugTraceAI/BugTraceAI) | | | | | autonomous attack agents | know (never run) |
| [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) | | 57k | push 2026-11-02 | NOASSERTION | index of skills | know |

## 2. Static and config tools

### 2a. Source code (SAST)

| Tool | Maintainer | Stars | Release | License | Use | Status |
| --- | --- | --- | --- | --- | --- | --- |
| [Semgrep](https://github.com/semgrep/semgrep) | Semgrep | 17.4k | 1.183.0 installed | LGPL-2.1 | pattern SAST, `--metrics=off` | use |
| [Opengrep](https://github.com/opengrep/opengrep) | consortium | 3.3k | v1.33.1, 2026-10-29 | LGPL-2.1 | open fork of Semgrep CE | know |
| [CodeQL](https://github.com/github/codeql) | GitHub | 10.3k | bundle v2.27.3, 2026-10-20 | MIT queries, CLI own terms | dataflow for JS/TS, Python, Go, Actions | adopt next (check CLI terms for private repos) |
| [SonarQube](https://github.com/SonarSource/sonarqube) | SonarSource | 11.1k | 26.10.0, 2026-10-12 | LGPL-3.0 | company gate (see company-standards.md) | use (company) |
| [Bearer](https://github.com/Bearer/bearer) | Cycode | 2.8k | v2.1.3, 2026-10-28 | NOASSERTION | privacy and PII data-flow | adopt next |
| [njsscan](https://github.com/ajinabraham/njsscan) | Ajin Abraham | 458 | 1.0.2, 2026-10-27 | LGPL-3.0 | Node.js patterns | know |
| [Bandit](https://github.com/PyCQA/bandit) | PyCQA | 8.4k | 1.9.4, 2026-02-25 | Apache-2.0 | Python AST checks | adopt next (Python repos) |
| [Ruff `S` rules](https://github.com/astral-sh/ruff) | Astral | 50.4k | 0.17.3, 2026-10-27 | MIT | fast Bandit rules | adopt next (Python repos) |
| [gosec](https://github.com/securego/gosec) | securego | 9.0k | v2.30.0, 2026-10-23 | Apache-2.0 | Go SAST | adopt next (Go repos) |
| [golangci-lint](https://github.com/golangci/golangci-lint) | golangci | 19.5k | v2.15.0, 2026-10-16 | GPL-3.0 | runs gosec in lint | adopt next (Go repos) |
| [govulncheck](https://github.com/golang/vuln) | Go team | 532 | v1.9.0 tag | BSD-3-Clause | reachability-aware Go advisories | adopt next (Go repos) |
| [eslint-plugin-security](https://github.com/eslint-community/eslint-plugin-security) | ESLint community | 2.4k | v4.2.1, 2026-10-30 | Apache-2.0 | Node/TS risky patterns | adopt next |
| [eslint-plugin-no-unsanitized](https://github.com/mozilla/eslint-plugin-no-unsanitized) | Mozilla | 249 | v4.1.5, 2026-02-19 | MPL-2.0 | DOM XSS sinks | adopt next |
| [DevSkim](https://github.com/microsoft/DevSkim) | Microsoft | 1.0k | v1.0.100, 2026-09-29 | MIT | IDE/CLI linter | know |
| [Fortify](https://www.opentext.com/products/fortify-static-code-analyzer) | OpenText | | | proprietary | the company's former code scanner, replaced by SonarQube | know |

### 2b. Dependencies (SCA)

| Tool | Stars | Release | License | Use | Status |
| --- | --- | --- | --- | --- | --- |
| `pnpm audit` / `npm audit` | built in | | | lockfile advisories | use |
| [osv-scanner](https://github.com/google/osv-scanner) | | 2.7.0 installed | Apache-2.0 | lockfile advisories across ecosystems | use |
| [Dependabot](https://github.com/dependabot/dependabot-core) | 5.8k | v0.402.0, 2026-10-27 | MIT | update PRs with `cooldown` | adopt next (GitHub repos) |
| [Renovate](https://github.com/renovatebot/renovate) | 23.0k | 44.202.0, 2026-11-02 | AGPL-3.0 | update MRs on GitLab, `minimumReleaseAge` | adopt next (GitLab repos) |
| [Snyk CLI](https://github.com/snyk/cli) | 5.7k | v1.1308.3, 2026-10-23 | NOASSERTION | SCA, container, IaC | know (account) |
| [OWASP Dependency-Check](https://github.com/dependency-check/DependencyCheck) | 7.8k | v13.0.0, 2026-08-03 | Apache-2.0 | NVD/CPE SCA auditors use | know |
| [pip-audit](https://github.com/pypa/pip-audit) | 1.4k | v2.10.1, 2026-06-10 | Apache-2.0 | Python advisories | adopt next (Python repos) |
| [Safety](https://github.com/pyupio/safety) | 2.0k | 3.8.1, 2026-05-29 | none | Python SCA, commercial DB | know |
| [Socket CLI](https://github.com/SocketDev/socket-cli) | 335 | v1.1.146, 2026-07-24 | MIT | malicious or behavior-changed packages | adopt next |
| [npq](https://github.com/lirantal/npq) | 1.8k | v3.27.2, 2026-10-07 | Apache-2.0 | pre-install vetting | know |

### 2c. Secrets

| Tool | Stars | Release | License | Use | Status |
| --- | --- | --- | --- | --- | --- |
| [gitleaks](https://github.com/gitleaks/gitleaks) | | 8.30.1 installed | MIT | repo and history | use |
| [trufflehog](https://github.com/trufflesecurity/trufflehog) | | 3.99.7 installed | AGPL-3.0 | history sweep; run with `--no-verification` on company repos so no candidate is sent to a provider | use |
| [detect-secrets](https://github.com/Yelp/detect-secrets) | 4.7k | v1.5.0, 2024-05-06 | Apache-2.0 | baseline-file workflow | know (stale releases) |
| [ggshield](https://github.com/GitGuardian/ggshield) | 2.0k | v1.56.1, 2026-10-26 | MIT | needs a GitGuardian key | know |
| [Titus](https://github.com/praetorian-inc/titus) | 761 | v1.2.11, 2026-10-08 | Apache-2.0 | Nosey Parker successor | know |
| [GitLab Secret Detection](https://docs.gitlab.com/user/application_security/secret_detection/) | built in | | | CI template | adopt next (GitLab repos, with the owning team) |

### 2d. IaC, Kubernetes, policy

| Tool | Stars | Release | License | Use | Status |
| --- | --- | --- | --- | --- | --- |
| [kube-linter](https://github.com/stackrox/kube-linter) | | 0.8.3 installed | Apache-2.0 | rendered manifests | use |
| [kubescape](https://github.com/kubescape/kubescape) | | v4.0.17 installed | Apache-2.0 | manifests against NSA/CISA and CIS controls (file scan only) | use |
| [Checkov](https://github.com/bridgecrewio/checkov) | 9.1k | 3.4.0, 2026-10-28 | Apache-2.0 | k8s, Helm, Dockerfile, GHA, GitLab CI | adopt next |
| [KICS](https://github.com/Checkmarx/kics) | 2.7k | v2.2.0, 2026-09-17 | Apache-2.0 | multi-format IaC | know |
| [Polaris](https://github.com/FairwindsOps/polaris) | 3.4k | v10.2.5, 2026-09-18 | Apache-2.0 | workload checks | know |
| [kube-bench](https://github.com/aquasecurity/kube-bench) | 8.2k | v0.16.0, 2026-08-05 | Apache-2.0 | CIS node checks with k3s profiles; runs on the node, so only with the platform owner | know |
| [kubesec](https://github.com/controlplaneio/kubesec) | 1.5k | v2.15.0, 2026-10-08 | Apache-2.0 | manifest risk score | know |
| [Popeye](https://github.com/derailed/popeye) | 6.5k | v0.22.1, 2025-01-28 | NOASSERTION | live cluster sanitizer | know |
| [Prowler](https://github.com/prowler-cloud/prowler) | 15.2k | 5.47.0, 2026-10-29 | Apache-2.0 | cloud and k8s CIS | know |
| [trivy-operator](https://github.com/aquasecurity/trivy-operator) | 2.0k | v0.36.1, 2026-10-29 | Apache-2.0 | in-cluster scans | know (platform team) |
| [Kyverno](https://github.com/kyverno/kyverno) + [policies](https://github.com/kyverno/policies) | 8.3k | v1.19.2, 2026-10-20 | Apache-2.0 | Pod Security policies, Audit mode | know (platform team) |
| [Gatekeeper](https://github.com/open-policy-agent/gatekeeper) + [library](https://github.com/open-policy-agent/gatekeeper-library) | 4.3k | v3.23.1, 2026-08-27 | Apache-2.0 | Rego constraints | know |
| [Conftest](https://github.com/open-policy-agent/conftest) | 3.3k | v0.71.1, 2026-10-06 | NOASSERTION | Rego tests on config files | adopt next |
| [Security Profiles Operator](https://github.com/kubernetes-sigs/security-profiles-operator) | 879 | v1.1.2, 2026-10-29 | Apache-2.0 | seccomp/AppArmor | know |
| Terrascan | | archived | | | skip (use Checkov or KICS) |

### 2e. Containers and hosts

| Tool | Stars | Release | License | Use | Status |
| --- | --- | --- | --- | --- | --- |
| [Trivy](https://github.com/aquasecurity/trivy) | | 0.76.1 installed | Apache-2.0 | fs, config, image | use. Supply-chain incident 2026-03-19 (CVE-2026-33634): trivy-action tags were repointed and v0.69.4 was affected. Install from a release checked against its digest; pin any Action by full SHA |
| [hadolint](https://github.com/hadolint/hadolint) | | 2.15.1 installed | GPL-3.0 | Dockerfile lint | use |
| [Grype](https://github.com/anchore/grype) | 13.2k | v0.121.0, 2026-10-19 | Apache-2.0 | image and SBOM scan | adopt next (second opinion to Trivy) |
| [Syft](https://github.com/anchore/syft) | 9.8k | v1.55.0, 2026-10-19 | Apache-2.0 | SBOM | adopt next |
| [Docker Scout](https://docs.docker.com/scout/) | 457 | v1.29.0, 2026-10-28 | NOASSERTION | image CVEs | know |
| [Dockle](https://github.com/goodwithtech/dockle) | 3.3k | v0.4.15, 2025-01-06 | Apache-2.0 | CIS Docker image lint | know |
| [docker-bench-security](https://github.com/docker/docker-bench-security) | 9.7k | v1.6.1, 2023-12-20 | Apache-2.0 | host CIS Docker | know |
| [gixy fork](https://github.com/dvershinin/gixy) | 1.2k | v0.2.60, 2026-10-30 | NOASSERTION | nginx config analyzer | adopt next (nginx repos) |
| yandex/gixy | 8.6k | push 2024-07 | | | skip (dormant; use the fork) |
| [pgdsat](https://github.com/HexaCluster/pgdsat) | 297 | v2.0, 2026-03-01 | GPL-3.0 | PostgreSQL CIS checks | know (needs DB access) |

### 2f. CI/CD

| Tool | Stars | Release | License | Use | Status |
| --- | --- | --- | --- | --- | --- |
| [zizmor](https://github.com/zizmorcore/zizmor) | 6.9k | v1.31.1, 2026-10-15 | MIT | GitHub Actions audit | adopt next |
| [actionlint](https://github.com/rhysd/actionlint) | 4.4k | v1.7.12, 2026-03-30 | MIT | workflow lint incl. expression injection | adopt next |
| [OpenSSF Scorecard](https://github.com/ossf/scorecard) | 5.8k | v5.6.0, 2026-10-12 | Apache-2.0 | repo posture score | adopt next (GitHub repos) |
| [Allstar](https://github.com/ossf/allstar) | 1.5k | v4.6, 2026-08-31 | Apache-2.0 | org policy app | know |
| [harden-runner](https://github.com/step-security/harden-runner) | 1.3k | v2.22.3, 2026-10-27 | Apache-2.0 | runner egress audit | know |
| [GitLab pipeline security](https://docs.gitlab.com/ci/pipeline_security/) | built in | | | GitLab CI guidance | use (standard) |

### 2g. TLS and headers (read-only)

| Tool | Release | License | Use | Status |
| --- | --- | --- | --- | --- |
| curl, one request at a time | | | headers, redirects, methods, certificate | use |
| [testssl.sh](https://github.com/testssl/testssl.sh) | v3.2.4, 2026-07-12 | GPL-2.0 | full TLS audit; it opens many handshakes, so on shared hosts only with the owner's OK | know |
| [SSLyze](https://github.com/nabla-c0d3/sslyze) | 6.3.1, 2026-03-29 | AGPL-3.0 | scriptable TLS checks | know (same rule) |
| [MDN HTTP Observatory](https://github.com/mdn/mdn-http-observatory) | v1.7.2, 2026-10-26 | MPL-2.0 | header grading, runnable locally | adopt next (public sites only) |
| [Mozilla SSL config generator](https://ssl-config.mozilla.org/) | live | MPL-2.0 | nginx/Traefik TLS templates | use (reference) |
| [Qualys SSL Labs](https://www.ssllabs.com/ssltest/) | | proprietary | public TLS grade | know (public sites only) |
| securityheaders.com | | proprietary | header grade | know (unverified) |
| [OWASP ZAP](https://github.com/zaproxy/zaproxy) | v2.17.0, 2025-12-15 | Apache-2.0 | the company's web scanner | know (security team runs it) |
| mozilla/http-observatory | archived | | | skip (use the MDN one) |

### 2h. SBOM, provenance, findings

| Project | Release | License | Use | Status |
| --- | --- | --- | --- | --- |
| [SLSA](https://slsa.dev/spec/) | v1.2 | | provenance levels | use (standard) |
| [cosign](https://github.com/sigstore/cosign) | v3.1.4, 2026-10-20 | Apache-2.0 | image signing | know (registry owner) |
| [gitsign](https://github.com/sigstore/gitsign) | v0.18.0, 2026-10-20 | NOASSERTION | keyless commit signing | know |
| [in-toto](https://github.com/in-toto/in-toto) | v3.1.0, 2026-05-04 | NOASSERTION | attestations | know |
| [CycloneDX](https://github.com/CycloneDX/specification) / [cdxgen](https://github.com/cdxgen/cdxgen) | 1.7.2 / v13.6.0 | Apache-2.0 | SBOM format and generator | adopt next |
| [SPDX](https://spdx.dev/) | 3.0.1 | | ISO SBOM format | know |
| [OpenVEX / vexctl](https://openvex.dev/) | v0.4.4, 2026-06-16 | Apache-2.0 | "not affected" statements, matches the company's explanation pages | adopt next |
| [GUAC](https://github.com/guacsec/guac) | v1.1.0, 2026-03-13 | Apache-2.0 | SBOM graph | know |
| [Dependency-Track](https://github.com/DependencyTrack/dependency-track) | 5.2.1, 2026-10-25 | Apache-2.0 | SBOM monitoring | know |
| [DefectDojo](https://github.com/DefectDojo/django-DefectDojo) | 3.4.304, 2026-10-30 | BSD-3-Clause | findings dedupe | know |

## 3. Standards

| Standard | Version (checked 2026-11-02) | Use |
| --- | --- | --- |
| [OWASP ASVS](https://github.com/OWASP/ASVS) | 5.0.0 (May 2025) | review checklist |
| [OWASP Top 10](https://top10.owasp.org/2025) | 2025 (A03 Software Supply Chain Failures, A10 Mishandling of Exceptional Conditions) | shared vocabulary |
| [OWASP API Security Top 10](https://owasp.org/API-Security/editions/2023/en/0x11-t10/) | 2023 | API review |
| [OWASP WSTG](https://owasp.org/www-project-web-security-testing-guide/) | v4.2 stable, latest rolling | what pen testers follow |
| [OWASP Cheat Sheet Series](https://cheatsheetseries.owasp.org/) | rolling | fix guidance |
| [OWASP SAMM](https://owaspsamm.org/model/) | v2 | program maturity |
| [OWASP Kubernetes Top 10](https://owasp.org/www-project-kubernetes-top-ten/), [CI/CD Top 10](https://owasp.org/www-project-top-10-ci-cd-security-risks/) | live | cluster and pipeline review |
| [OWASP LLM Top 10](https://genai.owasp.org/llm-top-10/), [Agentic Top 10](https://genai.owasp.org/resource/owasp-top-10-for-agentic-applications-for-2026) | 2025, "for 2026" | the company pen test uses both (company-standards.md) |
| [CIS Kubernetes](https://www.cisecurity.org/benchmark/kubernetes), [K3s hardening](https://docs.k3s.io/security/hardening-guide) | 2.1.0; K3s self-assessments | cluster baseline |
| [CIS Docker](https://www.cisecurity.org/benchmark/docker), [PostgreSQL](https://www.cisecurity.org/benchmark/postgresql), [NGINX](https://www.cisecurity.org/benchmark/nginx) | 1.9.0; PG16 1.1.0; 2.1.0 | host and service baselines |
| [Kubernetes Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/), [security checklist](https://kubernetes.io/docs/concepts/security/security-checklist/) | current | `restricted` for apps |
| [NSA/CISA Kubernetes Hardening Guide](https://media.defense.gov/2022/Aug/29/2003066362/1/1/0/CTR_KUBERNETES_HARDENING_GUIDANCE_1.2_20220829.PDF) | v1.2 (2022) | hardening baseline |
| [NIST SSDF SP 800-218](https://csrc.nist.gov/pubs/sp/800/218/final) | v1.1; Rev.1 draft 2025-12 | process map |
| [NIST SP 800-53](https://csrc.nist.gov/News/2025/nist-releases-revision-to-sp-800-53-controls) | Release 5.2.0 | controls AC-3/6, AU-2/12, CM-6/7, IA-2/5, RA-5, SA-11, SC-8/13, SI-2/7, SR |
| [NIST SP 800-190](https://csrc.nist.gov/pubs/sp/800/190/final), [800-204](https://csrc.nist.gov/pubs/sp/800/204/final), [800-63B-4](https://csrc.nist.gov/pubs/sp/800/63/b/4/final) | final | containers, microservices, authenticators |
| [CWE Top 25](https://cwe.mitre.org/top25/archive/2025/2025_cwe_top25.html) | 2025 | weakness ranking |
| [MITRE ATT&CK Containers](https://attack.mitre.org/matrices/enterprise/containers/) | v20.0 | attacker technique language |
| [CAPEC](https://capec.mitre.org/), [D3FEND](https://d3fend.mitre.org/) | 3.9, 1.6.0 | attack patterns, countermeasures |
| [RFC 9700 OAuth 2.0 Security BCP](https://www.rfc-editor.org/rfc/rfc9700), [OIDC Core](https://openid.net/specs/openid-connect-core-1_0.html) | | sign-in review |
| [OpenSSF Concise Guide](https://best.openssf.org/Concise-Guide-for-Developing-More-Secure-Software) | | developer guide |
| [CISA Secure by Design](https://www.cisa.gov/securebydesign) | | policy framing |
| Stack guides: [Next.js data security](https://nextjs.org/docs/app/guides/data-security), [Next.js CSP](https://nextjs.org/docs/app/guides/content-security-policy), [Go security](https://go.dev/doc/security/best-practices), [Mozilla Server Side TLS](https://wiki.mozilla.org/Security/Server_Side_TLS), [pg_hba](https://www.postgresql.org/docs/current/auth-pg-hba-conf.html), [Docker engine security](https://docs.docker.com/engine/security/) | | framework-native fixes |

## 4. Purple team and detection (knowledge only)

| Project | Release | License | Use |
| --- | --- | --- | --- |
| [Sigma](https://github.com/SigmaHQ/sigma) / [pySigma](https://github.com/SigmaHQ/pySigma) | r2026-07-01 / v2.0.2 | DRL / LGPL-2.1 | detection format; has Kubernetes audit rules |
| [Falco](https://github.com/falcosecurity/falco) + [rules](https://github.com/falcosecurity/rules) | 0.45.2 / 5.2.0 | Apache-2.0 | runtime and k8s audit detection |
| [Tetragon](https://github.com/cilium/tetragon), [Tracee](https://github.com/aquasecurity/tracee) | v1.8.0, v0.24.1 | Apache-2.0 | eBPF runtime |
| [Kubernetes auditing](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/) | current | | audit policy levels |
| [Elastic detection-rules](https://github.com/elastic/detection-rules), [Splunk security_content](https://github.com/splunk/security_content) | | Elastic / Apache-2.0 | rules mapped to ATT&CK |
| [ATT&CK STIX data](https://github.com/mitre-attack/attack-stix-data), [Navigator](https://mitre-attack.github.io/attack-navigator/) | v20.0 | | coverage heatmaps |
| [Microsoft Threat Matrix for Kubernetes](https://microsoft.github.io/Threat-Matrix-for-Kubernetes/) | | | k8s matrix |
| [Mappings Explorer](https://center-for-threat-informed-defense.github.io/mappings-explorer/) | v1.1.0 | Apache-2.0 | 800-53 to ATT&CK |
| [Palantir ADS framework](https://github.com/palantir/alerting-detection-strategy-framework) | | MIT | detection write-up template |
| [awesome-detection-engineering](https://github.com/infosecB/awesome-detection-engineering) | | CC0 | reading index |
| [ThreatHunter-Playbook](https://github.com/OTRF/ThreatHunter-Playbook) | | MIT | hunting method |
| [VECTR](https://github.com/SecurityRiskAdvisors/VECTR) | ce-9.14.1 | none | purple exercise tracking |
| [SCYTHE PTEF](https://github.com/scythe-io/purple-team-exercise-framework) | | | exercise framework |

Left out on purpose: attack-emulation frameworks and payload or template collections (they would send attack traffic, which the rules forbid).

## Archived or moved (do not adopt)

tenable/terrascan (archived), praetorian-inc/noseyparker (archived, use Titus), semgrep/mcp (archived, now in the semgrep CLI), mozilla/http-observatory (archived, use mdn/mdn-http-observatory), mozilla/ssl-config-generator (moved to tlsref/configurator), jeremylong/DependencyCheck (moved to dependency-check/DependencyCheck), yandex/gixy (dormant, use dvershinin/gixy), meta/pyre-check (archived), OWASP/samm repo (archived, model on owaspsamm.org).
