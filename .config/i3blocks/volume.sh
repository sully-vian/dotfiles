#!/bin/bash

vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')

# set the icon to the corresponding level (high, medium, low)
if [ $vol -ge 50 ]; then
    icon="󰕾"
elif [ $vol -ge 25 ]; then
    icon="󰖀"
else
    icon="󰕿"
fi

echo "$icon $vol%"

if [[ -n "${BLOCK_BUTTON}" ]]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
fi