# Variables
set -gx EDITOR nvim
set -gx DOTFILES $HOME/.dotfiles

# Source
source $DOTFILES/fish/theme.fish
source $DOTFILES/fish/fzf.fish

# Paths
fish_add_path /opt/homebrew/sbin
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.cargo/bin/

# Alias
alias j="jump"
alias g="git"
alias v="nvim"

# Autorun Tmux
if status is-interactive
    and not set -q TMUX
    exec tmux -f $DOTFILES/tmux/tmux.conf
end

jump shell fish | source
