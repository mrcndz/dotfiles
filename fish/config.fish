set -gx DOTFILES $HOME/.dotfiles
source $DOTFILES/fish/fisher.fish
source $DOTFILES/fish/theme.fish
source $DOTFILES/fzf/fzf.fish

# Paths
fish_add_path /opt/homebrew/sbin
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.cargo/bin/

# Variable:
set -gx CONFIG_FISH $DOTFILES/fish/config.fish
set -gx CONFIG_TMUX $DOTFILES/tmux/.tmux.conf
set -gx CONFIG_NVIM $DOTFILES/nvim/
set -gx EDITOR nvim

# Alias
alias reload_fish="source $CONFIG_FISH"
alias config_fish="$EDITOR $CONFIG_FISH"
alias config_tmux="$EDITOR $CONFIG_TMUX"
alias config_vim="$EDITOR $CONFIG_NVIM"
alias j="jump"

# Plugins
# Add new plugins to the list by running `set plugins -a <author>/<plugin-name>`
fisher_plugin_install jorgebucaran/autopair.fish
fisher_plugin_install ilancosman/tide@v6
fisher_plugin_install PatrickF1/fzf.fish

# Autorun Tmux
if status is-interactive
and not set -q TMUX
    exec tmux -f $DOTFILES/tmux/tmux.conf
end

jump shell fish | source

# Configs
