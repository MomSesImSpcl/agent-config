# rtk

`rules/rtk.md` expects rtk, which condenses command output to save tokens.

1. Install it, then set up its hook (answer `y` to patch `settings.json`):
   ```bash
   winget install rtk-ai.rtk
   rtk init -g
   ```
2. Restart Claude Code.

`sync-rules.sh` warns at session start while rtk is missing.
