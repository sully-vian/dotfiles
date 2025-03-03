#!/bin/bash

# This script generates the pango text needed to display the current volume level

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

if [[ -n "${BLOCK_BUTTON}" ]]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
fi