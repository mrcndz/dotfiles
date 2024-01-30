#!/usr/bin/env fish
echo updating...
rsync -av --exclude 'plugged' --exclude '.*' ~/.config/nvim/ $DOTFILES/nvim/
cp ~/.tmux.conf $DOTFILES/tmux/
cp -r ~/.config/nvim $DOTFILES
