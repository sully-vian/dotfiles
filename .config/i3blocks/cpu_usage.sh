#!/usr/bin/env bash

# Get the CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

# Convert CPU usage to an integer
cpu_usage_int=$(printf "%.0f" $cpu_usage)

# Determine color based on CPU usage
if (($(echo "$cpu_usage_int < 50" | bc -l))); then
    color="#00FF00" # Green
elif (($(echo "$cpu_usage_int < 75" | bc -l))); then
    color="#FFFF00" # Yellow
else
    color="#FF0000" # Red
fi

# Output the CPU usage with pango
echo "<span color='$color'>CPU: $cpu_usage_int%</span>"
