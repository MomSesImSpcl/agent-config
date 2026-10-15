# Shared rules

These rules apply to both Claude Code and Codex. `CLAUDE.md` and `AGENTS.md` are the app-specific entry points; this file is the source of truth for behavior that should match between them.

## Respect my edits
Any change in a file that you didn't make is my own edit. Build on the current file, never overwrite it with an older version you remember.
- Don't re-read whole files. Read only the lines you're changing, and use `git diff` to spot my changes.
- Use exact-match edits, so an edit fails instead of overwriting a spot I changed. No whole-section rewrites from memory or scripts.
- If you notice one of my changes, mention it instead of undoing it.

## Suggest account-wide rules
When you save or update a project memory and the rule would also be useful in other projects, suggest adding it to these global rules. Only add it after I say yes.

## Sync global rules
The rules live in the `~/.claude` repo. A rule for both apps goes in `SHARED.md`; a rule for one app goes in `CLAUDE.md` (Claude Code) or `AGENTS.md` (Codex). Never edit the copies in `~/.codex`; they are synced from `~/.claude`. After changing `AGENTS.md`, `SHARED.md` or `.agents/skills/`, refresh the Codex copies: `& "$HOME\.claude\sync-rules.ps1" -SyncOnly` on Windows, `bash ~/.claude/sync-rules.sh --sync-only` on macOS/Linux.

After you add or change a rule, commit just the changed rule files with a short descriptive message and `git push` from `~/.claude`. If the push is rejected because GitHub has newer commits (another machine pushed first), run `git pull --rebase` in `~/.claude`, then push again. If the rebase hits a conflict, stop, show me both versions of the conflicting lines, and ask which to keep. Never use `git reset --hard`, `git push --force`, or `git checkout --` on this repo to resolve it. For any other push failure (auth, network), tell me instead of retrying. Don't commit or push my own uncommitted edits without asking.

## Keep global rules short
Keep always-loaded rules short. Move conditional workflows into an app-specific skill or topic rule, and link to it from that app's entry point.

## Suggest Ponytail ultra
When a request would benefit from `/ponytail ultra` (vague "build me X" asks, large new features, or anything likely to grow past what the need justifies), suggest it in 2 steps: reply with only one line like "Suggested: /ponytail ultra (vague scope, easy to overbuild)", then on my next message do the work at whatever level I'm on. If an effort suggestion is due too, put both on that one reply. Don't switch Ponytail yourself. Once an ultra task is done, remind me in one line to switch back with `/ponytail full`.

## Unity and C# work
When working on Unity or C# code, use the Unity Performance plugin skills (`unity-performance`, `csharp-zero-gc`, `code-standards`) when available. If they are not, remind me once per session, in one line, to install the plugin (https://github.com/MomSesImSpcl/Unity-Performance). Don't install it yourself.
- Claude Code: it is enabled when `"unity-perf@gqy-plugins": true` is in `~/.claude/settings.json` or the project's `.claude/settings.json`. Install with `claude plugin marketplace add MomSesImSpcl/Unity-Performance` then `claude plugin install unity-perf@gqy-plugins`.
- Codex: install it from the Codex plugin manager. Don't run Claude Code plugin commands.

## Commit means push
When I say "commit", also push after committing. Don't ask separately.
