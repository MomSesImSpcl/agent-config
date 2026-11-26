---
name: unity-csharp
description: Use when working on Unity or C# code, including .cs scripts, .asmdef assemblies, .unity scenes, .prefab files and ProjectSettings.
paths: ["**/*.cs", "**/*.asmdef", "**/*.unity", "**/*.prefab", "**/ProjectSettings/**"]
---

# Unity / C# performance skills
For Unity or C# code, use the Unity Performance plugin skills (`unity-performance`, `csharp-zero-gc`, `code-standards`) when available. If they aren't, remind me once per session, in one line, to install the plugin (https://github.com/MomSesImSpcl/Unity-Performance). Don't install it yourself.
- Claude Code: enabled when `"unity-perf@gqy-plugins": true` is in `~/.claude/settings.json` or the project's `.claude/settings.json`. Install: `claude plugin marketplace add MomSesImSpcl/Unity-Performance`, then `claude plugin install unity-perf@gqy-plugins`.
- Codex: install it from the Codex plugin manager. Don't run Claude Code plugin commands.

# Small increments
Split Unity/C# work into the smallest increments that can each be built, compiled and checked (tests, console errors, Play Mode where relevant) within one session; never a whole feature in one large pass. Verify each increment before the next, stop at the first failed check, and confirm direction with me before costly or hard-to-reverse work (scene or prefab restructuring, asset reimports, package changes).
Why: a large one-shot attempt can use a big share of the daily token budget before anyone learns it failed or needs changes; small increments fail cheaply and early. Tokens aren't a hard limit, but keep every scope as small as the need allows.
