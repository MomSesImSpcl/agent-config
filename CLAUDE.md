# Claude Code rules

@SHARED.md

## Claude-specific guidance

### Suggest an effort level
On every new request, compare my current level with the one the task needs (guide below). Never change the level yourself. Current level: the effort hook's "Current effort: …" line; else `get_session` (`"self"`); else a level the host states (e.g. an AI Workspace session note).
- Level fits: say nothing, start the work.
- Doesn't fit: reply with only one line, e.g. "Suggested effort: High (unclear cause, several interacting parts)", and don't start. On my next message, do the work at whatever level I'm on, switched or not. Don't suggest again for the same request.
- Can't check the level at all: always give that one-line reply, e.g. "Suggested effort: High (can't check your level)", and wait for my next message, even if I might already be on that level.

Pick the lowest level that is enough, by reasoning complexity, uncertainty, scope, risk and how hard the result is to verify. Task length and file count don't decide it.

| Level | Use for | Examples |
|---|---|---|
| Low | Straightforward, deterministic tasks with clear instructions and minimal reasoning | Formatting, documentation, renaming, simple fixes |
| Medium | Moderate reasoning with established solutions and limited uncertainty | Standard features, routine refactoring, unit tests, isolated debugging |
| High | Complex multistep reasoning, interacting components, unclear solutions or real trade-offs | Advanced features, routine architecture choices, performance optimization, complex debugging |
| Extra (xhigh) | Deep, sustained reasoning across interconnected systems, hard constraints or extensive evaluation | Distributed systems, system-wide redesigns, difficult concurrency issues |
| Max | Exceptional difficulty, novel problems, critical correctness, or problems Extra failed to solve | Only where more reasoning clearly helps |

**Ultracode** (toggle, any level, `/effort ultracode`): runs a multi-agent workflow for every substantive task until turned off. For work too big for one conversation: codebase-wide audits, large migrations, cross-checked research, plans from several angles, bug sweeps, fix-until-the-check-passes loops. Not for small tasks. Far more tokens and time; not smarter than Max. Suggest it only when parallel work outweighs the coordination overhead, with a reason, on the one-line reply, e.g. "Suggested effort: High + Ultracode (independent parts)", and wait for my next message, even if the level already fits or Ultracode might already be on (`get_session` can't report it).

#### Rules for choosing
1. Default to the lowest level likely to succeed reliably.
2. Complexity and uncertainty outweigh task size.
3. High-risk changes: verify more thoroughly, whatever the level.
4. Go up only when more reasoning is likely to solve it. Missing context needs looking up, not a higher level.
5. A previous attempt at the current level failed: go up one.
6. One level per request. If a later phase clearly needs another, say so in one line without stopping.
7. Max only with a reason: it is slow and costly.
8. Respect my overrides and the levels the current model supports.

### Keep Claude rules small
After editing `~/.claude/CLAUDE.md`, check its line count. Over 200 lines: tell me and suggest a split into topic files in `~/.claude/rules/` (e.g. `git.md`, `writing.md`), plus which rules should apply only to certain file types via `paths:` frontmatter (e.g. `paths: ["**/*.ts"]`). Suggest only: no split, move or `paths:` change until I approve. Once approved, update the repo's `.git/info/exclude` so `rules/` is tracked, then commit and push as in `SHARED.md`.
