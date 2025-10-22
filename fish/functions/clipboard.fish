function clipboard
    if command -v pbcopy >/dev/null
        pbcopy
    else if command -v xclip >/dev/null
        xclip -selection clipboard
    else if command -v xsel >/dev/null
        xsel --clipboard --input
    else if command -v wl-copy >/dev/null
        wl-copy
    else
        echo "No clipboard utility found"
        return 1
    end
end
