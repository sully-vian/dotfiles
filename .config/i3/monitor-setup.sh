#!/bin/bash

# This script is called by i3 config to setup the monitors
# no monitor connected: laptop screen is primary and workspace 1.
# monitor connected: monitor is primary and workspace 1.

external_monitor="HDMI1"
laptop_monitor="eDP1"

if xrandr | grep "$external_monitor connected"; then
    # external monitor is connected
    xrandr --output $external_monitor --primary --left-of $laptop_monitor --auto
else
    # only laptop monitor
    xrandr --output $laptop_monitor --primary --auto
fi
