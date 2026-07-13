#!/bin/bash
pkill -f hypr-cava-visualizer.py || hypr-cava-visualizer --colors-file /home/moriaan/.config/hypr/colors.conf --fade --bars 400 --height-pct 50 --opacity 0.1 &
