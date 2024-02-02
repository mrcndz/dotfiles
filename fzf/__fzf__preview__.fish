function __fzf_preview__
    if file --mime "$argv" | grep -q directory
        tree -L 3 - "$argv"
    else if file --mime "$argv" | grep -q binary
        echo "Binary file: $argv"
    else
        if command --quiet --search bat
            bat --style=numbers --color=always --line-range :250 "$argv"
        else if command --quiet --search cat
            cat "$argv" | head -n 250
        else
            head -n 250 "$argv"
        end
    end
end
