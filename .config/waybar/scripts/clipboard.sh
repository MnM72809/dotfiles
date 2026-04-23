#!/bin/sh

#cliphist list | rofi -dmenu -i -p "Clipboard" -matching fuzzy | cliphist decode | wl-copy

#cliphist list \
  #| head \
  #| awk -F'\t' '{print $2 "\t" $1}' \
  #| rofi -dmenu -i -p "Clipboard" -matching fuzzy -columns 2 -display-columns 1 \
  #| awk -F'\t' '{print $2 "\t" $1}' \
  #| cliphist decode \
  #| wl-copy


# Get the most recent entry as fallback
fallback=$(cliphist list | head -1)

# Show rofi, capture selection
selected=$(cliphist list \
  | head \
  | awk -F'\t' '{print $2 "\t" $1}' \
  | rofi -dmenu -i -p "Clipboard" -matching fuzzy -columns 2 -display-columns 1 \
  | awk -F'\t' '{print $2 "\t" $1}')

# Use fallback if nothing was selected (Esc)
if [[ -z "$selected" ]]; then
  selected="$fallback"
fi

echo "$selected" | cliphist decode | wl-copy
