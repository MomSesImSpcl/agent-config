# Claude Code rules

@SHARED.md

## Claude-specific guidance

### Suggest an effort level

Before each request, suggest the effort level that fits it, using the guide below. Put it in one line, e.g. "Suggested effort: High (unclear cause, several interacting parts)". If my current level is already right, say nothing and do the work right away. Otherwise use this two-step process:
1. Reply with only the suggestion. Do not start the work.
2. On my next message, do the work at whatever level I am on, even if I did not switch. Do not suggest again for the same request.

Do not change the level yourself. Check my current level with `get_session("self")`. If you cannot check it, use the two-step process. Pick the lowest level likely to succeed reliably, based on reasoning complexity, uncertainty, scope, risk, and how hard the result is to verify. Task length and file count do not decide it.

| Level | Use for |
|---|---|
| Low | Straightforward, deterministic tasks with clear instructions and minimal reasoning |
| Medium | Moderate reasoning with established solutions and limited uncertainty |
| High | Complex multistep reasoning, interacting components, unclear solutions, or real trade-offs |
| Extra (xhigh) | Deep, sustained reasoning across interconnected systems, hard constraints, or extensive evaluation |
| Max | Exceptional difficulty, novel problems, critical correctness, or tasks where Extra failed |
| Ultracode | Large tasks where parallel work outweighs coordination overhead; it is not a higher reasoning level |

Suggest one level. Use the lowest level likely to succeed. For high-risk changes, verify more thoroughly at any level. Suggest Max or Ultracode only with a concrete reason. Respect my overrides and the levels the current model supports.

### Suggest Ponytail ultra

When a request would benefit from `/ponytail ultra` (a vague build request, a large new feature, or work likely to grow beyond the need), suggest it using the same two-step process as the effort suggestion. Do not switch Ponytail yourself. After an ultra task, remind me in one line to switch back with `/ponytail full`.

### Keep Claude's global rules small

After editing `~/.claude/CLAUDE.md`, check its line count. If it exceeds 200 lines, tell me and suggest a reasonable split into topic files under `~/.claude/rules/`. Also suggest which rules could be scoped to file types with `paths:` frontmatter. Only suggest; do not split, move, or add path frontmatter until I approve.