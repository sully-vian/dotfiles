#!/bin/bash

network_name=$(nmcli -t -f active,ssid dev wifi | grep '^yes'|cut -d':' -f2)
ip=$(wget -qO- https://ipv4.icanhazip.com/)

light_blue="#00FFFF"

echo "<span color='$light_blue'><b>$network_name</b>-$ip</span>"
