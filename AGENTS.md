# Codex rules

@RTK.md

## Shared rules

Read `~/.codex/SHARED.md` before acting on every task, and follow it. This copy is synchronized from the canonical `~/.claude/SHARED.md`; edit the canonical file in `~/.claude`, never the synchronized copy. After changing a rule, sync the Codex copies and inspect the resulting diff. On Windows run `& "$HOME\.claude\sync-rules.ps1" -SyncOnly`; on macOS/Linux run `bash ~/.claude/sync-rules.sh --sync-only`.

## Codex-specific model and effort guidance

### Suggest an effort level

Before each request, check the current model and effort from the active Codex session when available. Keep the selected model and recommend only an effort it supports. If the current effort already fits the task, say nothing and start work. Otherwise reply only with `Suggested effort: <Effort> (<short reason>)`; do not start until my next message. Then do the task at whatever model and effort are active, even if I did not switch. Do not suggest again for the same request.

Do not change the model or effort yourself. Codex may not expose this chat's selection in task metadata. If you cannot check it, do not treat `config.toml`'s default as the active selection: recommend the appropriate model and effort from the table, say that the current selection is not visible, and wait for my next message before working. If the current model is visible, recommend only an effort supported by that model.

| Model | Light | Medium | High | Extra High | Ultra |
|---|---|---|---|---|---|
| Luna | Quick lookups, tiny edits | Routine tasks | Multistep coding or debugging | Hard, long-running work | Rare, unusually demanding work |
| Sol | Focused tasks with more capability | Everyday coding and analysis | Complex debugging, planning, or tradeoffs | Deep reviews or long-horizon tasks | Exceptional tasks where maximum reasoning is justified |
| Astra | Simple tasks where you want the strongest model | Ambitious, multistep work | Difficult reasoning and high-stakes reviews | The hardest sustained analysis | Only when the task is exceptional and extra compute is worthwhile |

For high-risk work, verify more thoroughly at any setting.
