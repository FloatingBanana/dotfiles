#!/usr/bin/bash

case "$(echo 'Reboot|Shutdown|Shutdown after|Cancel shutdown' | rofi -dmenu -no-custom -l 4 -sep '|' -p 'Choose')" in
	Reboot)
		reboot
		;;
	Shutdown)
		shutdown now
		;;
	"Shutdown after")
		time="$(echo "30 min|60 min|90 min" | rofi -dmenu -l 3 -sep '|' -p 'Shutdown after')"
		
		if [[ -n "$time" ]]; then
			shutdown "+${time%% min}"
			notify-send "Shutting down after $time"
		fi
		;;
	"Cancel shutdown")
			shutdown -c && notify-send "Shutdown cancelled"
		;;
esac
