# claude-config

My shared Claude Code and Codex rules, plus app-specific guidance and setup notes, synced across machines.

## Rule files

| Path | What it is |
|---|---|
| `SHARED.md` | Canonical rules that apply to both apps |
| `CLAUDE.md` | Claude Code entry point and Claude-specific behavior; imports `SHARED.md` |
| `AGENTS.md` | Codex entry point and Codex-specific behavior; reads the synchronized `SHARED.md` beside it |
| `rules/` | Topic rules for Claude Code, including path-scoped Unity guidance |
| `.agents/skills/` | Codex skills synced into `$CODEX_HOME/skills/` |
| `setup/` | Tool setup guides |
| `sync-rules.sh` / `sync-rules.ps1` | Session-start sync: fast-forwards this repo safely and refreshes Codex's global copies |

## One source for shared behavior

`SHARED.md` is authoritative for rules that should match in both apps. If a rule is changed from a Codex task, update `SHARED.md` and sync the Codex copy; Claude Code imports the same file through `CLAUDE.md`. If changed from Claude Code, update the same shared source and run the sync script so Codex gets the change too. Keep app-specific behavior in `AGENTS.md` or `CLAUDE.md`; if that behavior changes a shared rule, update `SHARED.md` as well.

After a rule edit, inspect the full diff. Commit only relevant tracked source files in this repository, then push. Never include local settings, caches, credentials, unrelated changes, or uncommitted user edits without asking. Never reset or force-push. If rebase conflicts, stop and ask which version to keep.

## Setup on a new machine

1. Back up existing `~/.claude/CLAUDE.md` and `~/.codex/AGENTS.md` before linking this config.
2. Clone this repository into `~/.claude` and configure Claude Code's existing SessionStart hook to run `sync-rules.ps1` with PowerShell on Windows, or `bash ~/.claude/sync-rules.sh` on macOS/Linux. Merge with existing hooks; do not replace them.
3. In Codex, merge a SessionStart command hook into `~/.codex/hooks.json`. On Windows use `& "$HOME/.claude/sync-rules.ps1"`; on macOS/Linux use `bash ~/.claude/sync-rules.sh`. Preserve existing hook entries. Run the script once with `-SyncOnly` (PowerShell) or `--sync-only` (Bash). It copies `AGENTS.md`, `SHARED.md`, and the Unity skill into Codex home. Review and trust the new hook in Codex if prompted.
4. Ensure Git is authenticated to GitHub. Sync uses fetch plus fast-forward only; it will not pull over local or unpushed changes.

## Day to day

- Both apps edit the same tracked rule sources in this repository.
- Shared behavior belongs in `SHARED.md`; app-only behavior belongs in that app's entry point or skill.
- Run the sync script after changing Codex rules so Codex home gets the current files. Claude Code reads the repo's `CLAUDE.md` and imported `SHARED.md` directly.
- Rule changes are committed and pushed so other machines receive them at the next session start.

## Tool setup guides

[RTK](setup/rtk.md) · [Ponytail](setup/ponytail.md) · [Caveman](setup/caveman.md) · [Cache Tax](setup/cache-tax.md)