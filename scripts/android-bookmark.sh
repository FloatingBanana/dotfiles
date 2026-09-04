#!/usr/bin/bash

FIFONAME="$HOME/.config/qutebrowser/bookmarks/android-tabs"
IP="192.168.0.112"

if [ -p $FIFONAME ]; then
    notify-send "Removing android-tabs fifo"
    pkill -f $0
    exit 1
fi

if pgrep adb; then
        notify-send "Adb server already running"
else
    adb start-server
    adb tcpip 55555
    notify-send "Started adb server"
fi

if adb devices | grep $IP; then
    echo "Already connected"
else
    set -e
    set -o pipefail

    adb connect "$IP:$(nmap $IP -n -T4 -max-rtt-timeout 200ms -Pn -p 30000-49999 | grep '/tcp open' | sed 's/\/.*//')"
    adb forward tcp:9222 localabstract:chrome_devtools_remote
    notify-send "Connected to chrome"
fi

notify-send "Creating android-tabs fifo"
mkfifo $FIFONAME
trap "rm $FIFONAME" EXIT HUP INT TERM

while curl "http://localhost:9222/json/list" | jq -r ".[] | \"\(.url) \(.title)\"" >> $FIFONAME; do
    echo Looped
    sleep 1
    done
