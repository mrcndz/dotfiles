#!/usr/bin/env bash
# Single-line: Model │ branch │ Context X% │ Y% used resets Zpm
input=$(cat)

short_model=$(echo "$input" | jq -r '.model.display_name // "Claude"' | sed 's/Claude //')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // "."')
ctx=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
branch=$(cd "$cwd" 2>/dev/null && git rev-parse --abbrev-ref HEAD 2>/dev/null || echo '')
project=$(cd "$cwd" 2>/dev/null && basename "$(git rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null || echo '')

# Fetch real usage from Anthropic API (cached for 60s)
CACHE_FILE="/tmp/claude-usage-cache.json"
CACHE_TTL=60
usage_part=""
pct=""

need_fetch=true
if [ -f "$CACHE_FILE" ]; then
  cache_age=$(( $(date +%s) - $(stat -f %m "$CACHE_FILE") ))
  if [ "$cache_age" -lt "$CACHE_TTL" ]; then
    need_fetch=false
    usage_json=$(cat "$CACHE_FILE")
  fi
fi

if $need_fetch; then
  token=$(security find-generic-password -s "Claude Code-credentials" -a "$(whoami)" -w 2>/dev/null | jq -r '.claudeAiOauth.accessToken // empty' 2>/dev/null)
  if [ -n "$token" ]; then
    fetched=$(curl -sf --max-time 3 "https://api.anthropic.com/api/oauth/usage" \
      -H "Authorization: Bearer $token" \
      -H "anthropic-beta: oauth-2025-04-20" 2>/dev/null)
    if [ -n "$fetched" ] && echo "$fetched" | jq -e '.five_hour' >/dev/null 2>&1; then
      echo "$fetched" > "$CACHE_FILE"
      usage_json="$fetched"
    elif [ -f "$CACHE_FILE" ]; then
      # API failed (rate limited), use stale cache
      usage_json=$(cat "$CACHE_FILE")
    fi
  fi
fi

if [ -n "$usage_json" ]; then
  pct=$(echo "$usage_json" | jq -r '.five_hour.utilization // empty' 2>/dev/null | cut -d. -f1)
  resets_at=$(echo "$usage_json" | jq -r '.five_hour.resets_at // empty' 2>/dev/null)

  if [ -n "$pct" ] && [ -n "$resets_at" ]; then
    # Convert reset time (UTC) to America/Recife (UTC-3)
    utc_h=$(echo "$resets_at" | sed 's/.*T\([0-9][0-9]*\):.*/\1/' | sed 's/^0*//')
    [ -z "$utc_h" ] && utc_h=0
    local_h=$(( (utc_h - 3 + 24) % 24 ))
    if [ "$local_h" -eq 0 ]; then reset_t="12am"
    elif [ "$local_h" -lt 12 ]; then reset_t="${local_h}am"
    elif [ "$local_h" -eq 12 ]; then reset_t="12pm"
    else reset_t="$(( local_h - 12 ))pm"
    fi
    usage_part="${pct}% resets ${reset_t}"
  fi
fi

# --- Output ---
printf "\033[2m%s\033[0m" "󱚣 $short_model"

if [ -n "$project" ]; then
  printf " \033[2m│\033[0m \033[2m%s\033[0m" " $project"
fi

if [ -n "$branch" ]; then
  printf "  \033[2m│\033[0m \033[2m%s\033[0m" " $branch"
fi

# Herdr pane id
if [ "${HERDR_ENV:-}" = 1 ] && [ -n "${HERDR_PANE_ID:-}" ]; then
  printf " \033[2m│\033[0m \033[2m%s\033[0m" "$HERDR_PANE_ID"
fi

# Context %
if [ "$ctx" -ge 80 ]; then
  printf " \033[2m│\033[0m \033[31m%s%%\033[0m" "󰠞 $ctx"
elif [ "$ctx" -ge 50 ]; then
  printf " \033[2m│\033[0m \033[33m%s%%\033[0m" "󰠞 $ctx"
else
  printf " \033[2m│\033[0m \033[2m%s%%\033[0m" "󰠞 $ctx"
fi

# Usage from API
if [ -n "$usage_part" ]; then
  if [ "$pct" -ge 80 ]; then
    printf " \033[2m│\033[0m \033[31m%s\033[0m" "$usage_part"
  elif [ "$pct" -ge 50 ]; then
    printf " \033[2m│\033[0m \033[33m%s\033[0m" "$usage_part"
  else
    printf " \033[2m│\033[0m \033[32m%s\033[0m" "$usage_part"
  fi
fi
