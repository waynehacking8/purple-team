#!/bin/bash
# One entry point for a review: steps 1, 3 and 6, plus the templates for steps 2, 4, 5 and 8.
# usage: review.sh <repo-dir> <out-dir> [<https-base-url> <paths-file>]
# Static work is local. The live check runs only when a base URL is given (GET, HEAD, OPTIONS only).
set -u
D=$(cd "$(dirname "$0")" && pwd)
[ $# -eq 2 ] || [ $# -eq 4 ] || { echo "usage: review.sh <repo-dir> <out-dir> [<https-base-url> <paths-file>]" >&2; exit 2; }
REPO=$1; OUT=$2; mkdir -p "$OUT"
"$D/detect-stack.sh" "$REPO" > "$OUT/CONTEXT.md"
"$D/static-pass.sh" "$REPO" "$OUT" > /dev/null
[ $# -eq 4 ] && "$D/live-check.sh" "$3" "$4" > "$OUT/LIVE.txt"
cat > "$OUT/PREDICTION.md" <<'T'
# Prediction (write before the company scan; compare after)

| Check | Expected finding | Severity | Cause (file:line or config) | Real or false positive | Evidence |
| --- | --- | --- | --- | --- | --- |
| Code scan (SonarQube) | | | | | |
| Web scan (ZAP) | | | | | |
| Host scan (Nessus) | | | | | |
| Pen test | | | | | |

Checklist (SKILL.md step 5): every answer type and port; headers per answer; OPTIONS versus served methods; TRACE/TRACK answers; every Set-Cookie; every open port and its certificate; banners; dependency and image advisories; crawlable parameters and per-request answers.
T
cat > "$OUT/FINDINGS.md" <<'T'
# Findings

States: confirmed, needs validation, rejected (reason), known and accepted (record and what it leaves out).

| ID | State | Severity | Where | Evidence | Fix or explanation |
| --- | --- | --- | --- | --- | --- |
T
echo "wrote $OUT: CONTEXT.md, SUMMARY.txt and tool files, PREDICTION.md, FINDINGS.md$([ $# -eq 4 ] && echo ', LIVE.txt')"
cat "$OUT/SUMMARY.txt"
