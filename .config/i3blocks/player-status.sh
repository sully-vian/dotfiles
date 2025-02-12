#!/bin/bash

# This script is used in the i3blocks bar to display the current status of the music player.
# It uses `playerctl` to fetch the status and metadata (artist and title) of the currently playing track.
# Depending on the status (Playing, Paused, or Stopped), it outputs the appropriate icon and metadata.

status=$(playerctl status 2>/dev/null)
metadata="<i><b>$(playerctl metadata --format "{{artist}} - {{title}}" 2>/dev/null)</b></i>"

if [ "$status" = "Playing" ]; then
    echo "▶️ $metadata"
elif [ "$status" = "Paused" ]; then
    echo "⏸️ $metadata"
else
    echo "⏹️"
fi
