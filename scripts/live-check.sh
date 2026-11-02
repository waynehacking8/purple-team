#!/bin/bash
# Read-only live check: one GET, HEAD or OPTIONS request per line, nothing else.
# usage: live-check.sh <https-base-url> <paths-file>
# paths-file lines: "<METHOD> <path>", METHOD in GET, HEAD, OPTIONS. Blank and # lines are skipped.
set -u
if [ $# -ne 2 ] || [ ! -f "$2" ]; then echo "usage: live-check.sh <https-base-url> <paths-file>" >&2; exit 2; fi
BASE=${1%/}; HOST=$(echo "$BASE" | sed -E 's#^https?://([^/:]+).*#\1#')
while read -r m p; do
  case "$m" in ''|\#*) continue ;; GET|HEAD|OPTIONS) ;; *) echo "refused method: $m" >&2; continue ;; esac
  if [ "$m" = HEAD ]; then flag=(-I); else flag=(-X "$m"); fi
  hdr=$(curl -s -o /dev/null -D - --max-time 15 "${flag[@]}" "$BASE$p" | tr -d '\r')
  # Location query strings may carry OIDC state values: print only scheme, host and path.
  echo "$m $p | $(echo "$hdr" | grep -iE '^HTTP/|^location:|^allow:|^strict-transport-security:|^x-frame-options:|^x-content-type-options:|^content-security-policy:|^referrer-policy:|^server:|^x-powered-by:|^set-cookie:' | sed -E 's/^(location: [^?]*)\?.*/\1?<query>/I; s/^(set-cookie: [^=]*)=[^;]*/\1=<value>/I' | tr '\n' ' ')"
done < "$2"
echo "plain http | $(curl -s -o /dev/null -D - --max-time 10 "http://$HOST/" | tr -d '\r' | grep -iE '^HTTP/|^location:|^strict' | tr '\n' ' ')"
echo "certificate | $(echo | openssl s_client -connect "$HOST:443" -servername "$HOST" 2>/dev/null | openssl x509 -noout -issuer -enddate 2>/dev/null | tr '\n' ' ')"
