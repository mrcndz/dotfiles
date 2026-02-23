function fzf-files --argument-names dir
    set -l target (test -n "$dir"; and echo $dir; or pwd)
    set -l bat_theme; test "$DARK_MODE" = 1; and set bat_theme Dracula; or set bat_theme "Monokai Extended Light"
    rg --files $target | \
    BAT_THEME=$bat_theme fzf --preview='bat -n --color=always {}' \
        --preview-window='right:60%'
end

function fzf-files-popup --argument-names dir
    set -l target (test -n "$dir"; and echo $dir; or pwd)
    $DOTFILES/tmux/popup-capture.fish "fish -c 'source $DOTFILES/fzf/files.fish; fzf-files $target'"
end
