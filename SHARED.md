# Shared rules

Rules for both Claude Code and Codex. `CLAUDE.md` and `AGENTS.md` are the app entry points; this file is the source of truth for behavior both share.

## Respect my edits
Any change in a file you didn't make is my edit. Build on the current file; never overwrite it with an older version you remember.
- Read only the lines you change, and use `git diff` to spot my changes. Don't re-read whole files.
- Use exact-match edits, so an edit fails instead of overwriting a spot I changed. No whole-section rewrites from memory or scripts.
- Mention any change of mine you notice; never undo it.

## Suggest account-wide rules
When a project memory you save or update would help other projects too, suggest adding it to these global rules. Add it only after I say yes.

## Sync global rules
The rules live in the `~/.claude` repo: rules for both apps in `SHARED.md`, for one app in `CLAUDE.md` (Claude Code) or `AGENTS.md` (Codex). Never edit the copies in `~/.codex`; they are synced from `~/.claude`. After changing `AGENTS.md`, `SHARED.md` or `.agents/skills/`, refresh them: `& "$HOME\.claude\sync-rules.ps1" -SyncOnly` on Windows, `bash ~/.claude/sync-rules.sh --sync-only` on macOS/Linux. Then verify the copies match their sources and inspect the diff. If sync or verification fails, report it; don't claim completion.

After adding or changing a rule, commit only the changed rule files with a short descriptive message and `git push` from `~/.claude`.
- Push rejected because GitHub has newer commits (another machine pushed first): `git pull --rebase` in `~/.claude`, then push again.
- Rebase conflict: stop, show me both versions of the conflicting lines and ask which to keep. Never use `git reset --hard`, `git push --force` or `git checkout --` on this repo to resolve it.
- Any other push failure (auth, network): tell me instead of retrying.
- Never commit or push my own uncommitted edits without asking.

## Pull remote rule updates
At each session start, before relying on the local global rules, run `git pull --rebase` in `~/.claude`, then the sync script for your platform (commands above), and verify the copies match their sources. Repeat when you learn the remote rules changed. If local changes block a safe pull or the rebase conflicts, stop and report; never discard local edits.

## Keep global rules short
Keep always-loaded rules short. Move conditional workflows into an app-specific skill or topic rule, linked from that app's entry point.

## Switch to Ponytail ultra
When a request would benefit from Ponytail ultra (vague "build me X" asks, large new features, anything likely to outgrow what the need justifies): say so in one line, e.g. "Switching to Ponytail ultra (vague scope, easy to overbuild)", then load the ponytail skill with `ultra` right away and do the work. Don't wait for my reply. If an effort suggestion is due, put that line on the suggestion reply and switch when the work starts. When the ultra task is done, load the ponytail skill with `full` and say so in one line. Ponytail's own status may keep showing `full` meanwhile; that is expected.

## Commands for me to run
On Windows, write them for Windows PowerShell 5.1: chain with `;` or `if ($?) { ... }`, never `&&` or `||`, and tag the block `powershell`.

## Commit means push
"Commit" means commit and push; don't ask separately. You may also commit and push unasked when my intent is clear and no questions are open; otherwise ask first.

## Branch from fresh main
Before creating a PR branch, run `git fetch` and branch from `origin/<main branch>`, not the local checkout's possibly stale HEAD. PR behind its base: merge `origin/<main branch>` into its branch locally and push. Never use `gh pr update-branch` or GitHub's Update branch button: their merge commit is GitHub's, which a ruleset can hold for extra approval and so block auto-merge.

## Clean up merged branches
Once a branch is fully merged into the main branch, delete it locally and on the remote, and remove its worktree when the session using it is done. Check for uncommitted or unmerged work first; never remove a worktree another active session uses.
