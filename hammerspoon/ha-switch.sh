#!/bin/bash
# Usage: ha-switch.sh turn_on|turn_off
ACTION="$1"
ENTITY="switch.tomada_da_sala_switch_1"
HA_TOKEN=$(/opt/homebrew/bin/fish -c 'source $HOME/Workspace/Repos/dotfiles/env.fish; echo $HA_TOKEN')
HA_URL=$(/opt/homebrew/bin/fish -c 'source $HOME/Workspace/Repos/dotfiles/env.fish; echo $HA_URL')
LOG="$HOME/.config/ha/hammerspoon.log"
mkdir -p "$(dirname "$LOG")"
curl -s -m 5 -X POST \
  -H "Authorization: Bearer $HA_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{\"entity_id\":\"$ENTITY\"}" \
  "$HA_URL/api/services/switch/$ACTION" >> "$LOG" 2>&1
echo " $(date) $ACTION" >> "$LOG"
