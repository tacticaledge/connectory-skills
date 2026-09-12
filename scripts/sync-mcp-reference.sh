#!/usr/bin/env bash
# Copy canonical MCP rules into each skill folder (npx skills copies per-skill dirs only).
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
source="${root}/skills/connectory/_reference.md"
targets=(
  skills/connectory/auto-check/references/mcp-rules.md
  skills/connectory/check-changes/references/mcp-rules.md
  skills/connectory/check-code/references/mcp-rules.md
  skills/connectory/check-idea/references/mcp-rules.md
  skills/connectory/check-plan/references/mcp-rules.md
  skills/connectory/use-connectory/references/mcp-rules.md
)
for rel in "${targets[@]}"; do
  dest="${root}/${rel}"
  mkdir -p "$(dirname "$dest")"
  cp "${source}" "${dest}"
done
echo "Synced ${#targets[@]} references from skills/connectory/_reference.md"
