---
name: check-code
description: >-
  Vet a code snippet or single file against Connectory org policy via MCP check_code.
  Use when the user says check code, /check-code, or after editing one file.
disable-model-invocation: true
---

# Check code

Slash: **`/check-code`**

1. Read [../_reference.md](../_reference.md) for MCP transport rules.
2. `whoami` once → `org_slug` from `whoami.orgs`; `repo` from git remote when repo-specific.
3. Call MCP **`check_code`** with the relevant code, `file_path`, and optional `intent`.
4. Reply from **`user_guidance`** only. On **`misaligned`**, stop implementing.
