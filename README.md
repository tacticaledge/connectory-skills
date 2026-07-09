# Connectory

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Agent Skills](https://img.shields.io/badge/Agent%20Skills-compatible-green.svg)](https://agentskills.io)
[![MCP](https://img.shields.io/badge/MCP-Streamable%20HTTP-purple.svg)](https://modelcontextprotocol.io)

## Your agent codes for the prompt. Connectory makes it code for your organization.

AI coding agents are good at the task you give them: fix this file, implement this ticket,
ship this patch. They do not automatically know your company's goals, compliance rules, or
why certain patterns exist. That knowledge usually lives in people's heads, Slack threads, and
old decisions nobody wrote down.

**Connectory collects that knowledge** (goals, policies, who owns what, what each repo is for)
and makes it available to your agent while you code.

**This repo is the setup guide.** Connect your IDE, sign in, install slash commands like
`/check-plan`, and your agent can ask "does this fit our org?" before you build the wrong thing.

## Get started (2 minutes)

[![Add to Cursor](https://cursor.com/deeplink/mcp-install-light.svg)](https://cursor.com/en/install-mcp?name=connectory&config=eyJ1cmwiOiJodHRwczovL2FwaS5jb25uZWN0b3J5LmFpL21jcCJ9)
[![Sign in to Connectory](https://img.shields.io/badge/Sign_in-app.connectory.ai-2563eb?style=for-the-badge)](https://app.connectory.ai)

| Step | What you do |
|------|-------------|
| **1** | Click **Add to Cursor** (or [VS Code install](https://insiders.vscode.dev/redirect/mcp/install?name=connectory&config=%7B%22type%22%3A%22http%22%2C%22url%22%3A%22https%3A%2F%2Fapi.connectory.ai%2Fmcp%22%7D), or [other IDE guide](#other-ides)) |
| **2** | In your IDE: open MCP settings → **connectory** → **Connect** → sign in with **GitHub** |
| **3** | Install slash commands: `npx skills add https://github.com/tacticaledge/connectory-skills -a cursor --copy -y` |
| **4** | Try `/check-plan` in Agent chat, or ask: *"Call Connectory whoami"* |

Not on Connectory yet? [Create an account](https://app.connectory.ai) first, then run the steps above.

Other IDE? See [install guides](#other-ides). Server URL for manual config: `https://api.connectory.ai/mcp`

---

## What you get from this repo

This repository is **IDE setup only**: connect MCP, install slash commands, and run org-aware
checks while you code.

| What | How |
|------|-----|
| **Policy checks in your IDE** | MCP tools `check_idea`, `check_plan`, `check_code`, `check_changes` |
| **Slash commands** | `/check-plan`, `/check-code`, etc. (after `npx skills add`) |
| **Org context** | Goals, policies, and repo knowledge from [app.connectory.ai](https://app.connectory.ai) |

Sign in with GitHub. Your org is picked automatically once connected.

---

## Why checks improve over time

Connectory remembers your organization's goals, policies, and past decisions. The more your
team adds and confirms knowledge in the dashboard, the more useful `check_*` results become.
Each check uses that context; it is not a one-off generic LLM opinion.

---

## Install details

### Cursor (manual fallback)

**Recommended:** install once in **`~/.cursor/mcp.json`** (works in every project; OAuth once).
Same pattern as Linear or Sentry. Do not duplicate the same URL in a project
`.cursor/mcp.json`.

```json
{
  "mcpServers": {
    "connectory": {
      "url": "https://api.connectory.ai/mcp"
    }
  }
}
```

Reload Cursor, then **Settings → Tools & MCP → connectory → Connect** (GitHub).
Full guide: [docs/install-cursor.md](docs/install-cursor.md)

### Other IDEs

| IDE | Guide |
|-----|-------|
| **Cursor** | [docs/install-cursor.md](docs/install-cursor.md) |
| **VS Code** | [docs/install-vscode.md](docs/install-vscode.md) |
| **Claude Code** | [docs/install-claude-code.md](docs/install-claude-code.md) |
| **Codex** | [docs/install-codex.md](docs/install-codex.md) |
| **Windsurf** | [docs/install-windsurf.md](docs/install-windsurf.md) |

Copy-paste configs: [examples/](examples/). Manage org knowledge at [app.connectory.ai](https://app.connectory.ai).

### Install skills

Skills add slash commands so you can type `/check-plan` instead of explaining the whole
workflow every time.

```bash
npx skills add https://github.com/tacticaledge/connectory-skills -a cursor --copy -y
```

| Agent | Flag |
|-------|------|
| Cursor | `-a cursor` |
| Claude Code | `-a claude-code` |
| Codex | `-a codex` |
| VS Code | `-a vscode` |
| Windsurf | `-a windsurf` (or copy skills manually; see [install-windsurf.md](docs/install-windsurf.md)) |

Reload your IDE window if `/check-plan` does not appear in the slash menu.

```bash
npx skills update    # refresh later
```

### Step 3: Verify

In Agent chat, ask your agent to call the Connectory MCP tool **`whoami`**.

You should see your GitHub username and which **organizations** you belong to. Your agent
needs that org name for every check.

**Try a first check:**

```
/check-plan

I'm about to add caching to our API layer. Here's my plan: ...
```

If tools are missing, redo [Get started](#get-started-2-minutes). If slash commands are
missing, redo [Install skills](#install-skills).

### Step 4: Use

| Slash / skill | MCP tool | When |
|---------------|----------|------|
| `/check-idea` | `check_idea` | New direction or approach |
| `/check-plan` | `check_plan` | Before implementing a plan |
| `/check-code` | `check_code` | Single file or snippet |
| `/check-changes` | `prepare_review_diff` → `check_changes` | Multi-file branch review |
| `auto-check` | background `check_*` | Optional async check after edits (Cursor) |
| `connectory-setup` | (guide) | Walk through full install |

**Verdicts:** `aligned` (go), `caution` (read guidance), `misaligned` (stop),
`insufficient_context` (add knowledge in Connectory dashboard).

Optional: add a short section to your repo's `AGENTS.md` so all agents see the workflow.
[docs/optional-agents-md.md](docs/optional-agents-md.md)

---

## MCP tools (after connect)

| Tool | Purpose |
|------|---------|
| `whoami` | Identity + org memberships (call once per session) |
| `check_idea` | Vet an idea or direction |
| `check_plan` | Vet a multi-step plan |
| `check_code` | Vet code / single file |
| `prepare_review_diff` | Start branch review (returns git argv) |
| `check_changes` | Finish branch review (pass full unified diff) |

---

## Security and privacy

- **Sign in with GitHub.** No API keys or tokens go in your repo or config files.
- **Checks are read-only.** They look up your org's knowledge; they do not change your code.
- **One server, many orgs.** The same URL works for everyone; you only see orgs you belong to.
- **Manage access** at [app.connectory.ai](https://app.connectory.ai).

Details: [docs/security.md](docs/security.md)

---

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| MCP tools not appearing | Reload IDE window; confirm **connectory** is connected in MCP settings |
| Connected then **Error** / 0 tools | MCP settings → **Disconnect** → **Connect**; reload window. Do not change URL after OAuth. |
| Duplicate or flaky MCP | Use **one** install: `~/.cursor/mcp.json` **or** project `.cursor/mcp.json`, not both with the same URL |
| OAuth loop or 401 | Disconnect → Connect; use the GitHub account tied to your Connectory org |
| `whoami` shows no `orgs` | Join or confirm org membership at [app.connectory.ai](https://app.connectory.ai) |
| Slash commands missing | `npx skills update -a <agent>` then reload IDE |
| Branch review incomplete | Run `prepare_review_diff` → local git → `check_changes` with full unified diff |

Per-IDE guides include more detail: [docs/install-cursor.md](docs/install-cursor.md),
[docs/install-vscode.md](docs/install-vscode.md), and siblings.

---

## Demo

<!-- TODO: add assets/demo.gif showing MCP connect + /check-plan in action -->
Screenshots and a short demo GIF will live in `assets/` soon.

---

## Uninstall

[docs/uninstall.md](docs/uninstall.md)

---

## Repository layout

```
connectory-skills/
├── README.md                 ← start here
├── LICENSE
├── .agents-plugin/           ← marketplace manifest
├── docs/                     ← per-IDE MCP guides, security, uninstall
├── examples/                 ← copy-paste MCP config
├── assets/                   ← demo media (coming soon)
└── skills/
    ├── connectory-setup/     ← install wizard skill
    └── connectory/           ← check-*, auto-check
```

Compatible with [Agent Skills](https://agentskills.io) and [`npx skills`](https://github.com/vercel-labs/skills).
