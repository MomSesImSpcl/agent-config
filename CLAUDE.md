# Claude Code rules

@SHARED.md

## Claude-specific guidance

### Suggest a model
Only on the first request of a session: if the current model (the effort hook's "Current model: …"; else `get_session`) doesn't fit what the session is for, put the model on the one-line suggestion, e.g. "Suggested: Sonnet 5.5, Medium (routine refactor)", and wait for my next message. Never suggest switching models mid-session: a switch rereads the whole context. If the work later moves to a clearly different scope for a sustained stretch, suggest in one line a new session with the fitting model. Pick the cheapest model likely to succeed.

| Model | Best for | Cost in/out per MTok | Speed |
|---|---|---|---|
| Haiku 5.5 | Simple, high-volume tasks: classification, extraction, routing, quick lookups | $0.10 / $0.50 (more on prompts over 100K tokens) | Fastest |
| Sonnet 5.5 | Daily coding with a clear scope; best balance of speed and intelligence | $2 / $10 | Fast |
| Opus 5.5 | Default for most work: complex reasoning, long-running agentic coding and knowledge work | $4 / $20 | Moderate |
| Fable 5.2 | Hardest, longest tasks: ambiguous root-cause or outage debugging, architecture, work bigger than one sitting, or where Opus 5.5 at higher effort falls short | $8 / $40 | Moderate |

All four have 1M context and every effort level.

### Suggest an effort level
On every new request, compare my current level with the one the task needs (guide below). Never change the level yourself. Current level: the effort hook's "Current effort: …" line; else `get_session` (`"self"`); else a level the host states (e.g. an AI Workspace session note).
- Level fits: say nothing, start the work.
- Doesn't fit: reply with only one line, e.g. "Suggested effort: High (unclear cause, several interacting parts)", and don't start. On my next message, do the work at whatever level I'm on, switched or not. Don't suggest again for the same request.
- Can't check the level at all: always give that one-line reply, e.g. "Suggested effort: High (can't check your level)", and wait for my next message, even if I might already be on that level.

Pick the lowest level that is enough, by reasoning complexity, uncertainty, scope, risk and how hard the result is to verify. Task length and file count don't decide it.

| Level | Use for | Examples |
|---|---|---|
| Low | Quick, deterministic tasks with clear instructions, where I review each result | Formatting, documentation, renaming, simple fixes, brainstorming, a first sketch |
| Medium | Day-to-day work with a clear scope and established solutions. Opus 5.5's default; there it matches Opus 5 at High | Standard features, routine refactoring, unit tests |
| High | Work where verification matters or edge cases are likely; complex reasoning, interacting components, real trade-offs | Fixing bugs in an existing codebase, advanced features, routine architecture choices, performance optimization |
| Extra (xhigh) | Long-running agentic work (30+ minutes) or deep reasoning across interconnected systems, at higher token spend | System-wide redesigns, distributed systems, difficult concurrency issues |
| Max | Hard problems worked through without me, critical correctness, or what Extra failed to solve. Diminishing returns, prone to overthinking | Security vulnerability hunts; only where more reasoning clearly helps |

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
