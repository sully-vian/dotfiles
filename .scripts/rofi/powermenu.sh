#!/usr/bin/env bash

# power menu script using rofi

# options
shutdown=" Shutdown"
reboot=" Reboot"
lock=" Lock"
suspend=" Suspend"
logout="󰗽 Logout"

# options combined
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

# selected option
selected=$(echo -e "$options" | rofi -dmenu -p "Power Menu")

# action
case $selected in
"$shutdown")
    systemctl poweroff
    ;;
"$reboot")
    systemctl reboot
    ;;
"$lock")
    sleep 0.4;
    "$HOME/.config/i3/i3lock-color.sh"
    ;;
"$suspend")
    systemctl suspend
    ;;
"$logout")
    i3-msg exit
    ;;
esac
