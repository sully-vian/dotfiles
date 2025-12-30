#!/usr/bin/env bash

# This script focuses an existing window with the specified WM_CLASS,
# or launches a new instance of the application if no such window is found.
#
# Usage:
#   focus-browser.sh <launch_command> <WM_CLASS>
#
# Arguments:
#   <launch_command> : Command to launch the application if not found
#   <WM_CLASS>       : The WM_CLASS of the application window to focus
#
# Example:
#   focus-browser.sh google-chrome-stable google-chrome
#
# The script:
#   1. Searches for a window with the given WM_CLASS.
#   2. If found, focuses its workspace and activates the window.
#   3. If not found, launches the application using the provided command.

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <WM_CLASS> <launch_command>"
    exit 1
fi

app_class="$1"
cmd="$2"

win_id=$(xdotool search --class "$app_class" | tail -n1)
echo "win_id: [$win_id]"

if [ -n "$win_id" ]; then
    # Get workspace of the window
    ws=$(i3-msg -t get_tree | ~/.config/i3/find-workspace.py "$win_id")
    if [ "$ws" != "-1" ]; then
        i3-msg workspace "$ws"
        xdotool windowactivate "$win_id"
        exit 0
    fi
fi

# If not found, launch the app
exec $cmd
