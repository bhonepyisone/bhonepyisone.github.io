#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "=== Building portfolio ==="
npm run build

echo "=== Deploying to GitHub Pages ==="
DEPLOY_DIR="$(mktemp -d)"
git clone --depth 1 --branch main "$(git remote get-url github-pages)" "$DEPLOY_DIR" >/dev/null 2>&1
rm -rf "$DEPLOY_DIR"/*
cp -R out/. "$DEPLOY_DIR"/
cd "$DEPLOY_DIR"
git add -A
git commit -m "Deploy $(date '+%Y-%m-%d %H:%M:%S')" || true
git push
rm -rf "$DEPLOY_DIR"

echo "=== Deployed to https://bhonepyisone.github.io ==="
