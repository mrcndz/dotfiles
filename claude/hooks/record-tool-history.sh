#!/bin/bash
# Log all tool uses to project's .claude/tool_history.jsonl

HISTORY_FILE="$CLAUDE_PROJECT_DIR/.claude/tool_history.jsonl"
LOCK_FILE="$HISTORY_FILE.lock"
MAX_LINES=1000
EXCLUDED='["Read"]'

mkdir -p "$CLAUDE_PROJECT_DIR/.claude"

# Filter excluded tools and read input
INPUT=$(jq -c --argjson excluded "$EXCLUDED" 'select(.tool_name as $t | $excluded | index($t) | not)')
[ -z "$INPUT" ] && exit 0

EVENT=$(printf '%s\n' "$INPUT" | jq -r '.hook_event_name')
TOOL_ID=$(printf '%s\n' "$INPUT" | jq -r '.tool_use_id')
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
ENTRY=$(printf '%s\n' "$INPUT" | jq -c --arg ts "$TIMESTAMP" '. + {timestamp: $ts}')

# All file operations under flock to prevent race conditions
exec 9>"$LOCK_FILE"
flock 9

# If PostToolUse, remove matching PreToolUse entry
if [ "$EVENT" = "PostToolUse" ] && [ -f "$HISTORY_FILE" ]; then
  jq -c --arg id "$TOOL_ID" 'select(.tool_use_id != $id or .hook_event_name != "PreToolUse")' "$HISTORY_FILE" > "$HISTORY_FILE.tmp" && mv "$HISTORY_FILE.tmp" "$HISTORY_FILE"
fi

# Append new entry
printf '%s\n' "$ENTRY" >> "$HISTORY_FILE"

# Rotate if file exceeds 2x max to avoid running tail on every write
LINE_COUNT=$(wc -l < "$HISTORY_FILE")
if [ "$LINE_COUNT" -gt $((MAX_LINES * 2)) ]; then
  tail -n "$MAX_LINES" "$HISTORY_FILE" > "$HISTORY_FILE.tmp" && mv "$HISTORY_FILE.tmp" "$HISTORY_FILE"
fi

flock -u 9
