# Command output

Command output is condensed to save tokens; every signal is kept. Treat it as the complete result: run commands normally, and batch related commands into one call to avoid extra turns. Truncated results name their own recovery path. Re-run a command as `rtk proxy <cmd>` only when its result is unusable: empty when output was clearly expected, contradicting its exit code, or garbled.
