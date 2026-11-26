# Effort hook

`UserPromptSubmit` hook that reminds Claude, on every message, to run the effort-suggestion rule in `CLAUDE.md`, and tells it the session's current effort level, so no `get_session` call is needed. Without it the rule can be skipped for a whole session. Needs Node.js. Costs about 30 tokens per message; you never see its text.

The script is `setup/effort-check.js`. Message hooks get no effort field, so it reads the live level from the desktop app's session record (Windows: `%LOCALAPPDATA%\Claude-Data\…\claude-code-sessions`). Elsewhere, such as the plain terminal or macOS, it falls back to the level on the last assistant entry in the session transcript, marked "(as of the last reply)": a switch right before a message shows up one message late there.

1. Add this entry to the `hooks.UserPromptSubmit` array in `~/.claude/settings.json`, keeping existing entries:
   ```json
   {
     "hooks": [
       {
         "type": "command",
         "command": "node \"$HOME/.claude/setup/effort-check.js\""
       }
     ]
   }
   ```
2. Restart Claude Code.

`sync-rules.sh` and `sync-rules.ps1` warn at session start while the hook is missing.
