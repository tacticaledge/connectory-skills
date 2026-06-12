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

**This repo is the setup guide.** It walks you through connecting Connectory to Cursor, VS Code,
Claude Code, and other tools, then installing slash commands like `/check-plan` and
`/check-code` so your agent can ask "does this fit our org?" before you build the wrong thing.

| | |
|---|---|
| **Sign in / manage your org** | [app.connectory.ai](https://app.connectory.ai) |
| **Connectory server URL** (for IDE config) | `https://api.connectory.ai/mcp` |
| **How to sign in** | GitHub, in your IDE after you add the server (see [Install](#install-in-2-minutes)) |

---

## What Connectory does

Connectory holds what your engineering org knows but rarely documents: what you are building,
what rules matter, who owns which repos, and what is still undecided. That context feeds
everything below.

| Product | What it does |
|---------|--------------|
| **IDE checks** (this repo) | Your agent can run `check_idea`, `check_plan`, `check_code`, and `check_changes` against your org's knowledge while you work |
| **SlopBuster** | PR review that learns your repo over time instead of starting from scratch every diff |
| **OrgWatch** | See how your whole team (humans and AI agents) is contributing |
| **API Bot** | Chat with an agent that can run real API calls for you |
| **SlackBot** | Get teaching and feedback in Slack when it matters |

Works for any team on Connectory (startup, lab, or big-company squad). Sign in with GitHub.
Your org is picked automatically once connected.

---

## Why it gets smarter over time

Most AI tools treat every request as a fresh start. Connectory remembers.

| Typical AI review | Connectory |
|-------------------|------------|
| Forgets your repo after each PR | Remembers quality history and patterns |
| Same generic advice for everyone | Advice specific to your org and repos |
| Only sees the current diff | Builds on every PR, check, and confirmation |

The more your team uses it, the better it knows how you work.

---

## Install in 2 minutes

### One-click (recommended)

**Cursor:** click to add the MCP server, then Connect in Settings and sign in with GitHub.

[![Add Connectory MCP to Cursor](https://cursor.com/deeplink/mcp-install-light.svg)](cursor://anysphere.cursor-deeplink/mcp/install?name=connectory&config=eyJ1cmwiOiAiaHR0cHM6Ly9hcGkuY29ubmVjdG9yeS5haS9tY3AifQ%3D%3D)

Raw link: `cursor://anysphere.cursor-deeplink/mcp/install?name=connectory&config=eyJ1cmwiOiAiaHR0cHM6Ly9hcGkuY29ubmVjdG9yeS5haS9tY3AifQ%3D%3D`

**VS Code:** [Install Connectory MCP in VS Code](https://insiders.vscode.dev/redirect/mcp/install?name=connectory&config=%7B%22name%22%3A+%22connectory%22%2C+%22url%22%3A+%22https%3A%2F%2Fapi.connectory.ai%2Fmcp%22%7D)

### Manual config (any IDE)

Add this server URL to your IDE's MCP settings (sign in with GitHub when prompted). Same URL
for every org:

```
https://api.connectory.ai/mcp
```

**Quick copy (Cursor / project root):** create or merge into `.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "connectory": {
      "url": "https://api.connectory.ai/mcp"
    }
  }
}
```

Then **Cursor Settings → Tools & MCP → connectory → Connect** and sign in with GitHub.

| IDE | Guide |
|-----|-------|
| **Cursor** | [docs/install-cursor.md](docs/install-cursor.md) |
| **Claude Code** | [docs/install-claude-code.md](docs/install-claude-code.md) |
| **Codex** | [docs/install-codex.md](docs/install-codex.md) |
| **VS Code** | [docs/install-vscode.md](docs/install-vscode.md) |
| **Windsurf** | [docs/install-windsurf.md](docs/install-windsurf.md) |

More copy-paste configs: [examples/](examples/).

### Sign in and manage your org

1. After adding the MCP server, **Connect** in your IDE and sign in with **GitHub**.
2. Manage your account and organizations at **[app.connectory.ai](https://app.connectory.ai)**.
3. View and edit org knowledge (Genie) at `https://app.connectory.ai/org/{org_slug}/genie`.

---

## 4-step setup

| Step | What | Time |
|------|------|------|
| [1. MCP](#install-in-2-minutes) | Connect Connectory in your IDE | ~2 min |
| [2. Skills](#step-2-install-skills-recommended) | Install slash commands | ~1 min |
| [3. Verify](#step-3-verify) | Confirm `whoami` works | ~30 sec |
| [4. Use](#step-4-use) | `/check-plan`, `/check-code`, … | ongoing |

### Step 2: Install skills (recommended)

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

If tools are missing, redo [MCP connect](#install-in-2-minutes). If slash commands are
missing, redo [Step 2](#step-2-install-skills-recommended).

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
| OAuth loop or 401 | Sign in again with the GitHub account tied to your Connectory org |
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
