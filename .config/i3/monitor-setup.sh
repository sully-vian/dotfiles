#!/usr/bin/env bash

# This script is called by i3 config to setup the monitors
# no monitor connected: laptop screen is primary and workspace 1.
# monitor connected: monitor is primary and workspace 1.

hostname=$(hostname)

if [[ "$hostname" == "archaic" ]]; then
    right_monitor="eDP1"
    left_monitor="HDMI1"
elif [[ "$hostname" == "remy" ]]; then
    right_monitor="VGA1"
    left_monitor="DP1"
fi

if xrandr | grep "$left_monitor connected"; then
    # external monitor is connected
    xrandr --output $left_monitor --primary --left-of $right_monitor --auto
    i3-msg "workspace 1; move workspace to output $left_monitor"
    i3-msg "workspace 2; move workspace to output $right_monitor"
else
    # only laptop monitor
    xrandr --output $right_monitor --primary --auto --rate 60
    xrandr --output $left_monitor --off
    for i in {1..10}; do
        i3-msg "workspace $i; move workspace to output $right_monitor" 2>/dev/null
    done
fi

# focus the first workspace
i3-msg workspace 1
