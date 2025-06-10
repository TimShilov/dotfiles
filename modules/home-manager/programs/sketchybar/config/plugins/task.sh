#!/bin/sh

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

TASK_CMD="task rc.gc=off"
CACHE_CMD="bkt --ttl=1m --discard-failures  --"

TOP_TASK=$(
    $TASK_CMD _get $($TASK_CMD next limit:1 | tail -n +4 | head -n 1 | sed 's/^ //' | cut -d ' ' -f1).description | cut -c -77
)

COLORS=(
    "$ROSEWATER"
    "$FLAMINGO"
    "$PINK"
    "$MAUVE"
    "$MAROON"
    "$PEACH"
    "$YELLOW"
    "$GREEN"
    "$TEAL"
    "$SKY"
    "$SAPPHIRE"
    "$BLUE"
    "$LAVENDER"
)

# Get the current hour (0-23)
CURRENT_HOUR=$(date +%H)

# Calculate the index by taking the modulo of the current hour and the number of colors
COLOR_INDEX=$((CURRENT_HOUR % ${#COLORS[@]}))

# Get the color for this hour
COLOR=${COLORS[$COLOR_INDEX]}

sketchybar --set "$NAME" label="$TOP_TASK" label.padding_left=0 background.color="$COLOR"
