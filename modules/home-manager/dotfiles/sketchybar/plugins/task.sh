#!/bin/sh

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

TASK_CMD="task rc.gc=off"
CACHE_CMD="bkt --ttl=1m --discard-failures  --"

TOP_TASK=$(
    $CACHE_CMD $TASK_CMD _get $($TASK_CMD next limit:1 | tail -n +4 | head -n 1 | sed 's/^ //' | cut -d ' ' -f1).description
)

sketchybar --set "$NAME" label="$TOP_TASK" label.color="$GREEN"
