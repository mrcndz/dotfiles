# Variables
set -x EDITOR nvim
set -x DOTFILES $HOME/.dotfiles

# Source
source $DOTFILES/fish/theme.fish
source $DOTFILES/fish/fzf.fish

# Paths
fish_add_path /opt/homebrew/sbin
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/share/nvim/mason/bin

# Alias
alias j="jump"
alias g="git"
alias v="nvim"
alias cg="chatgpt"

# Autorun Tmux
if status is-interactive
    and not set -q TMUX
    exec tmux -f $DOTFILES/tmux/tmux.conf
end

chatgpt --set-completions fish | source
jump shell fish | source
