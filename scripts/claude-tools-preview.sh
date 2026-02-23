#!/bin/bash
# Preview script for claude-tools fzf picker
# Called with: claude-tools-preview.sh <tool_use_id> <history_file>

ID="$1"
HISTORY_FILE="$2"

ENTRY=$(jq -c --arg id "$ID" 'select(.tool_use_id == $id)' "$HISTORY_FILE" 2>/dev/null | tail -1)
[ -z "$ENTRY" ] && exit 0

TOOL=$(printf '%s\n' "$ENTRY" | jq -r '.tool_name')
EVENT=$(printf '%s\n' "$ENTRY" | jq -r '.hook_event_name')
STATUS=""
[ "$EVENT" = "PreToolUse" ] && STATUS=" [REJECTED]"

printf "═══ TOOL: %s%s ═══\n\n" "$TOOL" "$STATUS"

if [ "$TOOL" = "Edit" ]; then
  FILE=$(printf '%s\n' "$ENTRY" | jq -r '.tool_input.file_path // ""')
  REPLACE_ALL=$(printf '%s\n' "$ENTRY" | jq -r '.tool_input.replace_all // false')
  [ "$REPLACE_ALL" = "true" ] && printf "  (replace all)\n"
  TMPOLD=$(mktemp) && TMPNEW=$(mktemp)
  trap 'rm -f "$TMPOLD" "$TMPNEW"' EXIT
  printf '%s\n' "$ENTRY" | jq -r '.tool_input.old_string // ""' > "$TMPOLD"
  printf '%s\n' "$ENTRY" | jq -r '.tool_input.new_string // ""' > "$TMPNEW"
  diff -u --label "a/$FILE" --label "b/$FILE" "$TMPOLD" "$TMPNEW" | delta --paging=never --width="${FZF_PREVIEW_COLUMNS:-80}" --line-numbers $([ "${DARK_MODE:-0}" = "0" ] && echo "--light")

elif [ "$TOOL" = "Write" ]; then
  FILE=$(printf '%s\n' "$ENTRY" | jq -r '.tool_input.file_path // ""')
  printf "► FILE: %s\n\n" "$FILE"
  printf '%s\n' "$ENTRY" | jq -r '.tool_input.content // ""'

elif [ "$TOOL" = "Bash" ]; then
  printf "► COMMAND:\n"
  printf '%s\n' "$ENTRY" | jq -r '.tool_input.command // ""'
  if [ "$EVENT" = "PostToolUse" ]; then
    STDOUT=$(printf '%s\n' "$ENTRY" | jq -r '.tool_response.stdout // ""')
    STDERR=$(printf '%s\n' "$ENTRY" | jq -r '.tool_response.stderr // ""')
    [ -n "$STDOUT" ] && printf "\n► STDOUT:\n%s\n" "$STDOUT"
    [ -n "$STDERR" ] && printf "\n► STDERR:\n%s\n" "$STDERR"
  fi

elif [ "$TOOL" = "Grep" ] || [ "$TOOL" = "Glob" ]; then
  printf '%s\n' "$ENTRY" | jq -r '.tool_input | to_entries | map("  \(.key): \(.value | if type == "string" then . else tostring end)") | join("\n")'
  if [ "$EVENT" = "PostToolUse" ]; then
    printf "\n► OUTPUT:\n"
    printf '%s\n' "$ENTRY" | jq -r 'if .tool_response.type == "text" then .tool_response.file.content // (.tool_response | tostring) else .tool_response | tostring end'
  fi

else
  printf "► INPUT:\n"
  printf '%s\n' "$ENTRY" | jq -r '.tool_input | to_entries | map("  \(.key): \(.value | if type == "string" then . else tostring end)") | join("\n")'
  if [ "$EVENT" = "PostToolUse" ]; then
    printf "\n► OUTPUT:\n"
    printf '%s\n' "$ENTRY" | jq -r 'if .tool_response.type == "text" then .tool_response.file.content // (.tool_response | tostring) else .tool_response | tostring end'
  fi
fi
