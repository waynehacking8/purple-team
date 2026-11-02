#!/bin/bash
# Step 1 helper: print a context skeleton for a repo from files alone (no network).
# usage: detect-stack.sh <repo-dir>
set -u
[ $# -eq 1 ] && [ -d "$1" ] || { echo "usage: detect-stack.sh <repo-dir>" >&2; exit 2; }
cd "$1" || exit 2
has() { [ -n "$(find . -path ./node_modules -prune -o -path ./.git -prune -o -path ./.venv -prune -o "$@" -print 2>/dev/null | head -1)" ]; }
list() { find . -path ./node_modules -prune -o -path ./.git -prune -o -path ./.venv -prune -o "$@" -print 2>/dev/null | head -12 | tr '\n' ' '; }
echo "# Context: $(basename "$(pwd)")"; echo
echo "## Stack"
[ -f package.json ] && echo "- Node: $(python3 -I -c 'import json;d=json.load(open("package.json"));deps={**d.get("dependencies",{}),**d.get("devDependencies",{})};print(", ".join(f"{k} {deps[k]}" for k in ("next","react","express","fastify","hono","@nestjs/core","better-auth","next-auth","@auth/core","openid-client","jose","pg","drizzle-orm","prisma") if k in deps) or "no known framework")')"
[ -f pyproject.toml ] || [ -f requirements.txt ] && echo "- Python: $(grep -hoiE '(fastapi|flask|django|starlette|uvicorn|pydantic|sqlalchemy|authlib|pyjwt|openai|vllm)' pyproject.toml requirements*.txt 2>/dev/null | sort -fu | tr '\n' ' ')"
[ -f go.mod ] && echo "- Go: $(head -1 go.mod) $(grep -oE '(gin-gonic/gin|labstack/echo|go-chi/chi|gorilla/mux|coreos/go-oidc|golang-jwt/jwt)' go.mod | sort -u | tr '\n' ' ')"
echo "- Lockfiles: $(ls pnpm-lock.yaml package-lock.json yarn.lock poetry.lock uv.lock Pipfile.lock requirements*.txt go.sum Cargo.lock 2>/dev/null | tr '\n' ' ' || true)"
echo; echo "## Deploy shape"
has -name 'Dockerfile*' && echo "- Dockerfiles: $(list -name 'Dockerfile*')"
has \( -name 'compose*.y*ml' -o -name 'docker-compose*.y*ml' \) && echo "- Compose: $(list \( -name 'compose*.y*ml' -o -name 'docker-compose*.y*ml' \))"
k8s=$(grep -rlE '^kind: (Deployment|StatefulSet|Ingress|IngressRoute|Middleware|Service)' --include='*.y*ml' . 2>/dev/null | grep -v node_modules | head -8 | tr '\n' ' ')
[ -n "$k8s" ] && echo "- Kubernetes YAML: $k8s"
r=$(grep -rlE 'kind: *["'"'"']?(Deployment|IngressRoute|Middleware)' --include='*.mjs' --include='*.ts' --include='*.js' --include='*.py' scripts deploy infra 2>/dev/null | head -6 | tr '\n' ' ')
[ -n "$r" ] && echo "- Manifest renderers (render every overlay before step 3): $r"
grep -rqiE 'traefik' --include='*.y*ml' --include='*.mjs' --include='*.ts' . 2>/dev/null && echo "- Ingress: Traefik referenced"
has -name 'nginx*.conf' && echo "- Ingress: nginx config $(list -name 'nginx*.conf')"
echo "- CI: $(ls .gitlab-ci.yml .github/workflows/* 2>/dev/null | tr '\n' ' ')"
echo; echo "## Auth model (hints; confirm in code)"
grep -rhoiE '(oidc|openid|oauth2?|saml|ldap|entra|azure ad|microsoftonline|accounts\.google|next-auth|better-auth|jwt|bearer|session|csrf)' --include='*.ts' --include='*.tsx' --include='*.py' --include='*.go' --include='*.mjs' . 2>/dev/null | grep -v node_modules | tr 'A-Z' 'a-z' | sort | uniq -c | sort -rn | head -10 | sed 's/^/- /'
echo; echo "## Fill in by hand"
echo "- Who terminates TLS, entrypoints and ports per overlay:"
echo "- Public routes versus signed-in routes, roles:"
echo "- Personal data stored, where it is encrypted:"
echo "- AI features: untrusted input paths and actions the model can take:"
echo "- Owners of neighbour systems (platform, host, MIS, security team):"
