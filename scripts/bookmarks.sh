#!/usr/bin/sh

BMPATH="$HOME/.config/qutebrowser/bookmarks"
BMFILE="$BMPATH/$(ls $BMPATH | rofi -dmenu -p 'Select bookmark file')"

if [ $? -eq 0 ]; then
    touch $BMFILE

    while true; do
        sel="$(xargs -a $BMFILE -I{} sh -c 'LINE="{}"; echo "${LINE#* } - ${LINE%% *}"' | rofi -kb-custom-1 'Ctrl+Delete' -kb-custom-2 'Ctrl+Insert' -dmenu -format 'd')"

        case $? in
        0)
            qutebrowser $(sed -n $sel's/ .*//p' $BMFILE)
            exit 0
            ;;
        10)
            sed -i "$sed"'d' $BMFILE
            ;;
        *)
            exit 0
            ;;
        esac
    done
fi
