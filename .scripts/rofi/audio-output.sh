#!/usr/bin/env bash

# Get sink name and description pairs
sinks=$(pactl list sinks | awk '/Name: /{name=$2} /Description: /{print name "|" substr($0, index($0,$2))}')

# Show descriptions in rofi, keep technical name for switching
chosen=$(echo "$sinks" | awk -F'|' '{print $2 "|" $1}' | cut -d'|' -f1 | rofi -dmenu -p "Select audio output")

# Find the technical name for the chosen description
sink_name=$(echo "$sinks" | grep "|$chosen$" | awk -F'|' '{print $1}')

# If a sink was chosen, set it as the default sink
if [[ -n "$sink_name" ]]; then
    pactl set-default-sink "$sink_name"
fi
