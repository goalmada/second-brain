#!/usr/bin/env bash
# Second Brain installer. Safe and idempotent. Run it again any time.
# It never reads or writes secrets, and never overwrites your own notes.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BRAIN="${CLAUDE_BRAIN:-$HOME/.claude/brain}"
CMDS="$HOME/.claude/commands"

say(){ printf "\033[38;5;33m›\033[0m %s\n" "$1"; }

say "Installing your second brain into $BRAIN"
mkdir -p "$BRAIN" "$CMDS"

# 1. Seed the brain structure without clobbering anything you already have.
#    -n = never overwrite existing files.
cp -Rn "$SCRIPT_DIR/templates/brain/." "$BRAIN/" 2>/dev/null || true

# 2. The practices pack IS refreshed on install (this is the shared, curated layer).
mkdir -p "$BRAIN/practices"
cp -Rf "$SCRIPT_DIR/practices/." "$BRAIN/practices/"

# 3. Install the /brain-bootstrap and /brain-update commands for Claude Code.
cp -Rf "$SCRIPT_DIR/commands/." "$CMDS/"

# 4. Make the brain a git repo so it versions itself.
if [ ! -d "$BRAIN/.git" ]; then
  git -C "$BRAIN" init -q
  git -C "$BRAIN" add -A
  git -C "$BRAIN" commit -qm "Seed second brain" || true
  say "Initialized a git repo in $BRAIN"
fi

echo
say "Done. $(ls "$BRAIN/practices" | wc -l | tr -d ' ') practices loaded."
echo
echo "Next:"
echo "  1. Open Claude Code:            claude"
echo "  2. Seed it from your machine:   /brain-bootstrap"
echo "  3. Later, refresh the pack:     /brain-update"
