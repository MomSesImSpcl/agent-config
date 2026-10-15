#!/bin/bash
# SessionStart hook: fast-forward ~/.claude from the rules repo, at most once per 6h.
cd "$HOME/.claude" || exit 0
if [ ! -d .git ]; then
  echo "Global rules repo not set up here. Clone https://github.com/MomSesImSpcl/claude-global-rules into ~/.claude (see its README)."
  exit 0
fi
command -v rtk >/dev/null || echo "rtk is not installed on this machine, but RTK.md expects it. Tell the user to run: winget install rtk-ai.rtk, then rtk init -g (answer y), then restart Claude Code. See ~/.claude/README.md step 5."
grep -q '"ponytail@ponytail": true' settings.json 2>/dev/null || echo "The Ponytail plugin is not installed on this machine. Tell the user to follow ~/.claude/README.md step 6."
grep -q '"caveman@caveman": true' settings.json 2>/dev/null || echo "Caveman is not installed on this machine. Tell the user to follow ~/.claude/README.md step 7."
stamp=.git/last-sync
now=$(date +%s)
last=$(cat "$stamp" 2>/dev/null || echo 0)
[ $((now - last)) -lt 21600 ] && exit 0
timeout 15 git fetch -q origin 2>/dev/null || exit 0
echo "$now" > "$stamp"
[ "$(git rev-parse HEAD)" = "$(git rev-parse '@{u}')" ] && exit 0
if [ -n "$(git status --porcelain)" ] || [ -n "$(git log '@{u}..HEAD' --oneline)" ]; then
  echo "Global rules differ from GitHub but local changes/unpushed commits exist; not pulling. Resolve in ~/.claude."
  exit 0
fi
git merge -q --ff-only '@{u}' 2>/dev/null && echo "Global rules updated from GitHub; changes apply from the next session."
