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
