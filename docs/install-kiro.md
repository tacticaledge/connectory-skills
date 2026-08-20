# Install Connectory MCP in Kiro

## 1. Add MCP config

For this project, create or edit `.kiro/settings/mcp.json`:

```json
{
  "mcpServers": {
    "connectory": {
      "url": "https://api.connectory.ai/mcp"
    }
  }
}
```

For a user-wide install, merge the same `connectory` entry into
`~/.kiro/settings/mcp.json` instead. Kiro merges user and project configurations; a
project server with the same name overrides the user server.

Example file: [examples/kiro-mcp.json](../examples/kiro-mcp.json)

If your organization gives you a different Connectory endpoint, use that URL instead of
`https://api.connectory.ai/mcp`. Keep one effective `connectory` definition per scope and
never put OAuth tokens or client secrets in the file.

## 2. Connect with GitHub

Save `mcp.json`. Kiro reloads changed MCP servers and should open the browser OAuth flow when
Connectory starts. Complete GitHub sign-in with the account associated with your Connectory
organization.

If authentication does not start, open Kiro's **MCP Server** view, select `connectory`, and
connect or re-authenticate it. Use **Output → Kiro - MCP Logs** for connection errors.

## 3. Verify

In Kiro chat, ask the agent to call the Connectory MCP tool **`whoami`**. The response should
include your GitHub username and at least one organization slug.

## 4. Install skills

From the project root:

```bash
npx skills add https://github.com/tacticaledge/connectory-skills -a kiro-cli --copy -y
```

This installs the skills into `.kiro/skills/`, which Kiro IDE and Kiro CLI both discover.
Start a new chat if the slash commands do not appear immediately, then try `/check-plan`.

For a user-wide skills install, add `--global`.

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| `connectory` is missing | Confirm the file is `.kiro/settings/mcp.json`, then save it and check the MCP Server view |
| OAuth loop or expired session | Use **Re-authenticate** in the MCP Server view and complete GitHub sign-in |
| `whoami` shows no `orgs` | Confirm membership in the Connectory dashboard for the endpoint you configured |
| Slash commands missing | Re-run the skills command, confirm `.kiro/skills/` exists, and start a new chat |
| Custom agent cannot see skills | Add `skill://.kiro/skills/*/SKILL.md` to that custom agent's `resources` |
