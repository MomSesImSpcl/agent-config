#!/bin/bash
# SessionStart hook: fast-forward ~/.claude from the rules repo, at most once per 6h.
cd "$HOME/.claude" || exit 0
if [ ! -d .git ]; then
  echo "Claude config repo not set up here. Clone https://github.com/MomSesImSpcl/claude-config into ~/.claude (see its README)."
  exit 0
fi
# Older clones only un-ignore the original root files; let rules/ and setup/ through.
for p in '!rules/' '!rules/**' '!setup/' '!setup/**'; do
  grep -qxF "$p" .git/info/exclude 2>/dev/null || echo "$p" >> .git/info/exclude
done
command -v rtk >/dev/null || echo "rtk is not installed on this machine, but rules/rtk.md expects it. Tell the user to follow ~/.claude/setup/rtk.md."
grep -q '"ponytail@ponytail": true' settings.json 2>/dev/null || echo "The Ponytail plugin is not installed on this machine. Tell the user to follow ~/.claude/setup/ponytail.md."
grep -q '"caveman@caveman": true' settings.json 2>/dev/null || echo "Caveman is not installed on this machine. Tell the user to follow ~/.claude/setup/caveman.md."
grep -q '"cache-tax@claude-code-mods": true' settings.json 2>/dev/null || echo "The Cache Tax plugin is not installed on this machine. Tell the user to follow ~/.claude/setup/cache-tax.md."
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
