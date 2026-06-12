---
name: auto-check
description: >-
  After substantive work (edits, plans, ideas), optionally spawn a background sub-agent
  to run check_plan, check_code, or check_idea via Connectory MCP without blocking.
  Use on file edits, completed implementation turns, or async policy validation.
---

# Connectory auto-check (async)

Optional. Run policy checks without blocking the main conversation.

## When to trigger

After a turn where you edited source files, wrote a multi-step plan, or proposed a new
direction. Skip trivial edits, when the user opted out, when a `/check-*` already ran
this turn, or when Connectory MCP is not connected.

## How (background sub-agent, Cursor)

1. Pick tool: `check_code` (1–2 files), `check_plan` (multi-file or stated plan),
   `check_idea` (direction only). Use `/check-changes` explicitly for branch review.
2. Launch **Task** with `run_in_background: true`, `subagent_type: generalPurpose`.
3. Sub-agent: read `references/mcp-rules.md`, call `whoami`, call the chosen MCP tool with
   relevant context, return `verdict` and `user_guidance` summary.
4. Do not await the sub-agent. Finish the main response first.
5. On completion: surface `misaligned` or `caution` promptly; `aligned` may be one line.

## Hard rules

- Use Connectory MCP only (same IDE OAuth session).
- At most one auto-check per turn for the same scope.
