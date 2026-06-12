---
name: check-changes
description: >-
  Branch review against Connectory org policy via prepare_review_diff and check_changes.
  Use when the user says check changes, /check-changes, or for multi-file branch review.
disable-model-invocation: true
---

# Check changes (branch review)

Slash: **`/check-changes`**

1. Read [references/mcp-rules.md](references/mcp-rules.md) for MCP transport rules and branch checklist.
2. `whoami` once → `org_slug` from `whoami.orgs`; `repo` short name from git remote.
3. `prepare_review_diff(org_slug, repo)` → `diff_budget_bytes`, `git_argv`, `git_argv_full`.
4. Local git at repo root (exec argv list, not shell string).
5. `check_changes(org_slug, repo, diff=<full unified diff>, intent=...)`.
6. Reply from **`user_guidance`** only. Branch review is incomplete until step 5 returns.
