# Claude Code

Claude Code reads `~/.claude/CLAUDE.md` (which imports `SHARED.md`) and `~/.claude/rules/` directly from the repo, so it only needs the sync hook.

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
