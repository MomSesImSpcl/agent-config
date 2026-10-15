# Effort hook

`UserPromptSubmit` hook that reminds Claude, on every message, to run the effort-suggestion rule in `CLAUDE.md`. Without it the rule can be skipped for a whole session. Costs about 25 tokens per message; you never see its text.

1. Add this entry to the `hooks.UserPromptSubmit` array in `~/.claude/settings.json`, keeping existing entries:
   ```json
   {
     "hooks": [
       {
         "type": "command",
         "command": "echo 'Effort check: before acting on a new request, check the effort level with get_session(self) and follow the CLAUDE.md effort-suggestion rule.'"
       }
     ]
   }
   ```
2. Restart Claude Code.

`sync-rules.sh` and `sync-rules.ps1` warn at session start while the hook is missing.
