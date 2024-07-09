# Enable Vi key bindings
fish_vi_key_bindings

bind -M insert \ce 'nvim (pwd)'
bind -M default \ce 'nvim (pwd)'
bind -M insert \co "jump top | nvim (fzf)"
bind -M default \co "jump top | nvim (fzf)"
bind -M insert \cg lazygit
bind -M default \cg lazygit
bind -M insert \t accept-autosuggestion
