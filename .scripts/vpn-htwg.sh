#!/bin/bash

if pgrep openvpn >/dev/null; then
    echo "disconnecting..."
    sudo pkill openvpn
    exit
fi

# where to store the config
TEMP_FILE=$(mktemp)

# where to get it
URL="https://www.htwg-konstanz.de/fileadmin/pub/ou/rz/VPN/HTWG-MFA-WS2526-STUD.ovpn"

echo "Connecting..."
echo "curling config file into $TEMP_FILE..."

# curl the config
curl -o "$TEMP_FILE" $URL

echo -e "\e[4m\e[1mPassword is usual password + code from Duo mobile \033[0m"
# start openvpn in background
sudo openvpn --config "$TEMP_FILE" --daemon

sleep 3

# Check if openvpn is running
if pgrep openvpn >/dev/null; then
    echo "VPN connected successfully (running in background)"
else
    echo "VPN connection failed"
fi

# remove the config file
echo "removing $TEMP_FILE"
rm "$TEMP_FILE"
