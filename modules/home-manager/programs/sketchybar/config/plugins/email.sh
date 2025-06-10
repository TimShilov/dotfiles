#!/bin/sh

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

EMAIL_COUNT=$(notmuch count --output=messages)

LABEL="$EMAIL_COUNT"
COLOR="$MAUVE"

sketchybar --set "$NAME" \
  icon="󰇰 " icon.color="$CRUST" \
  background.color="$COLOR" \
  label="$LABEL" \
  label.color="$CRUST"
