#!/usr/bin/env sh

set -euo pipefail

if [ "$#" -ne 2 ]; then
    printf "Usage:\n"
    printf "\t%s <WM_CLASS> <launch_command>\n\n" "$0"
    printf "<WM_CLASS>       : the WM_CLASS of the app window to focus\n"
    printf "<launch_command> : the command to launch the app if nwindow not found\n"
    exit 1
fi

app_class="$1"
cmd="$2"

# if window is not found, launch app
if ! win_id=$(xdotool search --class "$app_class" | tail -n1); then
    exec $cmd
fi

# Get workspace of the window
ws=$(i3-msg -t get_tree | "$XDG_CONFIG_HOME/i3/find-workspace.py" "$win_id")

# if workspace is invalid, launcha app
if [ "$ws" = "-1" ]; then
    exec $cmd
fi

i3-msg workspace "$ws"           # focus workspace
xdotool windowactivate "$win_id" # focus window
