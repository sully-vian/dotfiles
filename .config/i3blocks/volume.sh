#!/usr/bin/env bash

# This script generates the pango text needed to display the current volume level
# left clicking the volume icon toggles mute
# right clicking opens a rofi audio output switcher
# scrolling up increases volume by 1%
# scrolling down decreases volume by 1%

base=$(wpctl get-volume @DEFAULT_SINK@)
vol=$(echo "$(echo "$base" | awk '{print $2}') * 100" | bc | cut -d'.' -f1)

mute=$(echo "$base" | awk '{print $3}')

# set the icon to the corresponding level (high, medium, low)
if [ "$mute" = "[MUTED]" ]; then
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
    1) wpctl set-mute @DEFAULT_SINK@ toggle ;; # left click
    3) ~/.scripts/rofi/audio-output.sh ;; # right click
    4) wpctl set-volume @DEFAULT_SINK@ 1%+ ;; # scroll up
    5) wpctl set-volume @DEFAULT_SINK@ 1%- ;; # scroll down
esac

current_volume=$(echo "$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $2}') * 100" | bc | cut -d'.' -f 1)

if [ "$current_volume" -gt 100 ]; then
    wpctl set-volume @DEFAULT_SINK@ 100%;
elif [ "$current_volume" -lt 0 ]; then
    wpctl set-volume @DEFAULT_SINK@ 0%;
fi
