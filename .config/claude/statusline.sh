#!/usr/bin/env sh

set -euo pipefail

# TODO: change to multiple jq calls for cleaner code
eval "$(jq -r '
    @sh "MODEL=\(.model.display_name)",
    @sh "DIR=\(.workspace.current_dir)",
    @sh "CTX=\(.context_window.used_percentage | if . == null then "" else floor | tostring end)"
')"

BRANCH="$(git -C "$DIR" branch --show-current 2>/dev/null || true)"

out="$MODEL · ${DIR##*/}"
[ -n "$BRANCH" ] && out="$out · $BRANCH"
[ -n "$CTX" ] && out="$out · $CTX%"
printf "%s" "$out"
