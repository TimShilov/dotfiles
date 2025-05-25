#!/bin/sh

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
DRAWING="on"
COLOR="$RED"

if [ "$PERCENTAGE" = "" ]; then
  DRAWING="off"
fi

if [[ "$PERCENTAGE" -gt 30 ]]; then
  DRAWING="off"
fi

case "${PERCENTAGE}" in
9[0-9] | 100)
  ICON="􀛨"
  ;;
[6-8][0-9])
  ICON="􀺸"
  ;;
[3-5][0-9])
  ICON="􀺶"
  ;;
[1-2][0-9])
  ICON="􀛩"
  ;;
*) ICON="􀛪" ;;
esac

CHARGING="$(pmset -g batt | grep 'AC Power')"
if [[ "$CHARGING" != "" ]]; then
  ICON="􀢋"
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" drawing="$DRAWING" icon="$ICON" icon.color="$COLOR" label.color="$COLOR" label="${PERCENTAGE}%"
