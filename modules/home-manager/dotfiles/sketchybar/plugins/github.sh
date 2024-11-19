#!/bin/sh

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

TASK_CMD="task rc.gc=off"
CACHE_CMD="bkt --ttl=1m --discard-failures --"

GITHUB_PR_COUNT=$(
    $TASK_CMD githubnumber +READY count
)

sketchybar --set "$NAME" \
    icon="  " icon.color="$PEACH" \
    label="$GITHUB_PR_COUNT" label.color="$PEACH"
