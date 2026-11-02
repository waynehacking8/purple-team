# Company practice: how the security team checks a service

Read 2026-11-02 from the company Confluence (FEDGPT and FP spaces) and from the SIV EHD-745 reports. Written in my own words; no internal hosts, addresses, credentials or customer names. Page titles are given so I can find the source again.

## 1. The three checks

Source: "安全性檢測方式" (2025-01), "SonarQube檢核規定" (2026-01), "上線前資安盤點：五項提醒的現況與缺口" (2026-09).

| Check | Tool | When | Target | Result |
| --- | --- | --- | --- | --- |
| Code scan | SonarQube (replaced Fortify) | daily scan at night; repo joins through the company codescan list | source repo | issues in SonarQube |
| Host scan | Nessus | daily, about 5 to 10 minutes; also on request before launch | staging host | report, usually needs dev changes |
| Web scan | OWASP ZAP | on request before launch | staging URLs | report |
| Pen test | security engineer, manual | on request, 3 to 4 days | staging, including the API | report |

Before a new service goes live the security engineer asks for all three of host scan, web scan and pen test.

## 2. Pass bars

1. Old rule (2025-01): every finding from Critical to Low must be fixed.
2. SonarQube release gate (2026-01): Security issues Blocker/High = 0; Medium count not higher than the previous release.
3. A fixed issue is closed by the next nightly scan (marked Fixed automatically).
4. A false positive or accepted risk is marked Accept / False Positive in SonarQube, always with the reason written down.
5. Maintainability is judged by the technical debt ratio; Security is the item the team tracks most.

## 3. How unfixed findings are explained

Source: the "掃描未修復的解釋說明" page family (ZAP, Nessus, Fortify, Trivy) and "Vulnerability Scan Review – Meeting Notes".

Every finding that stays open gets a short written explanation, kept on Confluence and handed to the customer when needed. The shape is the same across tools:

1. Severity and the scanner's finding name, as the report shows them.
2. Current protection state, with evidence the reader can repeat (for example, which HTTP answer a disabled method returns).
3. Why it is not a real risk here, or why it cannot be fixed now.
4. Compensating controls, when the fix itself is not possible (for example, nosniff, frame options and HSTS listed against a missing CSP).
5. Link to the authoritative source: the distro security tracker, the vendor's own assessment, the upstream issue.
6. For code findings: the file and function (sink details) and the purpose of the code.
7. For container CVEs: per image, per CVE, whether the vulnerable part is even compiled in or called.
8. Meeting-note form for bigger items: Risk, Reason, Mitigation plan, Long-term plan, Owner.
9. Items that did not appear in the latest scan are marked so they are not sent to the customer.

FAE also keeps one page per CVE with a fixed template: overview, type and CWE, risk level, impact, fix steps per firewall tool, and how to verify.

## 4. Pre-launch reminders from the security engineer

Source: "上線前資安盤點" (2026-09). Five items the security engineer asks about before launch, with the engineering answer recorded for each:

1. IP allow list for admin surfaces (internal DNS is not access control).
2. Upload checks: type, size, ownership, virus scan, encryption at rest.
3. Input field checks: limits on every paging and size parameter.
4. Database encryption for customer data.
5. Database credential management: no plaintext root credentials, per-service roles.

The same page records two things outside the list that the scans would hit: no HTTPS and no host firewall. Lesson: fix what the scanner will certainly find before booking the scan, or the report is buried in those items.

## 5. What the pen test covers

Source: "[FedGPT]OWASP 風險" (2026-01) and "[Intro]OWASP Top 10".

The security engineer tests by risk lists: OWASP Top 10 for the web app, OWASP LLM Top 10 and the Agentic Top 10 for AI features. Findings are written as list item, what was tried at the level of the feature, what happened, and the affected surface. For SIV this means access control between learners, admins and reviewers, and any AI feature, get the most attention.

## 6. Platform side

Source: "FedGPT 平台安全盤點與基礎元件改版計畫（2026-10）" (platform team).

The platform team keeps a CVE table per shipped component (version, advisory, severity, preconditions and exposure, fix) and plans base upgrades (K3s, Traefik, monitoring) by upstream end of life. Service owners do not patch the platform; they check the table for components their service depends on and ask the platform owner.

## 7. What this means for my workflow

1. Run the same kinds of checks before the security team does: SonarQube result (code), Trivy/osv-scanner (dependencies and images), headers/TLS/methods by single read-only requests (what ZAP and Nessus will see).
2. Use the company pass bar as the target: no Blocker/High security issue; nothing new at Medium.
3. Write every explain-only item in the company explanation shape (section 3), in Chinese, ready to paste into Jira or Confluence.
4. Answer the five pre-launch reminders for every new service, with evidence, before asking for the three checks.
5. Platform findings (k3s API certificate, host firewall, NTP) go to the platform or host owner through Jira, with the evidence; never change their systems.
