# Codex rules

@RTK.md

## Shared rules
Before every task, read and follow `~/.codex/SHARED.md`. It is synced from `~/.claude/SHARED.md`: edit that canonical file, never the copy. After changing a rule, sync the Codex copies (`& "$HOME\.claude\sync-rules.ps1" -SyncOnly` on Windows, `bash ~/.claude/sync-rules.sh --sync-only` on macOS/Linux) and inspect the diff.

## Suggest an effort level
Before each request, check the session's current model and effort when available. Never change either yourself. Keep the selected model, and recommend only an effort it supports.
- Effort fits the task: say nothing, start work.
- Doesn't fit: reply only `Suggested effort: <Effort> (<short reason>)` and don't start. On my next message, do the task at whatever model and effort are active, switched or not. Don't suggest again for the same request.
- Current selection not visible: recommend an effort from the table without commenting on session visibility, and wait for my next message before working.

| Model | Light | Medium | High | Extra High | Max | Ultra |
|---|---|---|---|---|---|---|
| Luna | Quick lookups, tiny edits | Routine tasks | Multistep coding or debugging | Hard, long-running work | Critical or unusually hard tasks when Extra High is insufficient | Extremely rare tasks where Max is insufficient |
| Sol | Focused tasks with more capability | Everyday coding and analysis | Complex debugging, planning, or tradeoffs | Deep reviews or long-horizon tasks | Exceptional difficulty or critical correctness | Extremely rare tasks where Max is insufficient |
| Astra | Simple tasks where you want the strongest model | Ambitious, multistep work | Difficult reasoning and high-stakes reviews | The hardest sustained analysis | Highest-stakes work when Extra High is insufficient | Extremely rare tasks where Max is insufficient |

High-risk work: verify more thoroughly at any setting.
