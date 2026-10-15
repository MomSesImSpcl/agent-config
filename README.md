# Claude global rules

`CLAUDE.md` here is loaded by Claude Code in every project. `sync-rules.sh` pulls updates from GitHub at session start.

## Setup on a new machine

1. Back up any existing `~/.claude/CLAUDE.md` (it will be replaced).
2. Clone into `~/.claude` (works even if the folder already exists):
   ```bash
   cd ~/.claude
   git init -b main
   git remote add origin https://github.com/MomSesImSpcl/claude-global-rules.git
   printf '*\n!CLAUDE.md\n!sync-rules.sh\n!README.md\n!RTK.md\n' >> .git/info/exclude
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
5. Install rtk, which `RTK.md` relies on, then set up its hook (answer `y` to patch `settings.json`) and restart Claude Code:
   ```bash
   winget install rtk-ai.rtk
   rtk init -g
   ```
   `sync-rules.sh` warns at session start while rtk is missing.

## Day to day
- Claude commits and pushes rule changes itself (see the "Sync global rules" rule).
- Other machines pick them up at the next session start (checked at most every 6 hours; changes apply from the session after).
