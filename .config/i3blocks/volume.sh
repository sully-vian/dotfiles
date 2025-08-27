#!/bin/bash

# This script generates the pango text needed to display the current volume level
# left clicking the volume icon toggles mute
# right clicking opens a rofi audio output switcher
# scrolling up increases volume by 1%
# scrolling down decreases volume by 1%

vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')

mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

# set the icon to the corresponding level (high, medium, low)
if [ "$mute" = "yes" ]; then
    icon="󰝟"
elif [ "$vol" -ge 50 ]; then
    icon="󰕾"
elif [ "$vol" -ge 25 ]; then
    icon="󰖀"
else
    icon="󰕿"
fi

echo "$icon $vol%"

case "$BLOCK_BUTTON" in
    1) pactl set-sink-mute @DEFAULT_SINK@ toggle ;; # left click
    3) ~/.scripts/rofi/audio-output.sh ;; # right click
    4) pactl set-sink-volume @DEFAULT_SINK@ +1% ;; # scroll up
    5) pactl set-sink-volume @DEFAULT_SINK@ -1% ;; # scroll down
esac
