# Install Connectory in Cursor

## Option A: Add to Cursor (one click)

Click this button (works from GitHub; opens [cursor.com](https://cursor.com) then launches Cursor):

[![Add Connectory to Cursor](https://cursor.com/deeplink/mcp-install-light.svg)](https://cursor.com/en/install-mcp?name=connectory&config=eyJ1cmwiOiJodHRwczovL2FwaS5jb25uZWN0b3J5LmFpL21jcCJ9)

Or open this link directly:

https://cursor.com/en/install-mcp?name=connectory&config=eyJ1cmwiOiJodHRwczovL2FwaS5jb25uZWN0b3J5LmFpL21jcCJ9

1. Approve the install prompt in Cursor.
2. Continue below at [Sign in with GitHub](#sign-in-with-github).

### What is that long `config=...` value?

Cursor's [MCP install link format](https://cursor.com/docs/mcp/install-links) packs your
server settings into the URL. For Connectory it is just this JSON, base64-encoded:

```json
{"url":"https://api.connectory.ai/mcp"}
```

That is the same object as the `"connectory"` entry in `.cursor/mcp.json`. The button image
(`mcp-install-light.svg`) is only decoration; the real link must be an `https://cursor.com/...`
URL, not `cursor://...`, or GitHub cannot open it.

---

## Option B: Copy-paste (if the button fails)

At your **project root**, create or edit `.cursor/mcp.json`:

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

Example file: [examples/cursor-mcp.json](../examples/cursor-mcp.json)

Reload Cursor: **Command Palette → Developer: Reload Window**

---

## Sign in with GitHub

1. Open **Cursor Settings** (Ctrl+Shift+J / Cmd+Shift+J).
2. Go to **Tools & MCP**.
3. Find **connectory** and click **Connect**.
4. Sign in with **GitHub** (same account as [app.connectory.ai](https://app.connectory.ai)).

## Check it works

In Agent chat, ask: *"Call Connectory whoami."*

You should see your GitHub username and which organizations you belong to.

## Install slash commands (recommended)

```bash
npx skills add https://github.com/tacticaledge/connectory-skills -a cursor --copy -y
```

Reload Cursor, then try `/check-plan` in Agent chat.

## Troubleshooting

| Problem | Fix |
|---------|-----|
| Button does nothing | Use the `https://cursor.com/en/install-mcp?...` link above, not a `cursor://` link |
| Cursor does not open | Install/update Cursor; paste the https link into your browser address bar |
| **connectory** not in Settings | Use Option B; check JSON syntax; reload window |
| Sign-in loop | Use the GitHub account tied to your Connectory org |
| No organizations in whoami | Confirm membership at [app.connectory.ai](https://app.connectory.ai) |
| `/check-plan` not in menu | `npx skills update -a cursor`, then reload |
