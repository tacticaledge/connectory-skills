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

## 2. Connect (OAuth)

```bash
codex mcp login connectory
```

Complete **GitHub** sign-in in the browser (same account as [app.connectory.ai](https://app.connectory.ai)).

## 3. Verify

```bash
codex mcp list
```

`connectory` should be logged in. Ask Codex to call MCP tool **`whoami`**.

## 4. Install skills (recommended)

```bash
npx skills add https://github.com/tacticaledge/connectory-skills -a codex --copy -y
```

See [README](../README.md).

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| MCP server not listed | Confirm `[features]` block comes before `[mcp_servers.connectory]` |
| `codex mcp login` fails | Use the GitHub account tied to your Connectory org |
| `whoami` shows no `orgs` | Confirm membership at [app.connectory.ai](https://app.connectory.ai) |
| Slash commands missing | `npx skills update -a codex` then restart |
