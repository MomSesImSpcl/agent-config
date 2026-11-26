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
  // Message hooks get no effort field; the transcript records it on each assistant entry.
  if (!level && data.transcript_path) {
    try {
      const tail = fs.readFileSync(data.transcript_path, 'utf8').slice(-500000);
      const hits = [...tail.matchAll(/"effort":"(\w+)"/g)];
      if (hits.length) level = hits[hits.length - 1][1] + ' (as of the last reply)';
    } catch (e) {}
  }
  level = level || process.env.CLAUDE_EFFORT || 'unknown, check with get_session(self)';
  console.log(`Effort check: before acting on a new request, follow the CLAUDE.md effort-suggestion rule. Current effort: ${level}.`);
});
