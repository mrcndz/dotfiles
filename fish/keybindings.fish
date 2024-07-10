# Enable Vi key bindings
fish_vi_key_bindings

bind -M insert \ce 'nvim (pwd)'
bind -M default \ce 'nvim (pwd)'
bind -M insert \co "jump top | nvim (fzf)"
bind -M default \co "jump top | nvim (fzf)"
bind -M insert \cg lazygit
bind -M default \cg lazygit
bind -M insert \t accept-autosuggestion
bind -M insert --sets-mode default jj repaint
bind yy fish_clipboard_copy
bind Y fish_clipboard_copy
bind p fish_clipboard_paste
