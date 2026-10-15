---
paths: ["**/*.cs", "**/*.asmdef", "**/*.unity", "**/*.prefab", "**/ProjectSettings/**"]
---

# Unity / C# performance skills

When working on Unity or C# code, use the Unity Performance plugin skills when available. In Claude Code, check for `"unity-perf@gqy-plugins": true` in `~/.claude/settings.json` or the project's `.claude/settings.json`. If they are not enabled, remind me once per session, in one line, to install the plugin, and give these commands:

```bash
claude plugin marketplace add MomSesImSpcl/Unity-Performance
claude plugin install unity-perf@gqy-plugins
```

It adds the `unity-performance`, `csharp-zero-gc` and `code-standards` skills. Don't install it yourself.