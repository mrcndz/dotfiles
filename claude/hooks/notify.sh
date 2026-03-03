#!/bin/bash
# Send push notification via Moshius
TITLE="${1:-Done}"
MESSAGE="${2:-Task finished}"

curl -s -X POST https://api.getmoshi.app/api/webhook \
  -H "Content-Type: application/json" \
  -d "{\"token\":\"REDACTED_MOSHIUS_TOKEN\",\"title\":\"$TITLE\",\"message\":\"$MESSAGE\"}"
