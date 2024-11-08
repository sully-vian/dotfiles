#!/bin/bash

vpn7() {
    if pgrep vpnc >/dev/null; then
        echo "disconnecting..."
        sudo vpnc-disconnect
    else
        echo "Connecting..."
        echo -e "Check \033[32mDuo mobile\033[0m"
        sudo vpnc ~/.scripts/.n7-vpn.conf
    fi
}
