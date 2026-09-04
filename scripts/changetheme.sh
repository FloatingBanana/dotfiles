#!/usr/bin/zsh

FILENAME=$(ls ~/wallpapers/ | shuf -n 1)
FULLPATH="$HOME/wallpapers/$FILENAME"
echo $FULLPATH > ~/.cache/wallpaper

if [[ "${FILENAME##*.}" == "mp4" ]]; then
    ffmpeg -y -ss 00:00:00 -i $FULLPATH -vframes 1 "$HOME/.cache/livewallpaperframe.jpg"
    wal --contrast 4.5 -n -i "$HOME/.cache/livewallpaperframe.jpg"
else
    wal --contrast 4.5 -n -i "$FULLPATH"
fi



hyprctl setcursor "$(ls ~/.icons --ignore=old | shuf -n 1)" 24
