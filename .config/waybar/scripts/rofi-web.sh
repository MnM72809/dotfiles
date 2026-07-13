#!/usr/bin/env bash

BROWSER="zen-browser"
HISTORY="$HOME/.local/share/rofi-search-history"
CLEAN_HISTORY_COMMAND="\$cleanup"

#"$BROWSER" &
#BROWSER_PID=$!

choice=$(awk '!seen[$0]++' "$HISTORY" 2>/dev/null | rofi -dmenu -kb-accept-entry "Control+Return" -kb-accept-custom "Return,KP_Enter" -p "Browser")

# Killed with SIGTERM
[[ $? == 143 ]] && exit 143



[[ -z "$choice" ]] && { "$BROWSER"; exit 0; }

# Add to beginning of history
[[ -n "$choice" ]] && echo "$choice" | cat - $HISTORY > /tmp/rofi-search-history && mv /tmp/rofi-search-history $HISTORY

if [[ "$choice" == "$CLEAN_HISTORY_COMMAND" ]]; then
	echo $CLEAN_HISTORY_COMMAND > $HISTORY
	notify-send "Cleared rofi search history" -u low
	#kill $BROWSER_PID
	exit 0
fi

"$BROWSER" &
sleep 1
if [[ "$choice" =~ ^https?:// ]]; then
    "$BROWSER" "$choice"
elif [[ "$choice" =~ ^[a-zA-Z0-9.-]+\.(com|org|be|net|io|dev|app|co|uk|nl|de|fr|edu|eu|ai)(\/.*)?$ ]]; then
    "$BROWSER" "https://$choice"
else
    query=$(python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))" "$choice")
    "$BROWSER" "https://www.ecosia.org/search?q=${query}"
fi
