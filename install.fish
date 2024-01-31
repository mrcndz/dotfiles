#!/usr/bin/env fish
set dotfiles_dir (cd (dirname (status filename)); and pwd)
set fish_config $HOME/.config/fish/config.fish

echo "Setting up dotfiles"
echo "Dotfiles directory: $dotfiles_dir"
echo "Fish config: $fish_config"

echo "Setting fish config"
echo "\
# Set DOTFILES
set -gx DOTFILES $dotfiles_dir

# Call the main config file
source $dotfiles_dir/fish/config.fish
" > $fish_config

echo "Setting nvim config"

echo "\
dofile('$dotfiles_dir/nvim/init.lua')
" > $HOME/.config/nvim/init.lua

echo "\
source-file $dotfiles_dir/tmux/.tmux.conf
" > $HOME/.tmux.conf
