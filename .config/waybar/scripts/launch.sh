#!/bin/bash

if pgrep -x waybar > /dev/null; then
    pkill -USR2 -x waybar
else
    waybar &
fi
