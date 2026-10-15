#!/bin/bash
# SessionStart hook: safely fast-forward the shared rules repo, then sync Codex's global copies.
set +e
REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_ROOT" || exit 0
CODEX_DIR="${CODEX_HOME:-$HOME/.codex}"

sync_codex_files() {
  [ -d "$CODEX_DIR" ] || mkdir -p "$CODEX_DIR" || return 1
  for file in AGENTS.md SHARED.md; do
    if [ -f "$file" ] && ! cmp -s "$file" "$CODEX_DIR/$file"; then
      cp "$file" "$CODEX_DIR/$file.tmp" && mv "$CODEX_DIR/$file.tmp" "$CODEX_DIR/$file" || return 1
    fi
  done
  # rules/unity.md is both Claude's path-scoped rule and Codex's on-demand skill.
  target="$CODEX_DIR/skills/unity-csharp/SKILL.md"
  if [ -f rules/unity.md ] && ! cmp -s rules/unity.md "$target"; then
    mkdir -p "$(dirname "$target")" && cp rules/unity.md "$target.tmp" && mv "$target.tmp" "$target" || return 1
  fi
}

# Allows an agent to refresh the generated Codex-home copies after editing rules.
if [ "${1:-}" = "--sync-only" ]; then
  sync_codex_files
  exit $?
fi

command -v rtk >/dev/null || echo "rtk is not installed on this machine, but rules/rtk.md expects it. Tell the user to follow ~/.claude/setup/rtk.md."
grep -q '"ponytail@ponytail": true' settings.json 2>/dev/null || echo "The Ponytail plugin is not installed on this machine. Tell the user to follow ~/.claude/setup/ponytail.md."
grep -q '"caveman@caveman": true' settings.json 2>/dev/null || echo "Caveman is not installed on this machine. Tell the user to follow ~/.claude/setup/caveman.md."
grep -q '"cache-tax@claude-code-mods": true' settings.json 2>/dev/null || echo "The Cache Tax plugin is not installed on this machine. Tell the user to follow ~/.claude/setup/cache-tax.md."

if [ ! -d .git ]; then
  echo "Claude config repo not set up here. Clone https://github.com/MomSesImSpcl/claude-config into ~/.claude (see its README)."
  sync_codex_files
  exit 0
fi
# Compatibility for older clones that ignore all but the original root files.
for p in '!LICENSE' '!rules/' '!rules/**' '!setup/' '!setup/**' '!AGENTS.md' '!SHARED.md' '!sync-rules.ps1'; do
  grep -qxF "$p" .git/info/exclude 2>/dev/null || echo "$p" >> .git/info/exclude
done
stamp=.git/last-sync
now=$(date +%s)
last=$(cat "$stamp" 2>/dev/null || echo 0)
if [ $((now - last)) -ge 21600 ]; then
  if timeout 15 git fetch -q origin 2>/dev/null; then
    echo "$now" > "$stamp"
    if [ "$(git rev-parse HEAD 2>/dev/null)" != "$(git rev-parse '@{u}' 2>/dev/null)" ]; then
      if [ -n "$(git status --porcelain)" ] || [ -n "$(git log '@{u}..HEAD' --oneline 2>/dev/null)" ]; then
        echo "Global rules differ from GitHub but local changes/unpushed commits exist; not pulling. Resolve in ~/.claude."
      elif git merge -q --ff-only '@{u}' 2>/dev/null; then
        echo "Global rules updated from GitHub; changes apply from the next session."
      fi
    fi
  fi
fi
sync_codex_files