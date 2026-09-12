#!/usr/bin/env bash
# Customer install smoke test: npx skills add must copy skills WITH bundled references.
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
tmp="$(mktemp -d)"
trap 'rm -rf "${tmp}"' EXIT

"${root}/scripts/sync-mcp-reference.sh"

missing=0
agents=(cursor kiro-cli claude-code codex github-copilot windsurf)
skill_roots=(.agents/skills .kiro/skills .claude/skills .agents/skills .agents/skills .windsurf/skills)
skills=(auto-check check-changes check-code check-idea check-plan connectory-setup use-connectory)
referenced_skills=(auto-check check-changes check-code check-idea check-plan use-connectory)

for index in "${!agents[@]}"; do
  agent="${agents[index]}"
  install_dir="${tmp}/${agent}"
  mkdir -p "${install_dir}"
  cd "${install_dir}"
  npx --yes skills add "${root}" -a "${agent}" --copy -y >/dev/null
  skill_root="${install_dir}/${skill_roots[index]}"

  for skill in "${skills[@]}"; do
    if [[ ! -f "${skill_root}/${skill}/SKILL.md" ]]; then
      echo "MISSING ${agent} skill: ${skill}/SKILL.md" >&2
      missing=1
    fi
  done
  for skill in "${referenced_skills[@]}"; do
    if [[ ! -f "${skill_root}/${skill}/references/mcp-rules.md" ]]; then
      echo "MISSING ${agent} reference: ${skill}/references/mcp-rules.md" >&2
      missing=1
    fi
  done
done

if [[ "${missing}" -ne 0 ]]; then
  echo "verify-install: FAILED" >&2
  exit 1
fi

echo "verify-install: OK (6 agents; 7 skills, 6 bundled references each)"
