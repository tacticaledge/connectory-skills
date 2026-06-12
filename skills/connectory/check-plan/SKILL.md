---
name: check-plan
description: >-
  Vet a multi-step plan against Connectory org policy via MCP check_plan.
  Use when the user says check plan, /check-plan, or before implementing.
disable-model-invocation: true
---

# Check plan

Slash: **`/check-plan`**

1. Read [../_reference.md](../_reference.md) for MCP transport rules.
2. `whoami` once → `org_slug` from `whoami.orgs`; `repo` from git remote when repo-specific.
3. Call MCP **`check_plan`** with the plan from the conversation (and `repo` when known).
4. Reply from **`user_guidance`** only. On **`misaligned`**, stop implementing.
