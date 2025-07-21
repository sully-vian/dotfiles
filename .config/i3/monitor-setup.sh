#!/bin/bash

# This script is called by i3 config to setup the monitors
# no monitor connected: laptop screen is primary and workspace 1.
# monitor connected: monitor is primary and workspace 1.

external_monitor="HDMI1"
laptop_monitor="eDP1"

if xrandr | grep "$external_monitor connected"; then
    # external monitor is connected
    xrandr --output $external_monitor --primary --left-of $laptop_monitor --auto
    i3-msg "workspace 1; move workspace to output $external_monitor"
    i3-msg "workspace 2; move workspace to output $laptop_monitor"
else
    # only laptop monitor
    xrandr --output $laptop_monitor --primary --auto
    xrandr --output $external_monitor --off
    for i in {1..10}; do
        i3-msg "workspace $i; move workspace to output $laptop_monitor" 2>/dev/null
    done
fi

# focus the first workspace
i3-msg workspace 1
