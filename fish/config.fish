
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /Users/marc/opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# Paths
fish_add_path /opt/homebrew/sbin
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.cargo/bin/

# Variable:
set -gx FISH_CONFIG $HOME/.config/fish/config.fish
set -gx EDITOR nvim
set -gx DOTFILES $HOME/Repos/dotfiles
set -gx TMUX_CONFIG $HOME/.tmux.conf

# Alias
alias reload_fish="source $FISH_CONFIG"
alias config_fish="$EDITOR $FISH_CONFIG"
alias config_tmux="$EDITOR $TMUX_CONFIG"

# Plugins

set plugins -l \
    jorgebucaran/autopair.fish \
    patrickf1/fzf.fish

# Autorun Tmux
if status is-interactive
and not set -q TMUX
    exec tmux
end
