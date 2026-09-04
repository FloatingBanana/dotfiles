#!/usr/bin/bash

TEXT=$(jq -Ra . <<< "${1:-$(rofi -dmenu -l 0 -p "Translate text")}")

[[ $? -ne 0 ]] && exit 1

RESULT=$(curl -X POST 'https://api-free.deepl.com/v2/translate' \
    --header 'Authorization: DeepL-Auth-Key e2b95add-c460-4b1b-bce7-3c74b9f183b5:fx' \
    --header 'Content-Type: application/json' \
    --data '{"text": ['"$TEXT"'], "target_lang": "PT-BR", "formality": "prefer_less"}' \
)

notify-send -t 0 "$(echo "$RESULT" | jq -r '.translations[] | "From \(.detected_source_language) to PT-BR: ", "\(.text)"')"
