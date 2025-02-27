#!/bin/bash

# Get the battery percentage
battery_percentage=$(acpi -b | grep -P -o '[0-9]+(?=%)')
charging=$(acpi -b | grep -o "Charging")

# Determine color based on battery percentage
if [ "$battery_percentage" -ge 75 ]; then
    color="#00FF00"  # Green
elif [ "$battery_percentage" -ge 50 ]; then
    color="#FFFF00"  # Yellow
elif [ "$battery_percentage" -ge 25 ]; then
    color="#FFA500"  # Orange
else
    color="#FF0000"  # Red
fi

if [ "$charging" == "Charging" ]; then
    icon="󰂄"
else
    icon="󰁹"
fi

# Output the battery percentage with pango
echo "<span color='$color'>$icon $battery_percentage%</span>"
