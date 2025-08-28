#!/bin/bash

# Select PulseAudio sinks with rofi and combine them into one.
# Unloads any previous combined sink before creating a new one.

command -v pactl >/dev/null 2>&1 || { echo "pactl not found!"; exit 1; }
command -v rofi >/dev/null 2>&1 || { echo "rofi not found!"; exit 1; }

# unload existing combine sinks (to avoid duplicates)
existing_combines=$(pactl list short modules | grep "module-combine-sink" | awk '{print $1}')

for module in $existing_combines; do
    pactl unload-module "$module"
    echo "Unloaded existing combined sink module: $module"
done

sinks=$(pactl list sinks | awk '/Name: /{name=$2} /Description: /{print name "|" substr($0, index($0,$2))}')

selected_sinks=$(echo "$sinks" | awk -F'|' '{print $2 "|" $1}' | cut -d'|' -f1 | rofi -dmenu -multi-select -p "Select sinks to combine (Shift+Enter)")

if [ -z "$selected_sinks" ]; then
    echo "No sinks selected."
    exit 1
fi

sink_names=$(echo "$sinks" | grep -Ff <(echo "$selected_sinks" | awk -F'|' '{print $1}') | awk -F'|' '{print $1}')

# echo -e "Selected sinks: \n$selected_sinks"
# echo -e "Sink names to combine: \n$sink_names"

# add commas between sink names
sink_names_list=$(echo "$sink_names" | tr '\n' ',')
num_sinks=$(echo "$sink_names" | wc -l)

echo -e "\nCombining sinks:\n$sink_names\n"

new_sink_num=$(pactl load-module module-combine-sink sink_name=combined slaves="$sink_names_list" sink_properties=device.description="Combined($num_sinks)")

echo -e "module number: $new_sink_num\n"

echo -e "Combined:\n$selected_sinks"
