# Default command
fzf_configure_bindings --git_status=\eg --history=\ec --variables=\ev --processes=\ep --directory=\ef
set fzf_dir_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"
# set fzf_fd_opts '--ignore-file $DOTFILES/fzf/ignore'

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
    --ansi"
