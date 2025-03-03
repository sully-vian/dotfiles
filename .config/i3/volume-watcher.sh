#!/bin/bash

# This script uses pactl to watch for changes in the volume and mute status
# and signals i3blocks to update the volume block

pactl subscribe | grep --line-buffered "sink #" | while read -r _; do
    pkill -SIGRTMIN+10 i3blocks
done
