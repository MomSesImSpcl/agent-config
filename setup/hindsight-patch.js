// Replaces Hindsight's per-message reminder with a shorter text of the same intent.
// Run after every Hindsight install or update: node ~/.claude/setup/hindsight-patch.js
// Keeps the original of each file as <file>.orig. See setup/hindsight.md.
const fs = require('fs');
const path = require('path');
const os = require('os');

const dist = path.join(os.homedir(), '.hindsight', 'coding-agents', 'dist');
const files = ['claude-hook.js', 'claude-sessionstart-hook.js'];

const TOOL_GUIDE = `- hindsight_search_pages(query): search FIRST, before acting, when a bug or wrong response is reported, you write or change a test, you build something new or fit parts together, the user asks why something is so or what is left, or you are about to commit. Code shows what is true now; memory shows what was decided and why. Use both. Results are ranked page openings: read the top page with hindsight_read_page before relying on it. Memory is a past record: check claims (fixed, passes, works) against the code, and say so when they disagree.
- Crediting is mandatory: if anything a Hindsight tool returned reaches your reply (quoted, paraphrased or only confirming), open that part with "> \u{1F9E0} **From Hindsight memory (<page>)** — <the facts used>". Nothing useful found: no mention.
- hindsight_list_pages / hindsight_read_page: before substantial work, read the relevant pages (architecture, conventions, decisions) instead of re-deriving them from code. Follow [[page:<id>]] links.
- hindsight_reflect(query): slow, deep reasoning over all memory, for the WHY behind a past decision or exact values. Credit it as "> \u{1F9E0} **From Hindsight memory** — <summary>".
- hindsight_capture_initiative(title, summary): when the user approves a plan or new feature, before writing code, record it. Call again with relates_to_page_id when the goal, scope or rationale materially changes. Skip bug fixes, tweaks and chores.
- hindsight_ingest_document(title, content): save an external document or durable notes. The conversation itself is saved automatically at session end.`;

const INDEX_LINE = 'return `${count} this repo (architecture, conventions, decisions, initiatives), not listed here: find them with hindsight_search_pages(query), read with hindsight_read_page(<id>).`;';
const HEADER = 'Hindsight memory tools for this repo:';

// --quiet (used by the sync scripts at session start): print only when something was patched or failed.
if (process.argv.includes('--quiet')) {
  const log = console.log;
  console.log = (msg) => { if (/^(done|FAIL)/.test(msg)) log('Hindsight reminder patch: ' + msg); };
}
let patched = 0;
for (const name of files) {
  const file = path.join(dist, name);
  if (!fs.existsSync(file)) { console.log(`skip ${name}: not found`); continue; }
  let src = fs.readFileSync(file, 'utf8');
  if (src.includes('Crediting is mandatory')) { console.log(`ok   ${name}: already patched`); continue; }
  const before = src;
  src = src.replace(/var TOOL_GUIDE = `[\s\S]*?`;\nvar PAGES_FIRST_ON_GOALS/, () => 'var TOOL_GUIDE = ' + JSON.stringify(TOOL_GUIDE) + ';\nvar PAGES_FIRST_ON_GOALS');
  src = src.replace(/(function indexLine\(pages\) \{\n[^\n]*\n)\s*return `\$\{count\} this repository[^\n]*/, (m, head) => head + '  ' + INDEX_LINE);
  src = src.replace("Reminder \\u2014 this repo's Hindsight tools are available; call them at the right moments:", HEADER);
  // The tool guide is in both files; the header and index line only where the reminder is built.
  if (src === before || src.includes('CREDITING IS NOT OPTIONAL')) {
    console.log(`FAIL ${name}: reminder text not found as expected; Hindsight changed it. Left unchanged.`);
    process.exitCode = 1;
    continue;
  }
  if (!fs.existsSync(file + '.orig')) fs.copyFileSync(file, file + '.orig');
  fs.writeFileSync(file, src);
  patched++;
  console.log(`done ${name}`);
}
console.log(`${patched} file(s) patched`);
