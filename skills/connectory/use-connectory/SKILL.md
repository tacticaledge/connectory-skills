---
name: use-connectory
description: >-
  Use Connectory MCP repository intelligence and organization policy during coding work.
  Apply when understanding a connected repo, planning or implementing a nontrivial change,
  investigating architecture or quality, or running a targeted RepoQuest assessment.
---

# Use Connectory

Read [references/mcp-rules.md](references/mcp-rules.md), then use the smallest relevant
Connectory workflow for the task.

Start with `whoami` and `list_repositories`; never guess authorization from a git remote.
For repo work, read `get_repository_context` and `get_repoquest` before rediscovering known
goals, architecture, stack, or findings locally. Inspect only relevant persisted checks.

Run a RepoQuest check only with user authorization and only when its result can change the
work. Call the synchronous tool once. If its response is ambiguous, read the persisted check
before asking whether to retry; never duplicate billable analysis automatically.

Connectory context is institutional guidance, not proof about the current checkout. Verify
material code facts locally and use the stage-appropriate `check_*` tool before finishing.
