#!/bin/bash

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
selected=$(echo -e $options | rofi -dmenu -p "Power Menu" -lines 5 -width 10 -padding 20)

# action
case $selected in
"$shutdown")
    systemctl poweroff
    ;;
"$reboot")
    systemctl reboot
    ;;
"$lock")
    i3lock -c 000000
    ;;
"$suspend")
    systemctl suspend
    ;;
"$logout")
    i3-msg exit
    ;;
esac
