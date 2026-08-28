# Install Connectory MCP in Windsurf

## 1. Add MCP config

Edit `~/.codeium/windsurf/mcp_config.json` (or your Windsurf MCP config). Merge:

```json
{
  "mcpServers": {
    "connectory": {
      "type": "http",
      "url": "https://api.connectory.ai/mcp"
    }
  }
}
```

Example file: [examples/mcp.json](../examples/mcp.json)

## 2. Connect (OAuth)

1. Open **Cascade** → **MCP** (hammer icon) → **Configure**.
2. Ensure **connectory** is listed → **Refresh**.
3. Authenticate with **GitHub** (same account as [app.connectory.ai](https://app.connectory.ai)).

## 3. Verify

Ask the agent to call **`whoami`** via Connectory MCP.

## 4. Install skills (recommended)

```bash
npx skills add https://github.com/tacticaledge/connectory-skills -a windsurf --copy -y
```

If `windsurf` is not a supported agent flag, install for `cursor` and copy skills into
`.windsurf/skills/` per Windsurf docs.

See [README](../README.md).

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| **connectory** not in MCP list | Confirm JSON syntax in `mcp_config.json`; refresh MCP |
| Authentication fails | Use the GitHub account tied to your Connectory org |
| A RepoQuest assessment exceeds the client deadline | Read `get_repoquest_check` first; use the persisted result if `last_run_at` advanced, otherwise ask before retrying |
| `whoami` shows no `orgs` | Confirm membership at [app.connectory.ai](https://app.connectory.ai) |
| Slash commands missing | Install skills manually or via `npx skills -a cursor --copy` |
