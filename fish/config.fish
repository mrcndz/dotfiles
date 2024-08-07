# Variables
ulimit -n 10240
set -gx EDITOR nvim
set -gx DOTFILES $HOME/.dotfiles

# Source
source $DOTFILES/fish/theme.fish
source $DOTFILES/fish/fzf.fish
source $DOTFILES/fish/keybindings.fish
source $DOTFILES/fish/local.fish
source $DOTFILES/fish/scripts.fish

# Paths
fish_add_path /opt/homebrew/sbin
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/share/nvim/mason/bin
fish_add_path $DOTFILES/scripts

# Alias
alias j="jump"
alias v="nvim"
alias g="git"
alias cdr="cd (ls -t | head -n 1)"
alias b __cd_back_to
alias lg="lazygit"
alias cg="chatgpt"
alias bat="batcat"
alias dot="cd $DOTFILES"

# Autorun Tmux
if status is-interactive
    and not set -q TMUX
    exec tmux -f $DOTFILES/tmux/tmux.conf
end

chatgpt --set-completions fish | source
jump shell fish | source
