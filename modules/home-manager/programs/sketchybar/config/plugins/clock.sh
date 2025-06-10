#!/bin/sh

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

sketchybar --set "$NAME" \
  icon="􀐫" \
  label="$(date +'%a %b %d %H:%M')" \
  background.color="$LAVENDER"
