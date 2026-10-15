# Shared rules

These rules apply to both Codex and Claude Code. `AGENTS.md` and `CLAUDE.md` are the app-specific entry points; this file is the source of truth for behavior that should match between them.

## Respect my edits

Any change in a file you did not make is my edit. Build on the current file; never replace it with an older version you remember.
- Read only the lines you need to change, then inspect `git diff` to catch my edits.
- Make narrow, exact changes so an edit fails instead of overwriting text that changed.
- If you notice one of my changes, preserve it and mention it.

## Suggest account-wide rules

When saving or updating a project memory, suggest adding a rule here if it would help across projects. Add it only after I approve.

## Keep shared rules in sync

This repository is the single source for my Claude Code and Codex rules. When changing a rule that should apply to both apps, edit this file, keep the link/import in both `AGENTS.md` and `CLAUDE.md`, and sync the Codex copies. On Windows use `& "$HOME\.claude\sync-rules.ps1" -SyncOnly`; on macOS/Linux use `bash ~/.claude/sync-rules.sh --sync-only`. Do not make a shared rule change in only one app-specific file. Rules that genuinely depend on one app belong in that app's file; if they change shared behavior, update this file too.

After changing a rule, inspect the diff across all affected rule files. Commit only the relevant tracked source files in this repository, then push. Never include local settings, caches, credentials, unrelated changes, or my uncommitted edits without asking. If GitHub has newer commits, rebase before pushing. If a rebase conflicts, stop and show both versions; never reset or force-push. Do not include unrelated user edits in a commit. If authentication or network errors prevent a push, report that instead of retrying.

## Commit means push

When I say "commit", also push after committing. Do not ask separately.

## Keep global instructions concise

Keep always-loaded rules short. Move conditional workflows into the appropriate app-specific skill or topic rule, and link to it from that app's entry point.

## RTK command output

RTK condenses command output. Treat its output as complete. Run commands normally, and use `rtk proxy <cmd>` only when output is unusable: empty when output was clearly expected, contradicts its exit code, or is garbled. Truncated results include their recovery path.