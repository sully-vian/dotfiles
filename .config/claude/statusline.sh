#!/usr/bin/env sh

set -euo pipefail

INPUT="$(cat)"
MODEL="$(echo "$INPUT" | jq -r '.model.display_name')"
DIR="$(echo "$INPUT" | jq -r '.workspace.current_dir')"
CTX="$(echo "$INPUT" | jq -r '.context_window.used_percentage')"
BRANCH="$(git -C "$DIR" branch --show-current 2>/dev/null || true)"

out="$MODEL · ${DIR##*/}"
[ -n "$BRANCH" ] && out="$out · $BRANCH"
[ -n "$CTX" ] && out="$out · $CTX%"
printf "%s" "$out"
