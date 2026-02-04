#!/bin/bash
# Log all tool uses to project's .claude/tool_history.jsonl

HISTORY_FILE="$CLAUDE_PROJECT_DIR/.claude/tool_history.jsonl"
MAX_LINES=1000
EXCLUDED='["Read", "Write", "Edit", "Update"]'

mkdir -p "$CLAUDE_PROJECT_DIR/.claude"

# Filter excluded tools and read input
INPUT=$(jq -c --argjson excluded "$EXCLUDED" 'select(.tool_name as $t | $excluded | index($t) | not)')
[ -z "$INPUT" ] && exit 0

EVENT=$(echo "$INPUT" | jq -r '.hook_event_name')
TOOL_ID=$(echo "$INPUT" | jq -r '.tool_use_id')

# If PostToolUse, remove matching PreToolUse first
if [ "$EVENT" = "PostToolUse" ] && [ -f "$HISTORY_FILE" ]; then
  jq -c --arg id "$TOOL_ID" 'select(.tool_use_id != $id or .hook_event_name != "PreToolUse")' "$HISTORY_FILE" > "$HISTORY_FILE.tmp" && mv "$HISTORY_FILE.tmp" "$HISTORY_FILE"
fi

# Add timestamp and append
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
echo "$INPUT" | jq -c --arg ts "$TIMESTAMP" '. + {timestamp: $ts}' >> "$HISTORY_FILE"
tail -n $MAX_LINES "$HISTORY_FILE" > "$HISTORY_FILE.tmp" && mv "$HISTORY_FILE.tmp" "$HISTORY_FILE"
