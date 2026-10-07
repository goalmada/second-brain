#!/usr/bin/env bash
# Codex subagents for Claude Code, billed to your ChatGPT subscription (not the API).
# Safe and idempotent. Run it again any time.
# It never reads or writes secrets. Sign-in happens in your browser via `codex login`.
set -euo pipefail

CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
CONFIG="$CODEX_HOME/config.toml"

say(){ printf "\033[38;5;33m›\033[0m %s\n" "$1"; }
die(){ printf "\033[31m✗\033[0m %s\n" "$1" >&2; exit 1; }

command -v node >/dev/null || die "Node.js 18.18+ is required."
command -v claude >/dev/null || die "Claude Code CLI not found. Install it first."

# 1. The Codex CLI.
if ! command -v codex >/dev/null; then
  say "Installing the Codex CLI"
  npm install -g @openai/codex
fi

# 2. Lock Codex to ChatGPT sign-in so usage hits your subscription, never API credits.
mkdir -p "$CODEX_HOME"
touch "$CONFIG"
if grep -q '^forced_login_method' "$CONFIG"; then
  sed -i.bak 's/^forced_login_method.*/forced_login_method = "chatgpt"/' "$CONFIG" && rm -f "$CONFIG.bak"
else
  # Top-level keys must come before any [table], so prepend.
  { echo 'forced_login_method = "chatgpt"'; cat "$CONFIG"; } > "$CONFIG.tmp" && mv "$CONFIG.tmp" "$CONFIG"
fi
say "Codex locked to ChatGPT subscription sign-in ($CONFIG)"

# 3. OpenAI's official Codex plugin for Claude Code (adds the codex-rescue subagent).
claude plugin marketplace add openai/codex-plugin-cc >/dev/null
claude plugin install codex@openai-codex >/dev/null
say "Installed the codex plugin for Claude Code"

# 4. Sign in with ChatGPT if needed.
if codex login status 2>/dev/null | grep -qi 'chatgpt'; then
  say "Already signed in to Codex with ChatGPT"
else
  say "Signing in to Codex with your ChatGPT account"
  # No local browser (SSH, headless Linux, cloud container) -> device-code login.
  headless=false
  [ -n "${SSH_CONNECTION:-}" ] && headless=true
  [ "$(uname)" != "Darwin" ] && [ -z "${DISPLAY:-}${WAYLAND_DISPLAY:-}" ] && headless=true
  if $headless; then
    codex login --device-auth
  else
    codex login
  fi
fi

echo
say "Done. In Claude Code, run /reload-plugins then /codex:setup to verify."
echo
echo "Use it:"
echo "  /codex:rescue <task>     hand a task to a Codex subagent"
echo "  /codex:review            Codex reviews your current diff"
echo "  /codex:status, /codex:result   check background Codex jobs"
echo "  Or just ask Claude to \"delegate this to Codex\"."
