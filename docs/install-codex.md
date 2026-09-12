# Install Connectory MCP in OpenAI Codex

## 1. Add MCP config

Edit `.codex/config.toml` at your project root:

```toml
[mcp_servers.connectory]
url = "https://api.connectory.ai/mcp"
enabled = true
# Connectory analysis may legitimately take several minutes. Codex defaults to
# 60 seconds when this is omitted.
tool_timeout_sec = 600
```

Or use the CLI:

```bash
codex mcp add connectory --url https://api.connectory.ai/mcp
```

Example file: [examples/codex-config.toml](../examples/codex-config.toml)

## 2. Rebind Codex to the configured server

This step is required when you added `connectory`, changed its URL, or corrected its timeout
from inside a running Codex session. The MCP tool transport is initialized by the Codex host; editing
`config.toml` or running `codex mcp add` does not hot-swap an already-loaded tool.

- **Codex IDE extension:** gear menu → **MCP servers** → **Restart extension**.
- **ChatGPT desktop app:** Settings → **MCP servers** → **Restart**.
- **Codex CLI/TUI:** exit the current Codex process and launch it again.

You may resume the same conversation after the host reloads. Starting a new chat without
reloading the extension is not sufficient. Do not use `whoami` from the pre-reload session
to verify the new URL; it may still be calling the previous server.

If the URL and timeout were already correct and this setup made no MCP configuration change,
skip this step. A first-time install completed before Codex connects does not need an extra
reload.

## 3. Connect (OAuth)

```bash
codex mcp login connectory
```

Complete **GitHub** sign-in in the browser (same account as [app.connectory.ai](https://app.connectory.ai)).

## 4. Verify

```bash
codex mcp get connectory
```

Confirm that `url` exactly matches the endpoint you intended to install and that the output
shows `tool_timeout_sec: 600`. Then ask the rebound Codex host to call MCP tool **`whoami`**.
Only use that post-rebind response to verify identity and organization memberships.

## 5. Install skills (recommended)

```bash
npx skills add https://github.com/tacticaledge/connectory-skills -a codex --copy -y
```

See [README](../README.md).

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| MCP server not listed | Run `codex mcp get connectory`; if missing, add the server again with `codex mcp add` |
| `codex mcp login` fails | Use the GitHub account tied to your Connectory org |
| A `check_*` tool fails at almost exactly 60 seconds | Set `tool_timeout_sec = 600` under `[mcp_servers.connectory]`. This is the Codex per-tool deadline, not the startup timeout. |
| `whoami` returns an unexpected identity or endpoint after a URL change | Restart the Codex extension host, run `codex mcp get connectory`, and call `whoami` again before diagnosing membership |
| Post-rebind `whoami` shows no `orgs` | Confirm membership at [app.connectory.ai](https://app.connectory.ai) |
| Slash commands missing | `npx skills update -a codex` then restart |
