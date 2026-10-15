---
name: unity-csharp
description: Use when working on Unity or C# code, including .cs scripts, .asmdef assemblies, .unity scenes, .prefab files and ProjectSettings.
paths: ["**/*.cs", "**/*.asmdef", "**/*.unity", "**/*.prefab", "**/ProjectSettings/**"]
---

# Unity / C# performance skills
When working on Unity or C# code, use the Unity Performance plugin skills (`unity-performance`, `csharp-zero-gc`, `code-standards`) when available. If they are not, remind me once per session, in one line, to install the plugin (https://github.com/MomSesImSpcl/Unity-Performance). Don't install it yourself.
- Claude Code: it is enabled when `"unity-perf@gqy-plugins": true` is in `~/.claude/settings.json` or the project's `.claude/settings.json`. Install with `claude plugin marketplace add MomSesImSpcl/Unity-Performance` then `claude plugin install unity-perf@gqy-plugins`.
- Codex: install it from the Codex plugin manager. Don't run Claude Code plugin commands.

