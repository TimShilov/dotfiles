#!/bin/bash
export PATH="/opt/homebrew/bin:/etc/profiles/per-user/$USER/bin:/run/current-system/sw/bin:$PATH"
export PATH="$HOME/.nix-profile/bin:$PATH"

tmux new-window "sesh connect $1"
