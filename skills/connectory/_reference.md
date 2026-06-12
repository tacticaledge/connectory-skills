# Connectory MCP reference

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
3. **`repo`**: short repository name from `git remote` when work is repo-specific.

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
