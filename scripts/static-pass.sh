#!/bin/bash
# Static tool pass for one repo. Local only: no network calls to scanned systems.
# usage: static-pass.sh <repo-dir> <out-dir>
# Put rendered Kubernetes manifests in <out-dir>/manifests/ first if the repo has a renderer.
set -u
if [ $# -ne 2 ] || [ ! -d "$1" ]; then echo "usage: static-pass.sh <repo-dir> <out-dir>" >&2; exit 2; fi
REPO=$(cd "$1" && pwd); OUT=$2; mkdir -p "$OUT"; OUT=$(cd "$OUT" && pwd)
PATH="$HOME/.local/bin:$PATH"
S="$OUT/SUMMARY.txt"; : > "$S"
run() { # name, then the command; records ran/failed/skipped with the exit code
  local name=$1; shift
  if ! command -v "$1" >/dev/null 2>&1; then echo "$name: skipped ($1 not installed)" >> "$S"; return; fi
  (cd "$REPO" && "$@") > "$OUT/$name.txt" 2>&1; local rc=$?
  echo "$name: exit $rc, $(wc -l < "$OUT/$name.txt" | tr -d ' ') lines" >> "$S"
}
run semgrep semgrep scan --metrics=off --config p/security-audit --config p/secrets --config p/typescript --config p/javascript --config p/python --config p/golang --config p/dockerfile --config p/kubernetes --error --quiet .
# Secrets: findings are redacted; never print values.
echo "git history: $(cd "$REPO" && git rev-list --count HEAD 2>/dev/null || echo 0) commits scanned by the secret tools" >> "$S"
run gitleaks gitleaks git --redact --no-banner .
run trufflehog trufflehog git "file://$REPO" --no-verification --no-update --json
run osv-scanner osv-scanner scan source -r .
[ -f "$REPO/pnpm-lock.yaml" ] && run pnpm-audit pnpm audit --prod
[ -f "$REPO/package-lock.json" ] && run npm-audit npm audit --omit=dev
# Python: lint for security patterns; advisories need a lockfile.
if [ -f "$REPO/pyproject.toml" ] || [ -f "$REPO/requirements.txt" ]; then
  run ruff-security ruff check --select S --ignore S101 --no-cache .
  run bandit bandit -r . -q -s B101 -x ./.venv,./node_modules
fi
# A repo without a lockfile gets no advisory coverage, which looks the same as clean.
locks=$(cd "$REPO" && ls pnpm-lock.yaml package-lock.json yarn.lock poetry.lock uv.lock Pipfile.lock requirements*.txt go.sum Cargo.lock 2>/dev/null | tr '\n' ' ')
[ -z "$locks" ] && echo "WARNING: no lockfile found; dependency advisories were not checked" >> "$S"
run trivy-fs trivy fs --scanners vuln,misconfig,secret --skip-dirs node_modules --quiet .
for f in $(cd "$REPO" && find . -name 'Dockerfile*' -not -path './node_modules/*' | head -20); do
  run "hadolint-$(echo "$f" | tr '/.' '__')" hadolint "$f"
done
if [ -d "$OUT/manifests" ]; then
  run kube-linter kube-linter lint "$OUT/manifests"
  run kubescape kubescape scan "$OUT/manifests" --format pretty-printer
elif [ -n "$(cd "$REPO" && ls compose*.y*ml docker-compose*.y*ml */compose*.y*ml 2>/dev/null)" ]; then
  echo "compose: found, not covered by kube-linter or kubescape; review by hand (privileges, cap_drop, ipc, ports, image pins)" >> "$S"
else
  echo "kubernetes: skipped (no $OUT/manifests; render the overlays first)" >> "$S"
fi
cat "$S"
