# Codex rules

@RTK.md

## Shared rules

Read `~/.codex/SHARED.md` before acting on every task, and follow it. This copy is synchronized from the canonical `~/.claude/SHARED.md`; edit the canonical file in `~/.claude`, never the synchronized copy. After changing a rule, sync the Codex copies and inspect the resulting diff. On Windows run `& "$HOME\.claude\sync-rules.ps1" -SyncOnly`; on macOS/Linux run `bash ~/.claude/sync-rules.sh --sync-only`.

## Codex-specific effort guidance

Use the lowest Codex reasoning effort likely to complete the task reliably. Suggest a higher effort only when more reasoning is likely to improve the result; state the suggestion briefly and continue the task without waiting for a level change. Do not claim to change the active setting; the user controls it.

| Effort | Use for |
|---|---|
| Low | Clear, routine tasks with little uncertainty |
| Medium | Default for ordinary implementation, review, and debugging |
| High | Multistep work, interacting components, unclear causes, or meaningful trade-offs |
| Extra (xhigh) | Deep analysis across systems, hard constraints, or extensive evaluation |
| Max | Exceptional difficulty, novel problems, or critical correctness where Extra is insufficient |
| Ultra | Only when substantial work benefits from parallel agents; this is a coordination mode, not a higher reasoning level |

For high-risk work, verify more thoroughly at any effort. Suggest Max or Ultra only with a concrete reason.

## Unity and C# work

For Unity/C# tasks, use the `unity-performance` skill when it is available. If it is not available in this session, remind me once per session that the Unity Performance plugin has Codex support and can be installed from the Codex plugin manager. Do not run Claude Code plugin commands or install it without my request.