# Install Connectory in Cursor

## Recommended: one global install (all projects)

Install Connectory **once** in your user config, the same way Linear, Sentry, and other
OAuth MCP servers work. OAuth once; every repo sees the same **connectory** server.

1. Create or edit **`~/.cursor/mcp.json`** (Linux/macOS: `/home/you/.cursor/mcp.json` or
   `~/.cursor/mcp.json`).

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
`"mcpServers"`. Do **not** duplicate the same URL in a project `.cursor/mcp.json`.

2. **Command Palette → Developer: Reload Window**
3. Continue at [Sign in with GitHub](#sign-in-with-github).

Copy-paste template: [examples/cursor-mcp.json](../examples/cursor-mcp.json) (same JSON;
use at `~/.cursor/mcp.json`).

---

## Option A: Add to Cursor (one click)

Click this button (works from GitHub; opens [cursor.com](https://cursor.com) then launches Cursor):

[![Add Connectory to Cursor](https://cursor.com/deeplink/mcp-install-light.svg)](https://cursor.com/en/install-mcp?name=connectory&config=eyJ1cmwiOiJodHRwczovL2FwaS5jb25uZWN0b3J5LmFpL21jcCJ9)

Or open this link directly:

https://cursor.com/en/install-mcp?name=connectory&config=eyJ1cmwiOiJodHRwczovL2FwaS5jb25uZWN0b3J5LmFpL21jcCJ9

1. Approve the install prompt in Cursor.
2. If **connectory** also appears in a project `.cursor/mcp.json`, remove the duplicate
   and keep a single install (prefer `~/.cursor/mcp.json`).
3. Reload the window, then continue at [Sign in with GitHub](#sign-in-with-github).

### What is that long `config=...` value?

Cursor's [MCP install link format](https://cursor.com/docs/mcp/install-links) packs your
server settings into the URL. For Connectory it is just this JSON, base64-encoded:

```json
{"url":"https://api.connectory.ai/mcp"}
```

That is the same object as the `"connectory"` entry in `mcp.json`. The button image
(`mcp-install-light.svg`) is only decoration; the real link must be an `https://cursor.com/...`
URL, not `cursor://...`, or GitHub cannot open it.

---

## Option B: Project-only install (advanced)

Use this only when **one repo** must point at a different MCP URL (e.g. a staging stack).
Most teams should use the [global install](#recommended-one-global-install-all-projects) instead.

At that **project root**, create or edit `.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "connectory": {
      "url": "https://api.connectory.ai/mcp"
    }
  }
}
```

Do not add the same URL to both `~/.cursor/mcp.json` and a project file. Pick one scope.

Reload Cursor: **Command Palette → Developer: Reload Window**

---

## Sign in with GitHub

1. Open **Cursor Settings** (Ctrl+Shift+J / Cmd+Shift+J).
2. Go to **Tools & MCP**.
3. Find **connectory** and click **Connect**.
4. Sign in with **GitHub** (same account as [app.connectory.ai](https://app.connectory.ai)).

Use **Connect**, not **Logout**, unless you intend to wipe OAuth and sign in again.

## Check it works

In Agent chat, ask: *"Call Connectory whoami."*

You should see your GitHub username and which organizations you belong to. In MCP settings,
**connectory** should show connected with tools listed (e.g. `whoami`, `check_plan`).

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
| **connectory** not in Settings | Add [global `~/.cursor/mcp.json`](#recommended-one-global-install-all-projects); check JSON syntax; reload window |
| Stuck on **Loading tools** (yellow dot, 0 tools) | Toggle **off** → remove the `connectory` block from `~/.cursor/mcp.json` → **Reload Window** → add the block back → reload again → toggle on → click **Connect** (OAuth). Toggle alone is not enough. |
| **Error** / `net::ERR_FAILED` in MCP output (global install) | Remove `connectory` from `~/.cursor/mcp.json`. Add it to **this project's** `.cursor/mcp.json` instead (same JSON), reload, **Connect**. Same pattern as a per-repo MCP entry. |
| Connected then **Error** / 0 tools | MCP settings → **Disconnect** → **Connect** again; reload window once. Do not change the URL after OAuth. |
| Two **connectory** entries or flaky OAuth | Remove project `.cursor/mcp.json` connectory block if you use global install (or vice versa). One URL, one scope. |
| Sign-in loop | Use the GitHub account tied to your Connectory org; Disconnect → Connect |
| A RepoQuest assessment exceeds the client deadline | Read `get_repoquest_check` to see whether the result completed; never retry automatically. Cursor does not document a portable per-server tool-timeout field. |
| No organizations in whoami | Confirm membership at [app.connectory.ai](https://app.connectory.ai) |
| `/check-plan` not in menu | `npx skills update -a cursor`, then reload |
