# Install Connectory MCP in Claude Code

## 1. Add MCP config

At your **project root**, create or edit `.mcp.json`:

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

Or use the CLI (project scope):

```bash
claude mcp add --transport http --scope project connectory \
  https://api.connectory.ai/mcp
```

Example file: [examples/mcp.json](../examples/mcp.json)

## 2. Connect (OAuth)

1. In Claude Code, run **`/mcp`**.
2. Select **connectory** → **Authenticate**.
3. Complete **GitHub** sign-in in the browser (same account as [app.connectory.ai](https://app.connectory.ai)).

## 3. Verify

```bash
claude mcp list
```

`connectory` should show as connected. In chat, ask the agent to call **`whoami`**.

## 4. Install skills (recommended)

```bash
npx skills add https://github.com/tacticaledge/connectory-skills -a claude-code --copy -y
```

See [README](../README.md).

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| `connectory` not in `/mcp` list | Confirm `.mcp.json` at project root; restart Claude Code |
| Authentication loop | Sign in with the GitHub account tied to your Connectory org |
| `whoami` shows no `orgs` | Confirm membership at [app.connectory.ai](https://app.connectory.ai) |
| Slash commands missing | `npx skills update -a claude-code` then restart |
