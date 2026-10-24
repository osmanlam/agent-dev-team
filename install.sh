#!/usr/bin/env bash
# Agent Dev Team installer — copies the 16 agent definitions into your CLI's agents directory.
# Usage:
#   ./install.sh                  -> .claude/agents/ in the current project
#   ./install.sh --global         -> ~/.claude/agents/
#   ./install.sh --zcode          -> .zcode/agents/ in the current project
#   ./install.sh --zcode-global   -> ~/.zcode/agents/
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SCRIPT_DIR/agents"

TARGET=""
case "${1:-}" in
  "")            TARGET=".claude/agents" ;;
  --global)      TARGET="$HOME/.claude/agents" ;;
  --zcode)       TARGET=".zcode/agents" ;;
  --zcode-global) TARGET="$HOME/.zcode/agents" ;;
  *) echo "Unknown option: $1"; echo "Usage: ./install.sh [--global | --zcode | --zcode-global]"; exit 1 ;;
esac

if [ ! -d "$SRC" ]; then
  echo "ERROR: agents/ folder not found next to install.sh (is the kit intact?)"
  exit 1
fi

# Back up an existing agents directory instead of clobbering it.
if [ -d "$TARGET" ] && [ -n "$(ls -A "$TARGET" 2>/dev/null)" ]; then
  BACKUP="${TARGET}.bak-$(date +%Y%m%d-%H%M%S)"
  echo "Existing agents found — backing up to $BACKUP"
  cp -R "$TARGET" "$BACKUP"
fi

mkdir -p "$TARGET"
cp "$SRC"/*.md "$TARGET"/

COUNT=$(ls "$SRC"/*.md | wc -l | tr -d ' ')
echo ""
echo "Installed $COUNT agents into: $TARGET"
echo ""
echo "Next steps:"
echo "  1. Restart your CLI session so the agents are picked up."
echo "  2. Optional: turn on the two-tier model setup — see PLAYBOOK.md section 5."
echo "  3. Start with the team-lead agent for your first vague request and watch it plan."
