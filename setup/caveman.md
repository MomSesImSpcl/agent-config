# Caveman

Terse reply style, token-saving hooks, and an optional Auto model that picks model and effort per request.

## Install

1. Check Node.js is 22.13 or newer with `node -v`. With nvm: `nvm install 24.20.0`, then `nvm use 24.20.0`.
2. Run the installer. On Windows PowerShell use `npx.cmd`, not `npx`:
   ```bash
   npx.cmd @caveman-ai/cli@latest
   ```
   This includes the Caveman plugin. Don't install the plugin separately.
3. Restart Claude Code.

`sync-rules.sh` warns at session start while Caveman is missing.

## Windows PowerShell

PowerShell blocks the unsigned `caveman.ps1` shim ("is not digitally signed"). Call `caveman.cmd` instead of `caveman`, for example `caveman.cmd status`. Don't change the execution policy for this.

## Auto model (optional)

1. Sign in with `caveman.cmd login`. In the browser, choose "CLI with inference key" and the "Default" project. Approve only if the device code matches the terminal.
2. Start Claude through Caveman: `caveman.cmd claude`. Auto shows in `/model` there.

Auto only works in terminal sessions started this way. The desktop app sends requests straight to Anthropic, so it never uses Auto. The rest of Caveman (reply style, hooks, skills) works in the desktop app too.

Each Auto request sends your latest ask, the one before, and the end of the last reply to Caveman Cloud. On the Free plan Caveman may keep them. Turn it off with `caveman.cmd off routing`, and telemetry with `caveman.cmd telemetry off`.

## Troubleshooting

`caveman.cmd doctor claude` checks the setup, and `caveman.cmd doctor claude --fix` repairs it. If the fix refuses with "Caveman hook changed after enable", back up `settings.json`, delete the `caveman ... shrink-hook` entry under `PreToolUse`, and run the fix again. It writes the entry back.
