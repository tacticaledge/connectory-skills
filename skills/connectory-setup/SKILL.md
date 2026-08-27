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
   global install in `~/.cursor/mcp.json` (not duplicated per project). **Kiro:** use
   `.kiro/settings/mcp.json` for a project install or `~/.kiro/settings/mcp.json` globally.
   Default URL: `https://api.connectory.ai/mcp`. If the user explicitly supplies a different
   Connectory MCP URL, use that URL consistently instead of the default; do not silently
   rewrite it. OAuth via GitHub in IDE settings (Connect, not Logout). Product home:
   `https://app.connectory.ai`. **Codex:** the `[mcp_servers.connectory]` block must include
   `tool_timeout_sec = 600`; its omitted default is 60 seconds, while Connectory analysis
   can legitimately take several minutes. This is separate from `startup_timeout_sec`.
   **Kiro:** set the `connectory` server's `"timeout": 600000` (milliseconds); do not
   confuse it with Kiro's MCP initialization timeout. Do not add timeout fields that the
   selected host does not document.
2. **Rebind after a loaded config change**: if an already-running host had loaded a different
   Connectory URL or timeout,
   the MCP tools already loaded in the current host may still target the previous server.
   Do **not** call that session's `whoami` or use it to diagnose identity or membership.
   Follow the host guide's reload action, stop, and resume after the host reconnects.
   For the Codex IDE extension use **gear menu → MCP servers → Restart extension**;
   starting another chat in the same extension host is not a rebind. On resume, run
   `codex mcp get connectory` and require the exact requested URL before continuing.
   A first-time install configured before the host connects needs no extra rebind. Skip this
   step when setup made no change to configuration the host had already loaded.
3. **Authenticate**: complete the host's OAuth flow after the rebind when authentication
   is required.
4. **Verify**: only from the rebound host, call MCP `whoami`. Expect `orgs` with at least
   one slug. If the identity is unexpected, first re-check the configured URL and rebind;
   do not infer an organization-membership defect from a pre-rebind response.
5. **Skills** (recommended): `npx skills add https://github.com/tacticaledge/connectory-skills -a <agent> --copy -y`
6. **Try**: `/check-plan` with something they are working on.

## Agent mapping

| IDE | `npx skills -a` |
|-----|-----------------|
| Cursor | `cursor` |
| Kiro | `kiro-cli` |
| Claude Code | `claude-code` |
| Codex | `codex` |
| VS Code / Copilot | `github-copilot` |

Do not install application Python packages. MCP + skills only.
