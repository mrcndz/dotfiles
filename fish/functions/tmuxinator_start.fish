function tmuxinator_start
    tmuxinator debug "$1" | sed 's/TMUX= //' | fish
end
