# Caveman

Terse reply style, token-saving hooks, and an optional Auto model that picks model and effort per request.

## Install

1. Node.js 22.13 or newer (`node -v`). With nvm: `nvm install 24.20.0`, then `nvm use 24.20.0`.
2. Run the installer. On Windows PowerShell use `npx.cmd`, not `npx`:
   ```bash
   npx.cmd @caveman-ai/cli@latest
   ```
3. The installer may skip the plugin. If `claude plugin list` lacks `caveman@caveman`, run:
   ```bash
   claude plugin install caveman@caveman
   ```
   Then run `caveman.cmd doctor claude --fix` (see Troubleshooting if it refuses).
4. Default mode for new sessions: `ultracave`. The sync scripts create this config at session start if it is missing, and never overwrite an existing one. It lives in `%APPDATA%\caveman\config.json` (Windows) or `~/.config/caveman/config.json` (macOS/Linux):
   ```json
   { "defaultMode": "ultracave" }
   ```
   Valid values: `off`, `caveman`, `ultracave`, `megacave`, `manual`. `/ultracave` and similar commands change only the current session.
5. Restart Claude Code.

`sync-rules.sh` warns at session start while Caveman is missing.

## Windows PowerShell

PowerShell blocks the unsigned `caveman.ps1` shim ("is not digitally signed"). Call `caveman.cmd` instead, e.g. `caveman.cmd status`. Don't change the execution policy for this.

## Auto model (optional)

1. Sign in with `caveman.cmd login`. In the browser, choose "CLI with inference key" and the "Default" project. Approve only if the device code matches the terminal.
2. Start Claude through Caveman: `caveman.cmd claude`. Auto then shows in `/model`.

Auto works only in terminal sessions started this way: the desktop app sends requests straight to Anthropic. The rest of Caveman (reply style, hooks, skills) works in the desktop app too.

Each Auto request sends your latest ask, the one before, and the end of the last reply to Caveman Cloud; on the Free plan Caveman may keep them. Turn routing off with `caveman.cmd off routing`, telemetry with `caveman.cmd telemetry off`.

## Troubleshooting

`caveman.cmd doctor claude` checks the setup; `caveman.cmd doctor claude --fix` repairs it. If the fix refuses with "Caveman hook changed after enable": back up `settings.json`, delete the `caveman ... shrink-hook` entry under `PreToolUse`, and run the fix again. It writes the entry back.
