# Connectory MCP reference

Canonical source for MCP rules. After editing, run `./scripts/sync-mcp-reference.sh`
(copies into each skill's `references/mcp-rules.md` for `npx skills` installs).

Rules for all `check-*` skills and `auto-check`. Applies to **any organization** using Connectory.

## Purpose

Use the **connectory** MCP server in your IDE (OAuth). Consult org policy and repo context
before you implement. MCP tools only; local `git` is only for collecting diff text for
`check_changes`.

## Hard stops

- After `whoami` or any successful `check_*`, do not probe tokens, MCP config files, or
  connection "debug" commands in the shell.
- Do not bypass IDE MCP with scripts, direct HTTP calls, or application code.
- Do not write diffs to disk or build MCP payloads in the shell. Pass unified diff text in
  the `check_changes` `diff` argument.
- Do not pass placeholders (`PLACEHOLDER`, `...`, `see file`) to `check_changes`.
- Branch review is incomplete until `check_changes` returns for the same `org_slug` and
  `repo` as `prepare_review_diff`.
- Do not use `check_code` for a multi-file branch review without telling the user.
- On **`misaligned`**: stop implementing. On **`insufficient_context`**: use URLs from the
  tool; do not invent policy.

## Session bootstrap

1. Call **`whoami`** once. Use **`whoami.orgs[].slug`** as `org_slug`.
2. If the user belongs to several orgs, ask which org applies to this repo once.
3. For repo-specific work, call **`list_repositories(org_slug)`** and select the exact
   `owner` / `repo` returned by Connectory. A git remote helps identify the candidate; it
   does not establish authorization.

## Repository intelligence

Use Connectory as a read-before-write intelligence layer, not only as a final policy gate:

1. **`get_repository_context`** — organization, product, and repo context relevant to the
   task. Treat it as prior institutional knowledge; verify current-code claims locally.
2. **`get_repoquest`** — compact status, known stack/goals, findings count, and recommended
   next checks.
3. **`list_repoquest_checks`** / **`get_repoquest_check`** — read persisted observations
   relevant to the task before spending time rediscovering them.
4. Use **`check_idea`**, **`check_plan`**, **`check_code`**, or the branch-review flow at the
   decision point where organizational guidance can still change the work.

Do not run every RepoQuest check mechanically. Read existing results first, select only a
revealed and runnable check that can materially reduce uncertainty, and verify findings
against the current checkout.

### Running a RepoQuest check

`start_repoquest_check` performs external GitHub reads, billable analysis, and persists a
result. Start it only when the user explicitly requested or approved that analysis.

1. Call `start_repoquest_check(org_slug, owner, repo, check_id)` once.
2. Preserve the returned `run_id` immediately.
3. Poll `get_repoquest_run(org_slug, run_id)` after `poll_after_seconds` until
   `completed` or `failed`. Do useful local work between polls.
4. On `completed`, use the result as evidence to guide the task. On `failed`, report the
   failure; never present it as a passing assessment.

The start call returns quickly and execution continues independently of that MCP request.
Do not increase polling frequency or start duplicates. If the start response itself is lost,
retry it once: an active repo run is deduplicated and returns its `run_id`. The current
lightweight execution tier survives client disconnects but an API deploy may interrupt it;
`get_repoquest_run` reports that terminal failure instead of pretending the assessment passed.

## Long-running MCP calls

Some institutional checks legitimately take several minutes. Configure only settings the
selected host documents:

- **Codex:** `tool_timeout_sec = 600` (seconds) under `[mcp_servers.connectory]`; its omitted
  default is 60 seconds.
- **Kiro:** `"timeout": 600000` (milliseconds) on the `connectory` server.
- **Claude Code:** current versions allow long MCP tool calls by default. If the environment
  overrides `MCP_TOOL_TIMEOUT`, keep it at least `600000` ms; `MCP_TIMEOUT` is startup only.
- **Cursor, VS Code, Windsurf:** do not invent an undocumented timeout field. RepoQuest uses
  the fast start/poll workflow above so it does not depend on one long request.

An almost-exact timeout with working `whoami` is a client deadline, not evidence that OAuth,
org membership, Railway, or the Connectory API is down. Do not reconnect GitHub or OAuth to
fix that symptom; use the selected host's install guide.

## Context scope

| You pass | Connectory includes |
|----------|---------------------|
| `org_slug` only | Org-wide knowledge and open questions |
| `org_slug` + `repo` | Repo-scoped knowledge |
| `check_code` + `file_path` | Repo may be inferred from path |

## Branch review

```
whoami → prepare_review_diff → local git (argv from tool) → check_changes(diff=<string>)
```

- `diff` is a string argument on `check_changes`, not a file path.
- After `prepare_review_diff`, run the returned `git_argv` locally, then call
  `check_changes` with the full unified output (must contain `diff --git`).
- Respect `diff_budget_bytes` from `prepare_review_diff`.
- If inventory is empty but the working tree is dirty, diff against `scope.base_ref` from
  the tool response and say so explicitly.

## Verdicts

| Verdict | Behavior |
|---------|----------|
| `aligned` | Proceed; brief considerations if useful |
| `caution` | Explain `user_guidance`; explicit OK before risky work |
| `misaligned` | **Stop.** Do not implement. |
| `insufficient_context` | Use URLs from the tool; suggest adding org knowledge in Connectory. |
| `invalid_diff` | Pass real git output, not a summary. |
| `payload_too_large` | Narrow paths via `prepare_review_diff(paths=[...])` and resubmit. |

## Presenting to the user

- Speak from **`user_guidance`**, not raw JSON.
- Link dashboard or onboarding URLs from the tool response when set.
