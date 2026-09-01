# Your second brain

This file is the router. Claude Code reads it at the start of every session.

## How to use this brain
- Read `index.md` first: it maps where everything lives.
- Follow the rules in `practices/` for how to work. They are pre-loaded and kept current with `/brain-update`.
- Project facts live in `projects/`. Infra and services in `references/`. Meetings in `meetings/`. Decisions in `decisions/`.
- New notes land in `staging/` for review. Run `/review-staging` to file them.

## Rules of the house
- Never store a raw secret value. Record where a key lives (the store or env var name), never the value.
- Keep one fact per file. Link related notes with [[wikilinks]].
- When something is decided, append it to `decisions/`.
