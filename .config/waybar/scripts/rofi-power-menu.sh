#!/usr/bin/env bash

# Get menu options from power-menu.sh
CHOICE=$(~/path/to/power-menu.sh --list | rofi -dmenu -p "Power Menu")

# Run the selected action
if [[ -n "$CHOICE" ]]; then
  ~/path/to/power-menu.sh --action "$CHOICE"
fi
