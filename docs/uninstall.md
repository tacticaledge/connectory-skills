# Uninstall Connectory MCP and skills

## MCP config

Remove the `connectory` entry only. Keep other MCP servers.

| File | Key to remove |
|------|----------------|
| `.cursor/mcp.json` | `mcpServers.connectory` |
| `.mcp.json` | `mcpServers.connectory` |
| `.vscode/mcp.json` | `servers.connectory` |
| `.codex/config.toml` | `[mcp_servers.connectory]` |

**CLI:**

```bash
codex mcp remove connectory      # if installed
claude mcp remove connectory     # if installed
```

**IDE:** Cursor **Settings → Tools & MCP** → disconnect or disable **connectory**.

## Skills

```bash
npx skills remove check-idea check-plan check-code check-changes auto-check -a cursor -y
```

Replace `-a cursor` with your agent. Also delete copied folders if an older setup wrote files
by hand:

- `.cursor/skills/connectory/`
- `.claude/skills/connectory/`
- `.agents/skills/connectory/`
- `.cursor/skills/connectory-institutional-knowledge/` (legacy name)

## AGENTS.md

Remove the `## Connectory` section if you added one from
[optional-agents-md.md](optional-agents-md.md).

Reload your IDE window after cleanup.
