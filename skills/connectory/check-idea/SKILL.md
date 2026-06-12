---
name: check-idea
description: >-
  Vet an idea or direction against Connectory org policy via MCP check_idea.
  Use when the user says check idea, /check-idea, or is choosing a new approach.
disable-model-invocation: true
---

# Check idea

Slash: **`/check-idea`**

1. Read [references/mcp-rules.md](references/mcp-rules.md) for MCP transport rules.
2. `whoami` once → `org_slug` from `whoami.orgs`; `repo` from git remote when repo-specific.
3. Call MCP **`check_idea`** with the idea from the conversation (and `repo` when known).
4. Reply from **`user_guidance`** only. On **`misaligned`**, stop implementing.
