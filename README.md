# claude-config

My Claude Code config: global rules plus setup guides for the tools they rely on, synced across machines.

| Path | What it is |
|---|---|
| `CLAUDE.md` | Main rules, loaded in every project |
| `rules/` | Topic rules, also loaded in every project (or only for matching files, via `paths:` frontmatter) |
| `setup/` | Install steps for the tools the rules rely on |
| `sync-rules.sh` | Session-start hook that pulls updates from GitHub |

## Setup on a new machine

1. Back up any existing `~/.claude/CLAUDE.md` (it will be replaced).
2. Clone into `~/.claude` (works even if the folder already exists):
   ```bash
   cd ~/.claude
   git init -b main
   git remote add origin https://github.com/MomSesImSpcl/claude-config.git
   printf '*\n!CLAUDE.md\n!sync-rules.sh\n!README.md\n!rules/\n!rules/**\n!setup/\n!setup/**\n' >> .git/info/exclude
   git fetch origin && git reset --hard origin/main
   git branch --set-upstream-to=origin/main main
   ```
   The exclude rule keeps settings, credentials and projects out of the repo.
3. Add the auto-sync hook to `~/.claude/settings.json` (merge into any existing `hooks`):
   ```json
   "hooks": {
     "SessionStart": [
       { "hooks": [ { "type": "command", "command": "bash ~/.claude/sync-rules.sh" } ] }
     ]
   }
   ```
4. Needs `git` authenticated to GitHub (`gh auth login`).
5. Install the tools: [rtk](setup/rtk.md), [Ponytail](setup/ponytail.md), [Caveman](setup/caveman.md). `sync-rules.sh` warns at session start while any of them is missing.

## Day to day
- Claude commits and pushes rule changes itself (see the "Sync global rules" rule).
- Other machines pick them up at the next session start (checked at most every 6 hours; changes apply from the session after).
