#!/bin/bash
output=$(tmux capture-pane -p | grep -v '^[[:space:]]*$' | tac | awk '/^❯/{if(found) exit; found=1; next} found' | tac)
last_line=$(echo "$output" | tail -1)
if echo "$last_line" | grep -q '[─│┌┐└┘├┤┬┴┼]'; then
    output=$(echo "$output" | head -n -1)
fi
if [ -n "$output" ]; then
    echo -n "$output" | tmux load-buffer -
    tmux set-buffer -w "$(tmux show-buffer)"
fi
