# Security and privacy

Connectory MCP is designed so your IDE connects to a hosted service without storing secrets
in your repository.

## Authentication

- **OAuth 2.1** with **GitHub** sign-in in your browser.
- Your IDE stores the session token locally after you approve the connection.
- MCP config files contain only the server URL (`https://api.connectory.ai/mcp`). No API keys,
  passwords, or personal access tokens belong in config or in this repo.

## What the MCP server can do

| Tool class | Behavior |
|------------|----------|
| `whoami` | Returns your identity and org memberships for this session |
| `check_*` | **Read-only consultation** against org institutional knowledge and repo context |
| `prepare_review_diff` | Returns git argv for you to run locally; no server-side git access to your machine |

The `check_*` path does not write to your codebase. Adding or editing org knowledge happens
in the Connectory dashboard at [app.connectory.ai](https://app.connectory.ai).

## Multi-tenant architecture

- One hosted MCP URL serves all organizations on Connectory.
- Your org is resolved at runtime when you call `whoami` and pass `org_slug` on `check_*`.
- You only see orgs your GitHub identity is a member of.

## Data flow

```
Your IDE  →  OAuth (GitHub)  →  Connectory API (api.connectory.ai/mcp)
                                      ↓
                              Org knowledge graph (scoped by org_slug)
```

Connectory assembles context from three layers before any LLM judgment:

1. **Institution** (org-wide objectives, policies, open questions)
2. **Product** (project context from your Genie dashboard)
3. **Repo** (quality profile and repo-specific notes)

## Managing access

- Sign in and manage organizations at **[app.connectory.ai](https://app.connectory.ai)**.
- Use the same GitHub account in your IDE OAuth flow and in Connectory.
- To disconnect: remove the `connectory` entry from your MCP config and disable the server in
  IDE settings. See [uninstall.md](uninstall.md).

## Reporting issues

If you believe you have found a security issue, contact your Connectory administrator or
reach out through [app.connectory.ai](https://app.connectory.ai).
