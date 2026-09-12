# Install Connectory in VS Code

## 1. Add the server config

At your **project root**, create or edit `.vscode/mcp.json`:

```json
{
  "servers": {
    "connectory": {
      "type": "http",
      "url": "https://api.connectory.ai/mcp"
    }
  }
}
```

Note: VS Code uses `"servers"`, not `"mcpServers"`.

Example file: [examples/vscode-mcp.json](../examples/vscode-mcp.json)

## 2. Reload VS Code

Reload the window if the server does not appear.

## 3. Sign in with GitHub

1. **Command Palette** → **MCP: List Servers**.
2. Select **connectory** → **Authenticate**.
3. Sign in with **GitHub** (same account as [app.connectory.ai](https://app.connectory.ai)).

## 4. Check it works

Ask your agent to call Connectory tool **`whoami`**.

## 5. Install slash commands (recommended)

```bash
npx skills add https://github.com/tacticaledge/connectory-skills -a github-copilot --copy -y
```

See [README](../README.md).

## Troubleshooting

| Problem | Fix |
|---------|-----|
| **connectory** not listed | Confirm `.vscode/mcp.json` uses `"servers"` key; reload |
| Authentication fails | Use the GitHub account tied to your Connectory org |
| No organizations in whoami | Confirm membership at [app.connectory.ai](https://app.connectory.ai) |
| A RepoQuest assessment exceeds the client deadline | Read `get_repoquest_check` first; use the persisted result if `last_run_at` advanced, otherwise ask before retrying |
| Slash commands missing | `npx skills update -a github-copilot` then reload |
