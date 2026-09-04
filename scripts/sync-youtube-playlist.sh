#!/usr/bin/bash

FOLDER="/home/thales/Musics/ytmsc"

while read -r plurl; do
    pl="$(yt-dlp -q --no-warnings --flat-playlist --dump-single-json $plurl)"
    plfolder="$FOLDER/$(echo $pl | jq '.title')"

    echo "$pl" | jq -r ".entries[].url" | parallel -j8 --bar "yt-dlp -N2 -x --audio-format mp3 -f 'bestaudio/best' -o '$plfolder/%s(title)s.%(ext)s' {}"    

    mkdir "$plfolder"
done < "$FOLDER/playlists"
