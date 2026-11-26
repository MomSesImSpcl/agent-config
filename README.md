# agent-config

My shared rules for Claude Code and Codex, plus app-specific guidance and setup notes, synced across machines.

## Rule files

| Path | What it is |
|---|---|
| `SHARED.md` | Canonical rules for both apps |
| `CLAUDE.md` | Claude Code entry point and Claude-specific behavior; imports `SHARED.md` |
| `AGENTS.md` | Codex entry point and Codex-specific behavior; reads the synced `SHARED.md` beside it |
| `rules/` | Topic rules for Claude Code. `rules/unity.md` loads only for Unity/C# files and is also synced to Codex as the `unity-csharp` skill |
| `setup/` | App and tool setup guides |
| `sync-rules.sh` / `sync-rules.ps1` | Session-start sync: fast-forwards this repo safely and refreshes Codex's global copies |

## One source for shared behavior

`SHARED.md` is authoritative for rules both apps share; Claude Code imports it through `CLAUDE.md`, and Codex gets a synced copy. Whichever app changes a shared rule, edit `SHARED.md` and run the sync script. App-only behavior goes in `CLAUDE.md` or `AGENTS.md`; if it changes a shared rule, update `SHARED.md` too.

After a rule edit, inspect the full diff, commit only the relevant tracked files, and push. Never include local settings, caches, credentials, unrelated changes or uncommitted user edits without asking. Never reset or force-push. On a rebase conflict, stop and ask which version to keep.

## Setup on a new machine

1. Back up existing `~/.claude/CLAUDE.md` and `~/.codex/AGENTS.md`; they will be replaced.
2. Clone into `~/.claude` (works even if the folder already exists):
   ```bash
   cd ~/.claude
   git init -b main
   git remote add origin https://github.com/MomSesImSpcl/agent-config.git
   printf '*\n!CLAUDE.md\n!AGENTS.md\n!SHARED.md\n!sync-rules.sh\n!sync-rules.ps1\n!README.md\n!LICENSE\n!rules/\n!rules/**\n!setup/\n!setup/**\n' >> .git/info/exclude
   git fetch origin && git reset --hard origin/main
   git branch --set-upstream-to=origin/main main
   ```
   The exclude rule keeps settings, credentials and projects out of the repo.
3. Authenticate Git to GitHub (`gh auth login`). Sync only fetches and fast-forwards; it never pulls over local or unpushed changes.
4. Set up each app: [Claude Code](setup/claude.md) · [Codex](setup/codex.md).

## Day to day

- Both apps edit the same tracked rule files here. Shared behavior goes in `SHARED.md`; app-only behavior in that app's entry point or skill.
- After changing Codex rules, run the sync script so Codex's home gets the current files. Claude Code reads `CLAUDE.md` and the imported `SHARED.md` straight from the repo.
- Rule changes are committed and pushed, so other machines get them at their next session start (checked at most every 6 hours).

## Tool setup guides

[RTK](setup/rtk.md) · [Ponytail](setup/ponytail.md) · [Caveman](setup/caveman.md) · [Cache Tax](setup/cache-tax.md) · [Effort hook](setup/effort-hook.md) · [Hindsight](setup/hindsight.md) · [Permissions](setup/permissions.md)
