#!/bin/bash
output=$(tmux capture-pane -p | grep -v '^[[:space:]]*$' | tac | awk '/^❯/{if(found) exit; found=1; next} found' | tac | head -n -1)

if [ -n "$output" ]; then
    echo -n "$output" | tmux load-buffer -
    tmux set-buffer -w "$(tmux show-buffer)"
fi
