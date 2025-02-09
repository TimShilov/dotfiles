#!/usr/bin/env bash
# Usage: tmux_window_or_create.sh window_name command_to_run

window="$1"
shift
cmd="$@"

# Check if a window with the given name exists
if tmux list-windows -F '#{window_name}' | grep -qx "$window"; then
    tmux select-window -t :"$window"
else
    tmux new-window -c '#{pane_current_path}' -n "$window" "$cmd"
fi
