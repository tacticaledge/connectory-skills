---
name: connectory-setup
description: >-
  Set up Connectory MCP and Agent Skills in this IDE. Use when the user asks to install
  Connectory, connect MCP, set up check_* tools, or get started with Connectory.
disable-model-invocation: true
---

# Connectory setup

Guide the user through the public install bridge:
[github.com/tacticaledge/connectory-skills](https://github.com/tacticaledge/connectory-skills)

## Order

1. **MCP** (required): follow the doc for their IDE under `docs/install-*.md` in that repo,
   or copy from `examples/`. URL: `https://api.connectory.ai/mcp`.
   OAuth via GitHub in IDE settings. Product home: `https://app.connectory.ai`.
2. **Verify**: call MCP `whoami`. Expect `orgs` with at least one slug.
3. **Skills** (recommended): `npx skills add https://github.com/tacticaledge/connectory-skills -a <agent> --copy -y`
4. **Try**: `/check-plan` with something they are working on.

## Agent mapping

| IDE | `npx skills -a` |
|-----|-----------------|
| Cursor | `cursor` |
| Claude Code | `claude-code` |
| Codex | `codex` |
| VS Code | `vscode` |

Do not install application Python packages. MCP + skills only.
