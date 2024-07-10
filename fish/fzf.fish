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

# Default command
fzf_configure_bindings --git_status=\eg --history=\ec --variables=\ev --processes=\ep --directory=\cf

set -x FZF_DEFAULT_OPTS " \
    --multi \
    --cycle \
    --keep-right -1 \
    --height=50% \
    --layout reverse \
    --info default \
    --border=rounded \
    --info=inline \
    --prompt='❯ ' \
    --pointer='▶ ' \
    --marker='✓ ' \
    --header='Search '
    --preview-window right:50%:wrap \
    --ansi \
    --preview='__fzf_preview__ {}' \
    "
