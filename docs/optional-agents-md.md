# Optional: AGENTS.md snippet

Paste this section into your repository's `AGENTS.md` so every agent session knows how to
use Connectory. Adjust nothing except optional repo name context.

```markdown
## Connectory

MCP server **connectory** → `https://api.connectory.ai/mcp` (OAuth via GitHub).

Before `check_*`: call **`whoami`** once. Use `org_slug` from **`whoami.orgs`**. Pass **`repo`** (short name) when work targets one codebase.

| When | Tool |
|------|------|
| Choosing an approach | `check_idea` |
| Before multi-step implementation | `check_plan` |
| Single file or snippet | `check_code` |
| Branch review (multi-file) | `prepare_review_diff` → local git → `check_changes` |

**Slash commands:** `/check-idea`, `/check-plan`, `/check-code`, `/check-changes`

Install skills: `npx skills add https://github.com/tacticaledge/connectory-skills -a cursor --copy -y`

Reply from **`user_guidance`**, not raw JSON. **`misaligned`** → stop.
```

Setup guide: [github.com/tacticaledge/connectory-skills](https://github.com/tacticaledge/connectory-skills)
