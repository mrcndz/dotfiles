#!/bin/bash
# Preview a Claude session's conversation
# Args: session_id project_path
SID="$1"
PROJECT="$2"

# Build the claude project dir path
PROJ_DIR=$(echo "$PROJECT" | sed 's|/|-|g; s|^-||')
SESSION_FILE="$HOME/.claude/projects/-${PROJ_DIR}/${SID}.jsonl"

[ -f "$SESSION_FILE" ] || { echo "Session file not found"; exit 0; }

# Extract user/assistant messages
grep -E '"type":"(user|assistant)"' "$SESSION_FILE" | jq -r '
  (if .type == "user" then
    if (.message.content | type) == "string" then .message.content
    elif (.message.content | type) == "array" then [.message.content[] | select(.type == "text") | .text] | join(" ")
    else "" end | gsub("<[^>]*>"; "") | gsub("[\\n\\r]"; " ") | .[:200]
    | if length > 0 then "\u001b[36m▶ You:\u001b[0m " + . else empty end
  elif .type == "assistant" then
    if (.message.content | type) == "string" then .message.content
    elif (.message.content | type) == "array" then [.message.content[] | select(.type == "text") | .text] | join(" ")
    else "" end | gsub("[\\n\\r]"; " ") | .[:200]
    | if length > 0 then "\u001b[33m◀ Claude:\u001b[0m " + . else empty end
  else empty end)
' 2>/dev/null | tac | head -30
