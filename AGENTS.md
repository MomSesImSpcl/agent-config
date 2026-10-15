# Codex rules

@RTK.md

## Shared rules

Read `~/.codex/SHARED.md` before acting on every task, and follow it. This copy is synchronized from the canonical `~/.claude/SHARED.md`; edit the canonical file in `~/.claude`, never the synchronized copy. After changing a rule, sync the Codex copies and inspect the resulting diff. On Windows run `& "$HOME\.claude\sync-rules.ps1" -SyncOnly`; on macOS/Linux run `bash ~/.claude/sync-rules.sh --sync-only`.

## Codex-specific model and effort guidance

Use the lightest model and effort likely to complete the task reliably. Suggest a different one only when it is likely to improve the result; state the suggestion briefly and continue the task without waiting for a change. Do not claim to change the active setting; the user controls it.

| Model and effort | Good fit |
|---|---|
| GPT-6 Luna · High | Routine coding and edits when you want an efficient default |
| GPT-6.1 Sol · Light | Focused coding tasks where speed matters: a clear bug fix or small change |
| GPT-6.1 Sol · Medium | Everyday coding, debugging, and tasks that need sound judgment |
| GPT-6 Astra · Light | A stronger model for a well-scoped task where you still want a quicker response |
| GPT-6 Astra · Medium | Ambitious or multi-step work that needs broader reasoning and follow-through |

For high-risk work, verify more thoroughly at any setting.
