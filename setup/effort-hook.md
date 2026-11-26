# Effort hook

`UserPromptSubmit` hook that reminds Claude, on every message, to run the effort-suggestion rule in `CLAUDE.md`, and tells it the session's current effort level (from `CLAUDE_EFFORT`), so no `get_session` call is needed. Without it the rule can be skipped for a whole session. Needs Node.js. Costs about 30 tokens per message; you never see its text.

1. Add this entry to the `hooks.UserPromptSubmit` array in `~/.claude/settings.json`, keeping existing entries:
   ```json
   {
     "hooks": [
       {
         "type": "command",
         "command": "node -e \"console.log('Effort check: before acting on a new request, follow the CLAUDE.md effort-suggestion rule. Current effort: ' + (process.env.CLAUDE_EFFORT || 'unknown, check with get_session(self)') + '.')\""
       }
     ]
   }
   ```
2. Restart Claude Code.

`sync-rules.sh` and `sync-rules.ps1` warn at session start while the hook is missing.
