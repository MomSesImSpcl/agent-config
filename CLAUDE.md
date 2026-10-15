# Global rules

## Respect my edits
Any change in a file that you didn't make is my own edit. Build on the current file, never overwrite it with an older version you remember.
- Don't re-read whole files. Read only the lines you're changing, and use `git diff` to spot my changes.
- Use exact-match edits, so an edit fails instead of overwriting a spot I changed. No whole-section rewrites from memory or scripts.
- If you notice one of my changes, mention it instead of undoing it.

## Suggest account-wide rules
When you save or update a project memory and the rule would also be useful in other projects, suggest adding it here. Only add it after I say yes.

## Sync global rules
After you add or change a rule in `~/.claude/CLAUDE.md`, commit just that file with a short descriptive message and `git push` from `~/.claude`. If the push is rejected because GitHub has newer commits (another machine pushed first), run `git pull --rebase` in `~/.claude`, then push again. If the rebase hits a conflict, stop, show me both versions of the conflicting lines, and ask which to keep. Never use `git reset --hard`, `git push --force`, or `git checkout -- CLAUDE.md` on this repo to resolve it. For any other push failure (auth, network), tell me instead of retrying. Don't commit or push my own uncommitted edits to that file without asking.

## Keep global rules small
After editing `~/.claude/CLAUDE.md`, check its line count. If it is over 200 lines, tell me and suggest a reasonable split into topic files in `~/.claude/rules/` (e.g. `git.md`, `writing.md`). Also suggest which rules should only apply to certain file types, using `paths:` frontmatter (e.g. `paths: ["**/*.ts"]`). Only suggest; make no split, move or `paths:` change until I approve. If I approve, update the repo's `.git/info/exclude` so `rules/` is tracked, then commit and push as above.

## Commit means push
When I say "commit", also push after committing. Don't ask separately.

## Suggest an effort level
Before every request, suggest the effort level that fits it, using the guide below. Put it in one line, e.g. "Suggested effort: High (refactor across several files)". If my current level is already right, say nothing and do the work right away. Otherwise it's a 2-step process:
1. Reply with only the suggestion. Don't start the work.
2. On my next message, do the work at whatever level I'm on, even if I didn't switch. Don't suggest again for the same request.

Don't change the level yourself. Check my current level with `get_session` (`"self"`). It can't report Ultracode, so whenever you think a task warrants Ultracode, always say so, even if I might already be on it.

| Level | Use for | Examples |
|---|---|---|
| Low | Trivial, mechanical work with one obvious answer | Typos, renames, formatting, quick factual questions, single-line fixes |
| Medium | Everyday tasks with a clear scope, mostly in one file | Small features, bug fixes with a known cause, explaining code, writing a short script |
| High | Work across several files, or where mistakes are costly | Refactors, bugs with an unclear cause, new features touching several parts, writing tests for complex logic |
| Extra (xhigh) | Hard problems that need deep reasoning | Architecture decisions, concurrency, security-sensitive code, debugging that failed at High |
| Max | The hardest reasoning, where correctness matters more than speed | Subtle algorithmic problems, critical production fixes, problems that failed at Extra |
| Ultracode | Very large or critical work where cost and time don't matter | Large refactors across the whole codebase, long autonomous tasks, last resort when Max isn't enough |

### Rules for choosing
- Go up one level if the task has an unclear cause or a mistake would be expensive to undo.
- Go up one level if a previous attempt at the current level failed.
- Go down to Low for busywork, even inside a big project.
- Suggest Max or Ultracode only with a reason. They are slow and costly.

@RTK.md
