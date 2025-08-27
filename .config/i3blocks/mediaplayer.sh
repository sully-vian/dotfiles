#!/bin/bash

# This script is used in the i3blocks bar to display the current status of the music player.
# Clicking on the block will play/pause the music.
# It uses `playerctl` to fetch the status and metadata (artist and title) of the currently playing track.
# Depending on the status (Playing, Paused, or Stopped), it outputs the appropriate icon and metadata.

status=$(playerctl status 2>/dev/null)
metadata="$(playerctl metadata --format "{{artist}} - {{title}}" 2>/dev/null)"

# Replace "&" with "&amp;" to avoid issues with Pango markup
metadata=$(echo "$metadata" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')

if [ "$status" = "Playing" ]; then
    output="<i><b>$metadata</b></i> 󰐊"
elif [ "$status" = "Paused" ]; then
    output="<i><b>$metadata</b></i> 󰏤"
else
    output="󰓛"
fi

echo "$output"

case "$BLOCK_BUTTON" in
    1) playerctl play-pause ;; # left click
    4) playerctl next ;; # scroll up
    5) playerctl previous ;; # scroll down
esac
