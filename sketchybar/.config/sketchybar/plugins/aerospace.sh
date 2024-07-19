#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

SID=$1
FOCUSED=$(aerospace list-workspaces --focused)
bg="0xff585b70"
if [ "$SID" = "$FOCUSED" ]; then
    bg="0xffb4befe"
fi
sketchybar \
    --animate sin 10 \
    --set $NAME \
    icon.color="$bg"
