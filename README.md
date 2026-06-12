# Connectory

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Agent Skills](https://img.shields.io/badge/Agent%20Skills-compatible-green.svg)](https://agentskills.io)
[![MCP](https://img.shields.io/badge/MCP-Streamable%20HTTP-purple.svg)](https://modelcontextprotocol.io)

**Connectory is the institutional memory of your engineering organization.**

Capture knowledge that is usually never written down: objectives, policies, ownership, repo
intelligence, and open questions. Connectory builds that graph by interacting with
decision-makers and coders, then wires it into every judgment your team makes.

**This repo is your bridge:** install the MCP server into your IDE, add Agent Skills, and
start consulting org knowledge while you code.

| | |
|---|---|
| **Product home** | [app.connectory.ai](https://app.connectory.ai) |
| **MCP endpoint** | `https://api.connectory.ai/mcp` |
| **Sign in** | GitHub OAuth (in your IDE after connecting MCP) |

---

## What Connectory does

Connectory is a multi-tenant AI platform for engineering organizations. It captures
**organizational judgment** that static analysis and generic LLM reviewers cannot: what your
company is trying to do, who owns what, which patterns are intentional, and what is still
uncertain.

That memory powers everything below:

| Product | What it does |
|---------|--------------|
| **Institutional knowledge MCP** | `check_idea`, `check_plan`, `check_code`, `check_changes` consult org policy and repo context while you work in your IDE |
| **SlopBuster** | Gamified PR review that learns your repo's quality history and gets smarter every month |
| **OrgWatch** | Contributor intelligence across humans and AI agents; leadership dashboards and the Genie knowledge graph |
| **API Bot** | Conversational agent that executes real API calls with secure credentials |
| **SlackBot** | Teaching DMs and praise at the moment of consequence |

Works with **any organization** on Connectory: a lab, a startup, or a team inside a
multinational. Sign in with GitHub; your org is resolved at runtime via `whoami`.

---

## Why it compounds

Other tools start from zero on every diff. Connectory compounds.

| Other review tools | Connectory |
|--------------------|------------|
| Every review starts from zero | Memory persists across every PR and check |
| Generic patterns for all repos | Learned patterns specific to your org and repos |
| Reads the diff, forgets everything | Builds quality history over time |
| Stateless | Compounding |

Every PR, check, and confirmation makes the next judgment smarter.

---

## Install in 2 minutes

### One-click (recommended)

**Cursor:** click to add the MCP server, then Connect in Settings and sign in with GitHub.

[![Add Connectory MCP to Cursor](https://cursor.com/deeplink/mcp-install-light.svg)](cursor://anysphere.cursor-deeplink/mcp/install?name=connectory&config=eyJ1cmwiOiAiaHR0cHM6Ly9hcGkuY29ubmVjdG9yeS5haS9tY3AifQ%3D%3D)

Raw link: `cursor://anysphere.cursor-deeplink/mcp/install?name=connectory&config=eyJ1cmwiOiAiaHR0cHM6Ly9hcGkuY29ubmVjdG9yeS5haS9tY3AifQ%3D%3D`

**VS Code:** [Install Connectory MCP in VS Code](https://insiders.vscode.dev/redirect/mcp/install?name=connectory&config=%7B%22name%22%3A+%22connectory%22%2C+%22url%22%3A+%22https%3A%2F%2Fapi.connectory.ai%2Fmcp%22%7D)

### Manual config (any IDE)

Connectory is a **hosted HTTP MCP server** (OAuth via GitHub). Same URL for every org:

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
| [1. MCP](#install-in-2-minutes) | Wire Connectory into your IDE | ~2 min |
| [2. Skills](#step-2-install-skills-recommended) | Install slash commands | ~1 min |
| [3. Verify](#step-3-verify) | Confirm `whoami` works | ~30 sec |
| [4. Use](#step-4-use) | `/check-plan`, `/check-code`, … | ongoing |

### Step 2: Install skills (recommended)

Skills teach your agent when and how to call Connectory (slash commands, branch review flow,
verdicts).

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

You should see your GitHub identity and **`orgs`** (organizations you belong to). Use
`orgs[].slug` as `org_slug` on every `check_*` call.

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

- **OAuth 2.1 via GitHub.** No tokens in your repo or MCP config files.
- **Read-only consultation.** `check_*` tools consult org context; they do not mutate your codebase.
- **Multi-tenant.** One hosted URL; your org is resolved at runtime via `whoami`.
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
