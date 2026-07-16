#!/bin/bash
# Open `nvim -d` diffing a file against its version on the current branch (HEAD).
# Left = working tree, right = branch (readonly).
set -e

file="$1"
[ -z "$file" ] && exit 0

dir="$(mktemp -d)"
tmp="$dir/HEAD_$(basename "$file")"
git show "HEAD:$file" >"$tmp" 2>/dev/null || : # empty for new files

nvim \
  -d "$file" "$tmp" \
  -c 'windo set nofoldenable' \
  -c 'wincmd l' -c 'setlocal nomodifiable readonly' -c 'wincmd h'
rm -rf "$dir"
