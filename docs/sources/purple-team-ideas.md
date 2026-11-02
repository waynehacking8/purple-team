# Purple team ideas (SCYTHE PTEF and others): what we take

Sources: github.com/scythe-io/purple-team-exercise-framework (method), PurpleOps, PurpleSharp, MITRE Caldera, Atomic Red Team (read 2026-11-02 from search results).

Decision (2026-11-02): no red-team half. Red work means sending attack traffic, which Wayne ruled out for shared systems, and the company security team already does it (ZAP, Nessus, pen test).

## Borrowed (defensive form)
- Attacker view without traffic: threat model (STRIDE) and abuse cases written from the code and rendered config before fixing.
- The company scan is the red side. Before each rescan, write the predicted findings; after it, compare prediction and report, and add every miss to references as a new check (regression loop, PTEF's continuous purple idea).
- Detection coverage, checked statically: sign-in failures, 401/403 spikes, rate-limit hits and admin actions are logged and have an alert rule (for FedGPT: Loki/Alloy and the v3.15 alert rules).

## Dropped
- Attack simulation tools (Caldera, Atomic Red Team, PurpleSharp): they execute techniques.
- PurpleOps tracking app: we track in Jira.
