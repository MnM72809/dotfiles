#!/usr/bin/env bash
THEMES_DIR="$HOME/.config/themes"
WALLPAPER_DIR="$THEMES_DIR/wallpapers/active"

#rofi_override="$(cat $THEMES_DIR/rofi_override.rasi)"

# Build the rofi menu entries: each line is "filename\0icon\x1f/full/path.jpg"
choice=$(
  for f in "$WALLPAPER_DIR"/*; do
    [ -f "$f" ] || continue
    name=$(basename "$f")
    echo -e "$name\0icon\x1f$f"
  done | rofi -dmenu -show-icons -theme "$THEMES_DIR/rofi_override.rasi" -i -p "Wallpaper"
)

[ -z "$choice" ] && exit 0

# Pass the full path to the script
echo "$WALLPAPER_DIR/$choice"
