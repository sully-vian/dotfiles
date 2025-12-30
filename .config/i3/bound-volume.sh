#!/usr/bin/env bash

# This script uses pactl to watch for changes in the volume and mute status
# and signals i3blocks to update the volume block

current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')

if [  "$current_volume" -lt 100 ]; then
  pactl set-sink-volume @DEFAULT_SINK@ +1%;
fi
