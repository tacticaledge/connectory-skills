# Install Connectory MCP in VS Code

## 0. One-click install (fastest)

[Install Connectory MCP in VS Code](https://insiders.vscode.dev/redirect/mcp/install?name=connectory&config=%7B%22name%22%3A+%22connectory%22%2C+%22url%22%3A+%22https%3A%2F%2Fapi.connectory.ai%2Fmcp%22%7D)

Click the link, approve the install prompt, then continue at [Connect (OAuth)](#2-connect-oauth).

## 1. Add MCP config (manual)

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

## 2. Connect (OAuth)

1. **Command Palette** → **MCP: List Servers**.
2. Select **connectory** → **Authenticate**.
3. Sign in with **GitHub** (same account as [app.connectory.ai](https://app.connectory.ai)).

Reload the window if tools do not appear.

## 3. Verify

Ask your agent to call Connectory MCP tool **`whoami`**.

## 4. Install skills (recommended)

```bash
npx skills add https://github.com/tacticaledge/connectory-skills -a vscode --copy -y
```

See [README](../README.md).

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| One-click link fails | Add config manually from [examples/vscode-mcp.json](../examples/vscode-mcp.json) |
| **connectory** not listed | Confirm `.vscode/mcp.json` uses `"servers"` key; reload window |
| Authentication fails | Use the GitHub account tied to your Connectory org |
| `whoami` shows no `orgs` | Confirm membership at [app.connectory.ai](https://app.connectory.ai) |
| Slash commands missing | `npx skills update -a vscode` then reload |
