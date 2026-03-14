#!/bin/bash
# Tracks active sessions + tmux panes in a tiny JSON file
ACTIVE="$HOME/.claude/.active-sessions.json"

INPUT=$(cat)
EVENT=$(printf '%s\n' "$INPUT" | jq -r '.hook_event_name')
SESSION_ID=$(printf '%s\n' "$INPUT" | jq -r '.session_id')

[ -z "$SESSION_ID" ] && exit 0
[ -f "$ACTIVE" ] || echo '{}' > "$ACTIVE"

case "$EVENT" in
  SessionStart)
    TMUX_SESS=""
    TMUX_PANE=""
    if [ -n "$TMUX" ]; then
      TMUX_SESS=$(tmux display-message -p '#{session_name}' 2>/dev/null)
      TMUX_PANE=$(tmux display-message -p '#{pane_id}' 2>/dev/null)
    fi
    jq -c --arg id "$SESSION_ID" --arg s "$TMUX_SESS" --arg p "$TMUX_PANE" \
      '. + {($id): {sess: $s, pane: $p}}' "$ACTIVE" > "$ACTIVE.tmp"
    mv "$ACTIVE.tmp" "$ACTIVE"
    ;;
  SessionEnd)
    jq -c --arg id "$SESSION_ID" 'del(.[$id])' "$ACTIVE" > "$ACTIVE.tmp"
    mv "$ACTIVE.tmp" "$ACTIVE"
    ;;
esac
