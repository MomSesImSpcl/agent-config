# Codex rules

@RTK.md

## Shared rules

Read `~/.codex/SHARED.md` before acting on every task, and follow it. This copy is synchronized from the canonical `~/.claude/SHARED.md`; edit the canonical file in `~/.claude`, never the synchronized copy. After changing a rule, sync the Codex copies and inspect the resulting diff. On Windows run `& "$HOME\.claude\sync-rules.ps1" -SyncOnly`; on macOS/Linux run `bash ~/.claude/sync-rules.sh --sync-only`.

## Codex-specific model and effort guidance

### Suggest an effort level

Before each request, check the current model and effort from the active Codex session when available. Keep the selected model and recommend only an effort it supports. If the current effort already fits the task, say nothing and start work. Otherwise reply only with `Suggested effort: <Effort> (<short reason>)`; do not start until my next message. Then do the task at whatever model and effort are active, even if I did not switch. Do not suggest again for the same request.

Do not change the model or effort yourself. Codex may not expose this chat's selection in task metadata. If you cannot check it, do not treat `config.toml`'s default as the active selection: recommend the appropriate model and effort from the table, say that the current selection is not visible, and wait for my next message before working. If the current model is visible, recommend only an effort supported by that model.

| Model and effort | Good fit |
|---|---|
| GPT-6 Luna · High | Routine coding and edits when you want an efficient default |
| GPT-6.1 Sol · Light | Focused coding tasks where speed matters: a clear bug fix or small change |
| GPT-6.1 Sol · Medium | Everyday coding, debugging, and tasks that need sound judgment |
| GPT-6 Astra · Light | A stronger model for a well-scoped task where you still want a quicker response |
| GPT-6 Astra · Medium | Ambitious or multi-step work that needs broader reasoning and follow-through |

For high-risk work, verify more thoroughly at any setting.
