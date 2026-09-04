#!/usr/bin/bash

CONFS=/etc/openvpn/client

if ! sudo -n true && ! rofi -dmenu -password -l 0 -p "enter password" | sudo -Sv; then
    notify-send "Wrong password"
    exit 2
fi

if pgrep openvpn >> /dev/null; then
    sudo pkill openvpn
    notify-send "VPN disabled"
    exit 0
fi

file="$(sudo ls --ignore=client.conf $CONFS | rofi -dmenu -no-custom -ṕ 'Select config')"
[ $? -ne 0 ] && exit 1

sudo openvpn "$CONFS/$file" &
notify-send "VPN enabled"
