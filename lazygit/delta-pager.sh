#!/bin/sh
if defaults read -g AppleInterfaceStyle >/dev/null 2>&1; then
  mode="--dark --syntax-theme base16-256"
else
  mode="--light --syntax-theme GitHub"
fi
exec delta $mode --paging=never --hunk-header-decoration-style=none --line-numbers --line-numbers-left-format="" --file-style=omit --wrap-max-lines=1 "$@"
