#!/usr/bin/env bash
# Single-line: Model │ Context X% │ project at branch (Claude's quota lives in Tern's Agents sidebar)
input=$(cat)
# Tern's status bar shows the pane's model and context through tern-kit
[ -n "$TERN_PANE" ] && printf '%s' "$input" | "$HOME/.local/bin/tern-kit" statusline >/dev/null 2>&1 &

# Feed usagebar so the Herdr sidebar $limit row gets Claude's rate-limit data
printf '%s' "$input" | bash "$HOME/.config/herdr/plugins/github/usagebar-33803b79d616/bin/run-statusline.sh" >/dev/null 2>&1

short_model=$(echo "$input" | jq -r '.model.display_name // "Claude"' | sed 's/Claude //')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // "."')
ctx=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
branch=$(cd "$cwd" 2>/dev/null && git rev-parse --abbrev-ref HEAD 2>/dev/null || echo '')
project=$(cd "$cwd" 2>/dev/null && basename "$(git rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null || echo '')
[ -z "$project" ] && project=$(basename "$cwd")

# --- Output ---
printf "\033[2m%s\033[0m" "$short_model"

if [ "$ctx" -ge 80 ]; then
  printf " \033[2m\033[0m \033[31m%s%%\033[0m" "󰠞 $ctx"
elif [ "$ctx" -ge 50 ]; then
  printf " \033[2m\033[0m \033[33m%s%%\033[0m" "󰠞 $ctx"
else
  printf " \033[2m\033[0m \033[2m%s%%\033[0m" "󰠞 $ctx"
fi

if [ -n "$project" ]; then
  printf " \033[2m|\033[0m \033[2m%s\033[0m" " $project"
fi

if [ -n "$branch" ]; then
  printf " \033[2mat\033[0m \033[2m%s\033[0m" " $branch"
fi

# Herdr pane id
if [ "${HERDR_ENV:-}" = 1 ] && [ -n "${HERDR_PANE_ID:-}" ]; then
  printf " \033[2m│\033[0m \033[2m%s\033[0m" "$HERDR_PANE_ID"
fi

