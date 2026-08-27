# Install Connectory MCP in OpenAI Codex

## 1. Add MCP config

Edit `.codex/config.toml` at your project root. `[features]` must appear **before**
`[mcp_servers.*]`:

```toml
[features]
experimental_use_rmcp_client = true

[mcp_servers.connectory]
url = "https://api.connectory.ai/mcp"
enabled = true
```

Or use the CLI:

```bash
codex mcp add connectory --url https://api.connectory.ai/mcp
```

Example file: [examples/codex-config.toml](../examples/codex-config.toml)

## 2. Rebind Codex to the configured server

This step is required when you added `connectory` or changed its URL from inside a running
Codex session. The MCP tool transport is initialized by the Codex host; editing
`config.toml` or running `codex mcp add` does not hot-swap an already-loaded tool.

- **Codex IDE extension:** gear menu → **MCP servers** → **Restart extension**.
- **ChatGPT desktop app:** Settings → **MCP servers** → **Restart**.
- **Codex CLI/TUI:** exit the current Codex process and launch it again.

You may resume the same conversation after the host reloads. Starting a new chat without
reloading the extension is not sufficient. Do not use `whoami` from the pre-reload session
to verify the new URL; it may still be calling the previous server.

If the URL was already correct and this setup made no MCP configuration change, skip this
step.

## 3. Connect (OAuth)

```bash
codex mcp login connectory
```

Complete **GitHub** sign-in in the browser (same account as [app.connectory.ai](https://app.connectory.ai)).

## 4. Verify

```bash
codex mcp get connectory
```

Confirm that `url` exactly matches the endpoint you intended to install. Then ask the
rebound Codex host to call MCP tool **`whoami`**. Only use that post-rebind response to
verify identity and organization memberships.

## 5. Install skills (recommended)

```bash
npx skills add https://github.com/tacticaledge/connectory-skills -a codex --copy -y
```

See [README](../README.md).

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| MCP server not listed | Confirm `[features]` block comes before `[mcp_servers.connectory]` |
| `codex mcp login` fails | Use the GitHub account tied to your Connectory org |
| `whoami` returns an unexpected identity or endpoint after a URL change | Restart the Codex extension host, run `codex mcp get connectory`, and call `whoami` again before diagnosing membership |
| Post-rebind `whoami` shows no `orgs` | Confirm membership at [app.connectory.ai](https://app.connectory.ai) |
| Slash commands missing | `npx skills update -a codex` then restart |
