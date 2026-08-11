#!/usr/bin/env bash

set -euo pipefail

cmd="$1"
session="popup-${cmd%% *}"

tmux new-session -d -A -s "$session" -c "$PWD" "$cmd"
tmux set-option -t "$session" status off
tmux attach-session -t "$session"
