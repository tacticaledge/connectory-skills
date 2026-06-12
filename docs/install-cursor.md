# Install Connectory in Cursor

Takes about 2 minutes. **Use the steps below.** The "Add to Cursor" button on GitHub often
does nothing (GitHub cannot open the Cursor app). Copy-paste always works.

## 1. Add the server config

At your **project root**, create or edit `.cursor/mcp.json`.

If the file is new, paste this whole thing:

```json
{
  "mcpServers": {
    "connectory": {
      "url": "https://api.connectory.ai/mcp"
    }
  }
}
```

If you already have other MCP servers, add only the `"connectory"` block inside
`"mcpServers"`.

**All projects:** use `~/.cursor/mcp.json` instead (same JSON).

Copy from [examples/cursor-mcp.json](../examples/cursor-mcp.json) if you prefer.

## 2. Reload Cursor

**Command Palette → Developer: Reload Window**

## 3. Sign in with GitHub

1. Open **Cursor Settings** (Ctrl+Shift+J / Cmd+Shift+J).
2. Go to **Tools & MCP**.
3. Find **connectory** and click **Connect**.
4. Sign in with **GitHub** (same account you use at [app.connectory.ai](https://app.connectory.ai)).

## 4. Check it works

In Agent chat, ask: *"Call Connectory whoami."*

You should see your GitHub username and which organizations you belong to.

## 5. Install slash commands (recommended)

```bash
npx skills add https://github.com/tacticaledge/connectory-skills -a cursor --copy -y
```

Reload Cursor, then try `/check-plan` in Agent chat.

Full guide: [README](../README.md)

## Troubleshooting

| Problem | Fix |
|---------|-----|
| **connectory** not in Settings | Check `.cursor/mcp.json` for typos; reload window |
| Connect button missing or greyed out | Confirm the JSON file is saved; reload again |
| Sign-in loop | Use the GitHub account tied to your Connectory org |
| No organizations in whoami | Join or confirm membership at [app.connectory.ai](https://app.connectory.ai) |
| `/check-plan` not in menu | Run `npx skills update -a cursor`, then reload |
