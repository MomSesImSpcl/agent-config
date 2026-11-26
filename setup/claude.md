# Claude Code

Claude Code reads `~/.claude/CLAUDE.md` (which imports `SHARED.md`) and `~/.claude/rules/` directly from the repo, so it only needs the sync hook.

On Windows, also install PowerShell 7, so commands chained with `&&` and `||` work (Windows PowerShell 5.1 rejects them). Open it as `pwsh`, not `powershell`:
```powershell
winget install --id Microsoft.PowerShell
```

Turn off the Ultracode keyword trigger, so the word `ultracode` in a prompt doesn't start a multi-agent workflow (Ultracode stays available via `/effort ultracode`). Add to `~/.claude/settings.json`:
```json
"workflowKeywordTriggerEnabled": false
```

Add a SessionStart hook to `~/.claude/settings.json`. Merge it into any existing `hooks`; do not replace them.

Windows (PowerShell):
```json
"hooks": {
  "SessionStart": [
    { "hooks": [ { "type": "command", "command": "& \"$HOME/.claude/sync-rules.ps1\"" } ] }
  ]
}
```

macOS/Linux:
```json
"hooks": {
  "SessionStart": [
    { "hooks": [ { "type": "command", "command": "bash ~/.claude/sync-rules.sh" } ] }
  ]
}
```

The hook pulls rule updates from GitHub and warns while any of the [tools](../README.md#tool-setup-guides) is missing.
