#!/usr/bin/env bash
# Customer install smoke test: npx skills add must copy skills WITH bundled references.
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
tmp="$(mktemp -d)"
trap 'rm -rf "${tmp}"' EXIT

"${root}/scripts/sync-mcp-reference.sh"

cd "${tmp}"
npx --yes skills add "${root}" -a cursor --copy -y >/dev/null
npx --yes skills add "${root}" -a kiro-cli --copy -y >/dev/null

missing=0
for skill in auto-check check-changes check-code check-idea check-plan connectory-setup; do
  if [[ ! -f ".agents/skills/${skill}/SKILL.md" ]]; then
    echo "MISSING Cursor skill: ${skill}/SKILL.md" >&2
    missing=1
  fi
  if [[ ! -f ".kiro/skills/${skill}/SKILL.md" ]]; then
    echo "MISSING Kiro skill: ${skill}/SKILL.md" >&2
    missing=1
  fi
done
for skill in auto-check check-changes check-code check-idea check-plan; do
  cursor_ref=".agents/skills/${skill}/references/mcp-rules.md"
  if [[ ! -f "${cursor_ref}" ]]; then
    echo "MISSING Cursor reference: ${cursor_ref}" >&2
    missing=1
  fi
  kiro_ref=".kiro/skills/${skill}/references/mcp-rules.md"
  if [[ ! -f "${kiro_ref}" ]]; then
    echo "MISSING Kiro reference: ${kiro_ref}" >&2
    missing=1
  fi
done

if [[ "${missing}" -ne 0 ]]; then
  echo "verify-install: FAILED" >&2
  exit 1
fi

echo "verify-install: OK (Cursor + Kiro; 6 skills, 5 bundled references each)"
