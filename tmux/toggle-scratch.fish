#!/usr/bin/env fish

set -l width (count $argv > 0 && echo $argv[1] || echo "80%")
set -l height (count $argv > 1 && echo $argv[2] || echo "80%")

# Simple popup - closes with Esc or Ctrl+D
tmux display-popup -xC -yC -w$width -h$height -d '#{pane_current_path}' -E fish
