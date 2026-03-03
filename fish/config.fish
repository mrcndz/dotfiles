source $DOTFILES/env.fish

# Variables
set -gx EDITOR nvim
set -gx XDG_CONFIG_HOME $HOME/.config
defaults read -g AppleInterfaceStyle &>/dev/null; and set -gx DARK_MODE 1; or set -gx DARK_MODE 0

set -gx PYENV_ROOT $HOME/.pyenv
set -gx CPPFLAGS -I/opt/homebrew/opt/openjdk/include
set -gx GOPATH $HOME/.go

set -g async_prompt_functions _pure_prompt_git
begin
    set -l ignore (string join , (for k in a b c d e f g h l m n o p r s t u v w x y z 0 1 2 3 4 5 6 7 8 9; printf '%s:ignore\n' $k; end))
    set -l all a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9
    set -gx FZF_DEFAULT_OPTS (string join -- ' ' \
        '--bind "start:disable-search"' \
        '--bind "j:down"' \
        '--bind "k:up"' \
        '--bind "q:abort"' \
        "--bind \"$ignore\"" \
        "--bind \"i:enable-search+unbind($all)\"" \
        "--bind \"esc:disable-search+rebind($all)\"" \
    )
end

# Paths
fish_add_path $HOME/.go/bin /usr/local/go/bin
fish_add_path /opt/homebrew/sbin /opt/homebrew/bin
fish_add_path /opt/homebrew/opt/openjdk/bin
fish_add_path $HOME/.cargo/bin $HOME/.local/bin $HOME/.local/share/nvim/mason/bin
fish_add_path $DOTFILES/scripts

if status is-interactive
    set -g fish_greeting # Disable fish greeting

    not set -q TMUX && exec sh -c "tmux -f $DOTFILES/tmux/tmux.conf attach 2>/dev/null || tmux -f $DOTFILES/tmux/tmux.conf new"
    type -q zoxide && zoxide init fish | source

    # Binds
    bind -M insert \ce "fzf-files-popup | xargs nvim"
    bind -M default \ce "fzf-files-popup | xargs nvim"
    bind -M insert \cg "tmux display-popup -d (pwd) -xC -yC -w80% -h80% -E lazygit"
    bind -M default \cg "tmux display-popup -d (pwd) -xC -yC -w80% -h80% -E lazygit"
    bind -M insert \co zi
    bind -M default \co zi
    bind -M insert \t accept-autosuggestion
    bind -M insert --sets-mode default jj repaint
    bind yy fish_clipboard_copy
    bind Y fish_clipboard_copy
    bind p fish_clipboard_paste

    # Source fzf functions
    for f in $DOTFILES/fzf/*.fish
        source $f
    end

    # Alias

    alias claude="claude --dangerously-skip-permissions"
    alias g="git"
    alias cdr="cd (ls -t | head -n 1)"
    alias lg="lazygit"
    alias bat="batcat"
    alias dot="cd $DOTFILES"
    alias dcd="docker compose down"
    alias dcu="docker compose up -d"
    alias dcr="docker compose down; docker-compose up -d"
    alias dcl="docker compose logs -f"
    alias mux="tmuxinator"
    alias rc="redis-cli -h localhost -p 6379"

    # Enable vi key bindings
    fish_vi_key_bindings
end
