#!/usr/bin/env fish

set -l buffer (uuidgen)
set -l command $argv[1]

# run command in a popup
tmux display-popup -E "$command | tmux load-buffer -b $buffer -"

# return result
tmux show-buffer -b $buffer 2>/dev/null && tmux delete-buffer -b $buffer
