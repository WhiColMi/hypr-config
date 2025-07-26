#!/bin/bash

LOG="$HOME/.config/hypr/scripts/log"
COLOR_FILE="$HOME/.config/hypr/colors/background"
BG_IMAGE="$HOME/.config/hypr/colors/bg.png"
MAX_X=1
MAX_Y=1

# Read the color
if [ -f "$COLOR_FILE" ]; then
    COLOR=$(cat "$COLOR_FILE")
else
    echo "No color file found at $COLOR_FILE" >> $LOG
    exit 1
fi

while [ -z "$(hyprctl monitors | grep 'Monitor')" ]; do
    sleep 0.1
done
echo "$(hyprctl monitors | grep 'Monitor' | wc -l)" >> $LOG

while read -r line; do
    if [[ "$line" =~ ^([0-9]+)x([0-9]+)@ ]]; then
        CUR_X=${BASH_REMATCH[1]}
        CUR_Y=${BASH_REMATCH[2]}
    elif [[ "$line" =~ scale:\ ([0-9.]+) ]]; then
        CUR_SCALE=${BASH_REMATCH[1]}

        SCALED_X=$(awk "BEGIN { printf \"%.0f\", $CUR_X / $CUR_SCALE }")
        SCALED_Y=$(awk "BEGIN { printf \"%.0f\", $CUR_Y / $CUR_SCALE }")
	echo "${SCALED_X}x${SCALED_Y}" >> $LOG

        if (( SCALED_X > MAX_X )); then MAX_X=$SCALED_X; fi
        if (( SCALED_Y > MAX_Y )); then MAX_Y=$SCALED_Y; fi
    fi
done < <(hyprctl monitors)
echo "${MAX_X}x${MAX_Y}" >> $LOG

# Generate the PNG
mkdir -p "$(dirname "$BG_IMAGE")"
magick -size "${MAX_X}x${MAX_Y}" xc:"$COLOR" "$BG_IMAGE"

# Apply it
# sleep 0.5
# echo "setting background" >> $LOG
# nohup wbg "$BG_IMAGE" > /dev/null 2>&1 &

