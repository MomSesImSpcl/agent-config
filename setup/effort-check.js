// UserPromptSubmit hook: reminds Claude of the effort rule and states the session's current effort level.
// See setup/effort-hook.md.
const fs = require('fs');

let input = '';
process.stdin.on('data', (c) => (input += c)).on('end', () => {
  let level;
  let data = {};
  try {
    data = JSON.parse(input);
    level = data.effort && data.effort.level;
  } catch (e) {}
  // Message hooks get no effort field. The desktop app's session record holds the live level and model.
  const rec = data.session_id ? fromAppRecord(data.session_id) : null;
  let model = rec && rec.model;
  if (!level && rec) level = rec.effort;
  // Otherwise the transcript records both on each assistant entry.
  if ((!level || !model) && data.transcript_path) {
    try {
      const tail = fs.readFileSync(data.transcript_path, 'utf8').slice(-500000);
      const last = (re) => { const h = [...tail.matchAll(re)]; return h.length ? h[h.length - 1][1] : null; };
      if (!level && last(/"effort":"(\w+)"/g)) level = last(/"effort":"(\w+)"/g) + ' (as of the last reply)';
      if (!model) model = last(/"model":"(claude-[\w.-]+)"/g);
    } catch (e) {}
  }
  level = level || process.env.CLAUDE_EFFORT || 'unknown, check with get_session(self)';
  model = model || 'unknown, check with get_session(self)';
  console.log(`Effort check: before acting on a new request, follow the CLAUDE.md effort-suggestion rule. Current effort: ${level}. Current model: ${model}.`);
});

// Desktop app on Windows: <LOCALAPPDATA>\Claude-Data\*\claude-code-sessions\*\*\local_*.json, matched by cliSessionId.
function fromAppRecord(sessionId) {
  const path = require('path');
  const root = path.join(process.env.LOCALAPPDATA || '', 'Claude-Data');
  const ls = (dir) => { try { return fs.readdirSync(dir).map((n) => path.join(dir, n)); } catch (e) { return []; } };
  const files = [];
  for (const account of ls(root))
    for (const a of ls(path.join(account, 'claude-code-sessions')))
      for (const b of ls(a)) for (const f of ls(b)) if (f.endsWith('.json')) files.push(f);
  // The active session's record was touched most recently; check newest first.
  const byAge = files.map((f) => { try { return [fs.statSync(f).mtimeMs, f]; } catch (e) { return [0, f]; } })
    .sort((x, y) => y[0] - x[0]).slice(0, 50);
  for (const [, f] of byAge) {
    try {
      const rec = JSON.parse(fs.readFileSync(f, 'utf8'));
      if (rec.cliSessionId === sessionId) return rec;
    } catch (e) {}
  }
}
