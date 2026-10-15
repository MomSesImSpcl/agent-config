# Cache Tax

Plugin that keeps the one-hour prompt cache warm during breaks, and stops a send once when the cache has gone cold, showing the estimated cost of rebuilding it. Warming sends model requests, so it costs some tokens. Needs Claude Code 2.1.287 or newer.

1. Install it:
   ```bash
   claude plugin marketplace add karanb192/claude-code-mods
   claude plugin install cache-tax@claude-code-mods
   ```
2. Restart Claude Code.

`sync-rules.sh` warns at session start while Cache Tax is missing.
