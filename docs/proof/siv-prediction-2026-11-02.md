# Proof run 1: predict the EHD-745 reports from code alone (SIV Reader, 2026-11-02)

Setup: a fresh agent (Sonnet) got a copy of the skill with the SIV-specific files removed (handoff, plan, the Nessus plugin list) and two hints stripped from step 5 (Next's 308, the k3s 6443 CA). The repo was a one-commit snapshot of 3b9ebaa5, the commit the security team scanned, with no history and no scan record. It rendered the dev and prod overlays offline, ran `static-pass.sh`, reviewed the code and wrote a prediction. The answer key (the two reports) stayed outside its reach.

## Score: 5 of 11 scored items

| Report item | Severity | Blind prediction | Score |
| --- | --- | --- | --- |
| ZAP SQL Injection (auth start `returnTo`, `/_next/image`, `/_next/static`) | High, false positive | expected no injection alerts | missed |
| ZAP Path Traversal (`?_rsc=`) | High, false positive | expected none | missed |
| ZAP Source Code Disclosure, File Inclusion | High, false positive | named the class, expected none | missed |
| ZAP Insecure HTTP Method DELETE (OPTIONS Allow on `/api/auth/*`) | Medium, real | auth route exports methods it never serves, so OPTIONS advertises them (file and fix right) | predicted |
| ZAP Proxy Disclosure (TRACE, TRACK) | Medium, explain | not considered | missed |
| ZAP Cookie Slack Detector | Low, info | not considered | missed |
| ZAP User Agent Fuzzer | Info | predicted | predicted |
| Nessus HSTS missing, tcp/443 | Medium, real | Next config redirect sends Location only (right cause) | predicted |
| Nessus HSTS missing, tcp/80 | Medium, real | trusted the design note "port 80 filtered" | missed |
| Nessus certificate cannot be trusted, tcp/6443 | Medium, explain | k3s serving CA on 6443 | predicted |
| Nessus self-signed, tcp/6443 | Medium, explain | k3s self-signed serving certificate | predicted |

The prediction also listed items the scanners did not report (clickjacking on Traefik answers, COOP/CORP, CSP `style-src`); those are not counted.

## Useful findings beyond the reports

1. The dependency advisories (better-auth via `@neondatabase/auth`, nodemailer, katex) with reachability: fixed the same day in #215.
2. `includeSubDomains; preload` on the shared prod apex host forces HTTPS for every subdomain of that host for a year: a decision for the apex owner, raised separately.
3. The code default for the auth backend is the unused Neon backend (fails closed with 503): already a deferred P4.

## What changed in the skill (purple loop)

Step 5 gained four checks, one per miss class:
1. list every crawlable parameter, framework ones included, and mark answers that change on every request; active scanners report those as High injection or disclosure, so predict them as false positives with evidence ready;
2. how routes answer TRACE, TRACK, DELETE, PUT (no echo, no proxy name) and that OPTIONS lists only served methods;
3. every Set-Cookie;
4. never trust a note that a port is closed; read the ingress controller's entrypoints.

Run 2 (after learning, so not blind) is recorded below once it finishes.
