# Claude Code rules

@SHARED.md

## Claude-specific guidance

### Suggest an effort level
Before every request, suggest the effort level that fits it, using the guide below. Put it in one line, e.g. "Suggested effort: High (unclear cause, several interacting parts)". If my current level is already right, say nothing and do the work right away. Otherwise it's a 2-step process:
1. Reply with only the suggestion. Don't start the work.
2. On my next message, do the work at whatever level I'm on, even if I didn't switch. Don't suggest again for the same request.

Don't change the level yourself. Check my current level with `get_session` (`"self"`). If the host states the session's effort level instead (for example an AI Workspace session note), use that as my current level. If you can't check it (no `get_session`, e.g. in `claude -p` or the plain terminal), always use the 2 steps, even if I might already be on that level: reply with only one line like "Suggested effort: High (can't check your level)" and wait for my next message. `get_session` can't report Ultracode, so whenever you think a task warrants Ultracode, always say so, even if I might already be on it.

Pick the lowest level that is enough, based on reasoning complexity, uncertainty, scope, risk and how hard the result is to verify. Task length and file count don't decide it.

| Level | Use for | Examples |
|---|---|---|
| Low | Straightforward, deterministic tasks with clear instructions and minimal reasoning | Formatting, documentation, renaming, simple fixes |
| Medium | Moderate reasoning with established solutions and limited uncertainty | Standard features, routine refactoring, unit tests, isolated debugging |
| High | Complex multistep reasoning, interacting components, unclear solutions or real trade-offs | Advanced features, routine architecture choices, performance optimization, complex debugging |
| Extra (xhigh) | Deep, sustained reasoning across interconnected systems, hard constraints or extensive evaluation | Distributed systems, system-wide redesigns, difficult concurrency issues |
| Max | Exceptional difficulty, novel problems, critical correctness, or problems Extra failed to solve | Only where more reasoning clearly helps |
| Ultracode | Multi-agent orchestration for large tasks that split into independent parts | Repository-wide audits, large migrations, independent implementations. Not smarter than Max: it is about parallel work, not deeper reasoning |

#### Rules for choosing
1. Default to the lowest level likely to succeed reliably.
2. Weigh complexity and uncertainty over task size.
3. For high-risk changes, verify more thoroughly, whatever the level.
4. Go up a level only when more reasoning is likely to solve the problem. Missing context needs looking up, not a higher level.
5. Go up one level if a previous attempt at the current level failed.
6. Suggest one level per request. If a later phase clearly needs a different level, mention it in one line at that point, without stopping.
7. Suggest Ultracode only when parallel work outweighs the coordination overhead.
8. Suggest Max or Ultracode only with a reason. They are slow and costly.
9. Respect my overrides and the levels the current model supports.

### Keep Claude rules small
After editing `~/.claude/CLAUDE.md`, check its line count. If it is over 200 lines, tell me and suggest a reasonable split into topic files in `~/.claude/rules/` (e.g. `git.md`, `writing.md`). Also suggest which rules should only apply to certain file types, using `paths:` frontmatter (e.g. `paths: ["**/*.ts"]`). Only suggest; make no split, move or `paths:` change until I approve. If I approve, update the repo's `.git/info/exclude` so `rules/` is tracked, then commit and push as in `SHARED.md`.
