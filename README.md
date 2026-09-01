# Second Brain

**A private, git-backed memory for Claude Code that ships already knowing how to work.**

Stop re-explaining your stack every session. Second Brain comes pre-loaded with a curated pack of working practices, then maps your repos and your meetings into plain Markdown that Claude reads at the start of every session. You just build.

> Status: early and open. The install script and practices pack work today. `/brain-bootstrap` and `/brain-update` are Claude Code commands you run inside a session. Meeting ingest and the dashboard are on the roadmap below.

---

## Two clicks

**1. Install** (comes loaded with 40+ practices)

```bash
git clone https://github.com/goalmada/second-brain.git
bash second-brain/install-second-brain.sh
```

**2. Seed it from your machine** — open Claude Code and run:

```
/brain-bootstrap
```

That fans out subagents across your repos and git history, then organizes what they find into a real, linked brain with an index. Read-only, start to finish.

Keep it current any time with `/brain-update`.

---

## What lands on disk

Plain Markdown, Obsidian-compatible, in a private git repo you own. No database, no lock-in.

```
~/.claude/brain/
├─ CLAUDE.md      # the router, loaded every session
├─ index.md       # where everything lives
├─ practices/     # the shared pack, refreshed by /brain-update
├─ projects/      # one file per project: stack, urls, deploys
├─ references/    # infra, services, auth, databases
├─ meetings/      # calls turned into summaries and tasks
├─ decisions/     # a log of what you decided and why
├─ tasks.md       # the board a dashboard can read
└─ staging/       # new notes waiting for your review
```

## The practices pack

Curated habits that make Claude sharper, packaged so you never have to think about prompting:

- Lead with the action
- One idea per sentence
- Verify before you say done
- Explore before you commit
- Capture decisions live
- No workarounds, only real fixes

Each is one plain rule in [`practices/`](practices/). Edit them freely — your changes are never overwritten by an update.

## What it will never do

- **Read-only audit.** The seed pass reads and summarizes. It never edits your code, touches production, or runs your programs.
- **Never stores secrets.** It records where a key lives (the store or env var name), never the value. The brain holds no raw credentials.
- **Stays on your machine.** Plain files in a private repo you control. Nothing leaves without your `git push`.

## Roadmap

- [ ] `/brain-bootstrap` packaged as a one-command audit workflow
- [ ] Fathom meeting auto-ingest into `meetings/`
- [ ] A task/priority dashboard that reads `tasks.md`
- [ ] One-line remote installer

## Preview

The landing page lives in [`docs/index.html`](docs/index.html).

## License

MIT. See [LICENSE](LICENSE).
