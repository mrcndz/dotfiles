#!/bin/bash
# Usage: ha-switch.sh turn_on|turn_off
# HA_URL, HA_TOKEN and HA_ENTITY live in ~/.config/ha/env, outside the repo.
ACTION="$1"
CONFIG="$HOME/.config/ha/env"
LOG="$HOME/.config/ha/hammerspoon.log"
mkdir -p "$(dirname "$LOG")"
# shellcheck source=/dev/null
[ -f "$CONFIG" ] && . "$CONFIG"
if [ -z "${HA_URL:-}" ] || [ -z "${HA_TOKEN:-}" ] || [ -z "${HA_ENTITY:-}" ]; then
  echo " $(date) $ACTION skipped: set HA_URL, HA_TOKEN and HA_ENTITY in $CONFIG" >> "$LOG"
  exit 1
fi
curl -s -m 5 -X POST \
  -H "Authorization: Bearer $HA_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{\"entity_id\":\"$HA_ENTITY\"}" \
  "$HA_URL/api/services/switch/$ACTION" >> "$LOG" 2>&1
echo " $(date) $ACTION" >> "$LOG"
