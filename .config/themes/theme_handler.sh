#!/bin/bash

set -euo pipefail

########################################
# Configuration
########################################

THEMES_DIR="/home/moriaan/.config/themes"
WALLPAPER_DIR="$THEMES_DIR/wallpapers"
ACTIVE_DIR="${WALLPAPER_DIR}/active"
CURRENT_LINK="${WALLPAPER_DIR}/current"

# Flags & Options
RUN_MATUGEN=false
ROTATE_WALLPAPER=false
TRANSITION_TYPE="random"
CUSTOM_IMAGE=""
USE_PICKER=false

########################################
# Argument Parsing
########################################

while [[ $# -gt 0 ]]; do
    case "$1" in
        --matugen)
            RUN_MATUGEN=true
            shift
            ;;
        --wallpaper)
            ROTATE_WALLPAPER=true
            shift
            ;;
        --no-transition)
            TRANSITION_TYPE="none"
            shift
            ;;
        --picker)
            USE_PICKER=true
            ROTATE_WALLPAPER=true
            shift
            ;;
        -*)
            echo "Unknown flag: $1" >&2
            exit 1
            ;;
        *)
            # Positional argument treated as an image path
            CUSTOM_IMAGE="$1"
            ROTATE_WALLPAPER=true
            shift
            ;;
    esac
done

# Default safeguard: if no action flags are passed, explain usage
if [[ "$RUN_MATUGEN" == false && "$ROTATE_WALLPAPER" == false ]]; then
    echo "Usage: $(basename "$0") [--wallpaper [--picker | <image_path>] [--no-transition]] [--matugen]"
    exit 1
fi

########################################
# Wallpaper Logic
########################################

image=""

if [[ "$ROTATE_WALLPAPER" == true ]]; then
    echo "=== Wallpaper Rotation ==="
    
    if [[ -n "$CUSTOM_IMAGE" ]]; then
        echo "Using provided image: $CUSTOM_IMAGE"
        image="$CUSTOM_IMAGE"
    elif [[ "$USE_PICKER" == true ]]; then
        echo "Opening wallpaper picker..."
        image="$($THEMES_DIR/wallpaper_picker.sh)"
    else
        echo "Selecting random wallpaper..."
        image="$($THEMES_DIR/random_wallpaper.sh "$ACTIVE_DIR" "$CURRENT_LINK")"
    fi

    if [[ -z "$image" ]]; then
        echo "Error: No image selected or returned." >&2
        exit 1
    fi

    echo "Selected image: $image"

    # Update symlink
    echo "Updating symlink..."
    ln -sfn "$image" "$CURRENT_LINK"

    # Apply wallpaper
    echo "Applying wallpaper with transition: $TRANSITION_TYPE"
    awww img "$CURRENT_LINK" -t "$TRANSITION_TYPE" --transition-fps 180 &
fi

########################################
# Matugen Logic
########################################

if [[ "$RUN_MATUGEN" == true ]]; then
    echo "=== Running Matugen ==="
    target_image="$(readlink -f "$CURRENT_LINK")"
    echo "Generating colors from: $target_image"
    
    matugen image "$target_image" --source-color-index 0
    echo "Matugen synchronization complete."
fi

echo "Finished!"
exit 0
