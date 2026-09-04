#!/usr/bin/bash

sel="$(lsblk -lnf -o NAME,FSTYPE,FSSIZE,MOUNTPOINT,LABEL,TYPE | grep -v -E 'swap|disk' | sed 's/part//' | sed 's,^,/dev/,' | rofi -dmenu -no-custom -sep '\n' -p 'Mount partition')" 

[ $? -ne 0 ] && exit 1

if ! sudo -n true && ! rofi -dmenu -password -l 0 -p "enter password" | sudo -Sv; then
    notify-send "Wrong password"
    exit 2
fi

device="$(echo $sel | awk '{print $1}')"
mpoint="$(findmnt -n -o TARGET $device)"

if [ $? -eq 0 ]; then
    sudo umount $mpoint
else
    mpoint="$(find /mnt -mount -maxdepth 1 -type d -empty | rofi -dmenu -p 'Enter mountpoint')"
    [ $? -eq 0 ] && sudo mount --mkdir $device $mpoint || exit 3
fi

[ $? -ne 0 ] && notify-send "Failed" || notify-send "success"
