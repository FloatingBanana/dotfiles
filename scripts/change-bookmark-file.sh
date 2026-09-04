#!/usr/bin/env sh

BMPATH="$HOME/.config/qutebrowser/bookmarks"

selection="$(ls --ignore='urls' $BMPATH | rofi -dmenu -p 'Select bookmarks file')"
[ $? ] && touch "$BMPATH/$selection" && ln -fs -T "$BMPATH/$selection" "$BMPATH/urls"
