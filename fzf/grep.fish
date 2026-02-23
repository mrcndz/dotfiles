function grepi --argument-names pattern
    test -n "$pattern"; or return 1
    rg --line-number --no-heading --color=always "$pattern" | \
    fzf --ansi --delimiter=':' \
        --preview="rg --color=always -C 5 '$pattern' {1}" \
        --preview-window='right:60%' \
        --bind='enter:become(echo {1}:{2})'
end

function grepi-popup --argument-names pattern
    test -n "$pattern"; or return 1
    $DOTFILES/tmux/popup-capture.fish "fish -c 'source $DOTFILES/fzf/grep.fish; grepi \"$pattern\"'"
end
