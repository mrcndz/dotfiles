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

# Plugins
# Add new plugins to the list by running `set plugins -a <author>/<plugin-name>`
set -l plugins jorgebucaran/autopair.fish
set -a plugins patrickf1/fzf.fish

# Auto install plugin if not installed
for plugin in $plugins
    if not fisher list | grep -q $plugin
        echo $plugin >> $__fish_config_dir/fish_plugins
        echo "run `fisher update` to complete the install of $plugin"
    end
end

# Autorun Tmux
if status is-interactive
and not set -q TMUX
    exec tmux
end

# Call Theme
source $DOTFILES/fish/theme.fish
