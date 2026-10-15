# rtk

`rules/rtk.md` expects rtk, which condenses command output to save tokens.

1. Install it, then set up its hook (answer `y` to patch `settings.json`):
   ```bash
   winget install rtk-ai.rtk
   rtk init -g
   ```
2. On Windows, `rtk init -g` only hooks Bash. To cover PowerShell too, add a second `PreToolUse` entry to `~/.claude/settings.json`, next to the Bash one:
   ```json
   { "matcher": "PowerShell", "hooks": [ { "type": "command", "command": "rtk hook claude" } ] }
   ```
3. Restart Claude Code.

`sync-rules.sh` warns at session start while rtk is missing.
