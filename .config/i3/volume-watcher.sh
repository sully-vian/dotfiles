#!/usr/bin/env sh

set -euo pipefail

# This script uses pw-mon to watch for changes in the volume and mute status
# and signals i3blocks to update the volume block

if pgrep -f "pw-mon"; then
    pkill -f "pw-mon"
fi

pw-mon | grep --line-buffered "node.name" | while read -r _; do
    pkill -SIGRTMIN+10 i3blocks # signal i3blocks to update the volume block
done
