# Codex

Codex reads its rules from `~/.codex` (or `$CODEX_HOME`). The sync script copies `AGENTS.md`, `SHARED.md`, and `rules/unity.md` (as the `unity-csharp` skill) there. Never edit those copies; edit the files in `~/.claude`.

1. Merge a SessionStart command hook into `~/.codex/hooks.json`. Preserve existing hook entries.
   - Windows: `powershell -NoProfile -ExecutionPolicy Bypass -File "$HOME/.claude/sync-rules.ps1"`. The bypass applies to that one run, so it works under an `AllSigned` policy.
   - macOS/Linux: `bash ~/.claude/sync-rules.sh`
2. Run the sync once by hand: `-SyncOnly` (PowerShell) or `--sync-only` (Bash).
3. For RTK, run `rtk init --codex`. It writes `~/.codex/RTK.md`, which `AGENTS.md` imports as `@RTK.md`.
4. Review and trust the new hook in Codex if prompted.
