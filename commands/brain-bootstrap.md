---
description: Seed your second brain by auditing your repos and folders
---

You are seeding the user's second brain at `~/.claude/brain`. This is a READ-ONLY audit.

Steps:
1. Discover the user's work: list git repos under their common code folders and their recent git activity. Do not read secret values; if you find a credential, record only where it lives (the store or env var name).
2. Fan out: for each repo or major folder, spawn a subagent that skims structure, recent commits, and open work, and returns a short structured summary. Use a fast model for these readers and run them in parallel.
3. Synthesize: dedupe the reports, cluster by project, and write one linked note per project into `~/.claude/brain/projects/`. Add infra and services to `~/.claude/brain/references/`.
4. Build `~/.claude/brain/index.md` so future sessions know where everything lives.
5. Never edit the user's code, touch production, or run their programs. Summaries only.

Report what you mapped and what you skipped. Leave anything uncertain in `staging/` for review.
