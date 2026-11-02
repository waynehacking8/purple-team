# SpecterOps, "Leveling Up Secure Code Reviews with Claude Code" (2026-03-26): what we take

Source: https://specterops.io/blog/2026/03/26/leveling-up-secure-code-reviews-with-claude-code/ (read 2026-11-02).

## Borrowed
- Use the model to understand the code; the reviewer decides what is a finding.
- One reusable service-context block per repo: name, purpose, data stores, authorization model, URLs, language and framework, API spec location, key folders. Our step 1 (detect the service) writes exactly this.
- Fixed output shape per surface: data flow summary, sources, sinks, step-by-step walkthrough.
- Confidence per conclusion: high (evidence in the code), medium or low (depends on code or config not seen).
- No finding without code evidence: file path, line, function.
- Credit secure patterns as well as gaps, so later runs do not re-question controls already proven.
- Iterate narrowly: a fresh context per line of inquiry; save confirmed facts to the run notes.
- Triage by component (workers, input handlers, auth) and set low-risk parts aside explicitly.
- Every model claim is a hypothesis until checked against the source.

## Dropped
- Proxy/MCP integration and testing in a lab: we do no live testing beyond single read-only requests.
