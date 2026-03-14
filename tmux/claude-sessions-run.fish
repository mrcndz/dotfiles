#!/usr/bin/env fish

source $DOTFILES/fzf/claude-sessions.fish

set -l dir $argv[1]
set -l action (claude-sessions $dir)

test -n "$action"; and claude-sessions-exec "$action"
