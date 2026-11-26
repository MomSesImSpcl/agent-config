# Hindsight

Long-term memory for coding agents, one memory bank per git repo, shared by Claude Code and Codex. Runs as a local daemon: no account, memory stays on this machine. Memory extraction uses the Claude Code CLI login, so it uses some Claude usage but needs no API key. MIT license, from `vectorize-io/hindsight`.

1. Install `uv`, which the daemon needs. On Windows:
   ```powershell
   winget install --id astral-sh.uv
   ```
   On macOS/Linux, see https://docs.astral.sh/uv/. macOS also needs a current Rust toolchain.
2. Install Hindsight for Claude Code in daemon mode. On Windows PowerShell use `npx.cmd`, not `npx`:
   ```powershell
   npx.cmd -y @vectorize-io/hindsight-coding-agents install claude-code --server daemon
   ```
   This adds 3 hooks to `~/.claude/settings.json`, the skill `~/.claude/skills/hindsight-coding-agent` and a user-scope MCP server `hindsight`. Settings live in `~/.hindsight/coding-agent.json`. Add `codex` after `claude-code` to cover Codex too.
3. Restart Claude Code. A session in a git repo shows a 🧠 banner.

Check it with `claude mcp list` (`hindsight` should show `✔ Connected`). Update the runtime with `npx.cmd @vectorize-io/hindsight-coding-agents update`; remove it with `npx.cmd @vectorize-io/hindsight-coding-agents uninstall claude-code`.

`sync-rules.sh` and `sync-rules.ps1` warn at session start while Hindsight is missing.
