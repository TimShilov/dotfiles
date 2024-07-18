#!/usr/bin/env sh

sketchybar --add event aerospace_workspace_change

FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)

for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        icon=$sid \
        icon.padding_left=22 \
        icon.padding_right=22 \
        icon.highlight_color=$RED \
        background.padding_left=0 \
        background.padding_right=0 \
        background.height=26 \
        background.corner_radius=9 \
        background.color=0xff3C3E4F \
        background.drawing=off \
        label.drawing=off \
        click_script="aerospace workspace $sid" \
        script="$CONFIG_DIR/plugins/aerospace.sh $sid"
done
