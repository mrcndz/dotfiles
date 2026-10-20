#!/usr/bin/env bash
# herdr event hook: report the focused pane's directory to Tern with OSC 7.
# Tern sees all of herdr as one block, so write the sequence to the tty of each
# herdr client running inside Tern; Tern's Files pane follows that block's cwd.
set -uo pipefail

herdr="${HERDR_BIN_PATH:-herdr}"
{ read -r focused; read -r cwd; } < <(
    "$herdr" pane get "${HERDR_PANE_ID:?}" | jq -r '.result.pane | .focused, (.foreground_cwd // .cwd)'
)
# Remote panes have no local directory
[ "$focused" = true ] && [ -d "$cwd" ] || exit 0

url="file://$(hostname)$(jq -rn --arg p "$cwd" '$p | @uri | gsub("%2F"; "/")')"
for pid in $(pgrep -x herdr); do
    ps eww -o command= -p "$pid" | grep -q ' TERN_PANE=' || continue
    tty="$(ps -o tty= -p "$pid" | tr -d ' ')"
    [ -w "/dev/$tty" ] && printf '\033]7;%s\033\\' "$url" >"/dev/$tty"
done
