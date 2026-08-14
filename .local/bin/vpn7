#!/usr/bin/env bash

if pgrep vpnc >/dev/null; then
    echo "disconnecting..."
    sudo vpnc-disconnect
    exit
fi

echo "Connecting..."
echo -e "\e[4m\e[1mCheck Duo mobile\033[0m"
sudo vpnc ~/.vpn/n7-vpn.conf
