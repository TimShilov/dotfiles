#!/usr/bin/env sh

# sketchybar --add event aerospace_workspace_change
#
# for sid in $(aerospace list-workspaces --all); do
#     color="$INACTIVE"
#     sketchybar --add item space.$sid left \
#         --subscribe space.$sid front_app_switched \
#         --subscribe space.$sid aerospace_workspace_change \
#         --set space.$sid \
#         icon="􀀁" \
#         background.drawing=off \
#         label.drawing=off \
#         icon.color="$color" \
#         icon.font.size=12 \
#         icon.align=center \
#         padding_left=0 \
#         padding_right=6 \
#         click_script="aerospace workspace $sid" \
#         script="$CONFIG_DIR/plugins/aerospace.sh $sid"
# done
