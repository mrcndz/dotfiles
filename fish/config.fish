source $DOTFILES/env.fish

# Variables
set -gx EDITOR nvim
set -gx XDG_CONFIG_HOME $HOME/.config

set -gx PYENV_ROOT $HOME/.pyenv
set -gx CPPFLAGS -I/opt/homebrew/opt/openjdk/include
set -gx GOPATH $HOME/.go

set -g async_prompt_functions _pure_prompt_git

# Paths
fish_add_path $HOME/.go/bin /usr/local/go/bin
fish_add_path /opt/homebrew/sbin /opt/homebrew/bin
fish_add_path /opt/homebrew/opt/openjdk/bin
fish_add_path $HOME/.cargo/bin $HOME/.local/bin $HOME/.local/share/nvim/mason/bin
fish_add_path $DOTFILES/scripts

if status is-interactive
    set -g fish_greeting # Disable fish greeting

    not set -q TMUX && exec tmux -f $DOTFILES/tmux/tmux.conf
    type -q zoxide && zoxide init fish | source
    type -q tv && tv init fish | source

    # Binds
    bind -M insert \ce "tvp \$(pwd) | xargs nvim"
    bind -M default \ce "tvp \$(pwd) | xargs nvim"
    bind -M insert \co zi
    bind -M default \co zi
    bind -M insert \t accept-autosuggestion
    bind -M insert --sets-mode default jj repaint
    bind yy fish_clipboard_copy
    bind Y fish_clipboard_copy
    bind p fish_clipboard_paste

    # Alias
    alias tvp="$DOTFILES/tmux/popup-capture.fish tv"
    alias g="git"
    alias cdr="cd (ls -t | head -n 1)"
    alias lg="lazygit"
    alias bat="batcat"
    alias dot="cd $DOTFILES"
    alias dcd="docker-compose down"
    alias dcu="docker-compose up -d"
    alias dcr="docker-compose down; docker-compose up -d"
    alias dcl="docker-compose logs -f"
    alias mux="tmuxinator"
    alias rc="redis-cli -h localhost -p 6379"

    # Enable vi key bindings
    fish_vi_key_bindings
end
