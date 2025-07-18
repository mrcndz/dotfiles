# Local env variables must be defined in env.fish
set -gx FISH_CONFIG $DOTFILES/fish
set -gx EDITOR nvim
set -gx GOPATH $HOME/.go
set -gx XDG_CONFIG_HOME $HOME/.config

# go

# Source
source $DOTFILES/env.fish
source $FISH_CONFIG/functions/execute.fish
execute source $FISH_CONFIG/plugins
execute source $FISH_CONFIG/functions

# Paths ----------------------------------------------------------------------
fish_add_path $HOME/.go/bin /usr/local/go/bin
fish_add_path /opt/homebrew/sbin /opt/homebrew/bin
fish_add_path $HOME/.cargo/bin $HOME/.local/bin $HOME/.local/share/nvim/mason/bin
fish_add_path $DOTFILES/scripts

# Alias
alias g="git"
alias cdr="cd (ls -t | head -n 1)"
alias lg="lazygit"
alias bat="batcat"
alias dot="cd $DOTFILES"
alias dcd="docker-compose down"
alias dcu="docker-compose up -d"
alias dcr="docker-compose down; docker-compose up -d"
alias dcl="docker-compose logs -f"

# Enable Vi key bindings
fish_vi_key_bindings

# Disable fish greeting
set -g fish_greeting

# Binds
bind -M insert \ce nvim
bind -M default \ce nvim
bind -M insert \co zi
bind -M default \co zi
bind -M insert \t accept-autosuggestion
bind -M insert --sets-mode default jj repaint
bind yy fish_clipboard_copy
bind Y fish_clipboard_copy
bind p fish_clipboard_paste

# Autorun Tmux
if status is-interactive
    and not set -q TMUX
    exec tmux -f $DOTFILES/tmux/tmux.conf
end

# Completions
if type -q zoxide
    zoxide init fish | source
end

if type -q pyenv
    set -gx PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin
    pyenv init - | source
    status --is-interactive; and source (pyenv virtualenv-init - | psub)
end

if type -q direnv
    direnv hook fish | source
end
