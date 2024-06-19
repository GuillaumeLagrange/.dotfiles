#!/bin/bash

# Get the tree of windows in JSON format
TREE=$(swaymsg -t get_tree)

# Check if workspace 3 is empty
IS_EMPTY=$(swaymsg -t get_tree | jq '[recurse(.nodes[]) | select(.type == "workspace" and .focused == true) | .nodes | length == 0] | any')

COMMAND="kitty --title \"Charybdis nvim\" sh -c \"ssh -o ClearAllForwardings=yes -t charybdis 'exec env LANG=C.UTF-8 tmux new-session -A -s nvim'\""

# Execute the command if workspace 3 is empty
if [ "$IS_EMPTY" == "true" ]; then
  swaymsg exec $(eval $COMMAND)
fi

