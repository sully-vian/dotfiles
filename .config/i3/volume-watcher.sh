#!/usr/bin/env bash

# This script uses pw-mon to watch for changes in the volume and mute status
# and signals i3blocks to update the volume block

pkill -f "pw-mon"

pw-mon | grep --line-buffered "node.name" | while read -r _; do
    pkill -SIGRTMIN+10 i3blocks # signal i3blocks to update the volume block
done
