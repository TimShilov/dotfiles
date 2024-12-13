#!/bin/sh

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

EMAIL_COUNT=$(notmuch count --output=messages '(to:tim@affluent.io OR to:tim.shilov@impact.com)')

LABEL="$EMAIL_COUNT"
COLOR="$MAUVE"

sketchybar --set "$NAME" \
    icon="󰇰 " icon.color="$COLOR" \
    label="$LABEL" \
    label.color="$COLOR"
