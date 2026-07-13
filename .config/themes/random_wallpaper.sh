#!/bin/bash

set -euo pipefail

########################################
# Configuration
########################################

ACTIVE_DIR=$1
CURRENT_LINK=$2

########################################
# Validate directories
########################################

if [ ! -d "$ACTIVE_DIR" ]; then
  echo "Error: Active wallpaper directory does not exist: $ACTIVE_DIR"
  exit 1
fi

########################################
# Collect image files
########################################

mapfile -t image_files < <(
  find "$ACTIVE_DIR" -maxdepth 1 -type f \( \
    -iname "*.jpg" -o \
    -iname "*.jpeg" -o \
    -iname "*.png" -o \
    -iname "*.gif" -o \
    -iname "*.avif" -o \
    -iname "*.webp" \
  \)
)

if [ ${#image_files[@]} -eq 0 ]; then
  echo "Error: No image files found in $ACTIVE_DIR"
  exit 1
fi

########################################
# Resolve current symlink target
########################################

if [ -L "$CURRENT_LINK" ]; then
  if ! current_target=$(readlink -f "$CURRENT_LINK"); then
    #"$CURRENT_LINK is not a valid symlink, ignoring."
	current_target=""
  fi
else
  current_target=""
fi

########################################
# Filter out current image
########################################

available_images=()

for img in "${image_files[@]}"; do
  if [ "$(readlink -f "$img")" != "$current_target" ]; then
    available_images+=("$img")
  fi
done

if [ ${#available_images[@]} -eq 0 ]; then
  echo "Only one image available and it is already active."
  exit 0
fi

########################################
# Select random image
########################################

random_image="${available_images[RANDOM % ${#available_images[@]}]}"

########################################
# Echo and exit
########################################

echo $random_image
exit 0

