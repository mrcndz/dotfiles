#!/usr/bin/env fish

source $DOTFILES/fzf/claude-sessions.fish

set -l dir $argv[1]

# fzf runs inside popup, result captured via tmux buffer
set -l action ($DOTFILES/tmux/popup-capture.fish "fish -c 'source $DOTFILES/fzf/claude-sessions.fish; claude-sessions $dir'")

test -n "$action"; and claude-sessions-exec "$action"
