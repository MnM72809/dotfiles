#!/bin/bash

set -xeuo pipefail

echo

########################################
# Configuration
########################################

THEMES_DIR="/home/moriaan/.config/themes"
WALLPAPER_DIR="$THEMES_DIR/wallpapers"
ACTIVE_DIR="${WALLPAPER_DIR}/active"
CURRENT_LINK="${WALLPAPER_DIR}/current"

echo Getting wallpaper path

if [[ $# -eq 0 ]]; then
	echo Selecting random wallpaper
	image=$($THEMES_DIR/random_wallpaper.sh $ACTIVE_DIR $CURRENT_LINK)
else
	if [[ $1 == "--keep-wallpaper" ]]; then
		echo Keeping current wallpaper
		image="$(readlink -f $CURRENT_LINK)"
	elif [[ $1 == "--picker" ]]; then
		echo Opening wallpaper picker
		image="$($THEMES_DIR/wallpaper_picker.sh)"
	else
		echo Using provided image: $1
		image="$1"
	fi
fi

echo "Selected image: $image"

########################################
# Update symlink
########################################

echo Updating symlink

ln -sfn "$image" "$CURRENT_LINK"

#echo "Updated symlink: $CURRENT_LINK"

########################################
# Apply wallpaper
########################################

echo Applying wallpaper

awww img "$CURRENT_LINK" -t random --transition-fps 180

echo Running matugen =====================

matugen image "$(readlink $CURRENT_LINK)" --source-color-index 0

echo =====================================
echo Finished
echo

exit 0
