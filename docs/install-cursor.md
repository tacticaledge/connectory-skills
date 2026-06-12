# Install Connectory MCP in Cursor

## 0. One-click install (fastest)

[![Add Connectory MCP to Cursor](https://cursor.com/deeplink/mcp-install-light.svg)](cursor://anysphere.cursor-deeplink/mcp/install?name=connectory&config=eyJ1cmwiOiAiaHR0cHM6Ly9hcGkuY29ubmVjdG9yeS5haS9tY3AifQ%3D%3D)

Raw link:

```
cursor://anysphere.cursor-deeplink/mcp/install?name=connectory&config=eyJ1cmwiOiAiaHR0cHM6Ly9hcGkuY29ubmVjdG9yeS5haS9tY3AifQ%3D%3D
```

Click the link, approve the install prompt in Cursor, then continue at [Connect (OAuth)](#2-connect-oauth).

## 1. Add MCP config (manual)

At your **project root**, create or edit `.cursor/mcp.json`. Merge the `connectory` entry if
you already have other servers:

```json
{
  "mcpServers": {
    "connectory": {
      "url": "https://api.connectory.ai/mcp"
    }
  }
}
```

For **all projects**, use `~/.cursor/mcp.json` with the same structure.

Example file: [examples/cursor-mcp.json](../examples/cursor-mcp.json)

## 2. Connect (OAuth)

1. Open **Cursor Settings** (Ctrl+Shift+J / Cmd+Shift+J).
2. Go to **Tools & MCP**.
3. Find **connectory** and click **Connect**.
4. Sign in with **GitHub** (same account as your Connectory org at [app.connectory.ai](https://app.connectory.ai)).

## 3. Reload

Reload the window: **Command Palette → Developer: Reload Window**.

## 4. Verify

In Agent chat, ask: *"Call Connectory whoami."*

You should see your GitHub username and `orgs`. If not, confirm connectory is enabled and
connected in Settings.

## 5. Install skills (recommended)

Back to [README](../README.md#step-2-install-skills-recommended):

```bash
npx skills add https://github.com/tacticaledge/connectory-skills -a cursor --copy -y
```

Then try `/check-plan` in Agent chat.

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| Deeplink does nothing | Paste the raw `cursor://` link into your browser; confirm Cursor is installed |
| **connectory** not in Settings | Check `.cursor/mcp.json` syntax; reload window |
| Tools missing after connect | **Tools & MCP → connectory → Connect** again; reload |
| OAuth loop | Sign out and sign in with the GitHub account tied to your Connectory org |
| `whoami` shows no `orgs` | Confirm membership at [app.connectory.ai](https://app.connectory.ai) |
| `/check-plan` missing | `npx skills update -a cursor` then reload |
