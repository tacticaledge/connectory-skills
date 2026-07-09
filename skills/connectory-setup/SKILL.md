---
name: connectory-setup
description: >-
  Set up Connectory MCP and Agent Skills in this IDE. Use when the user asks to install
  Connectory, connect MCP, set up check_* tools, or get started with Connectory.
disable-model-invocation: true
---

# Connectory setup

Guide the user through the setup guide in this repo:
[github.com/tacticaledge/connectory-skills](https://github.com/tacticaledge/connectory-skills)

## Order

1. **MCP** (required): follow `docs/install-*.md` in that repo. **Cursor:** prefer a single
   global install in `~/.cursor/mcp.json` (not duplicated per project). URL:
   `https://api.connectory.ai/mcp`. OAuth via GitHub in IDE settings (Connect, not Logout).
   Product home: `https://app.connectory.ai`.
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
