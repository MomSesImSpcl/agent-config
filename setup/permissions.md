# Permissions

Permission rules for Git and GitHub. `allow` lets pushes and PR merges run without a prompt. `ask` makes branch deletion always prompt, so it runs only on your click. In Auto mode the safety check may still deny these deletes; switch to Manual to approve them.

1. Merge these entries into `permissions` in `~/.claude/settings.json`, keeping existing entries:
   ```json
   "allow": [
     "Bash(git push:*)",
     "Bash(gh pr merge:*)"
   ],
   "ask": [
     "Bash(git branch -D:*)",
     "Bash(git branch -d:*)",
     "Bash(git push origin --delete:*)",
     "PowerShell(git branch -D:*)",
     "PowerShell(git branch -d:*)",
     "PowerShell(git push origin --delete:*)"
   ]
   ```
2. Restart Claude Code.
