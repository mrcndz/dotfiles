#!/usr/bin/env fish

if test (count $argv) -eq 0
    exit 1
end

set TARGET_DIR $argv[1]
set DIR_BASENAME (basename "$TARGET_DIR" | tr '.-' '__')
# Set the option name
set TMUX_OPTION "@claude_pane_id_$DIR_BASENAME"
set PANE_ID (tmux show-options -gv "$TMUX_OPTION" 2>/dev/null)

# If the pane exists, select it
if test -n "$PANE_ID"; and tmux list-panes -t "$PANE_ID" &>/dev/null
    tmux select-pane -t "$PANE_ID"
else
    # If the pane doesn't exist, create it
    set NEW_PANE_ID (tmux split-window -h -l '40%' -P -F '#{pane_id}' -c "$TARGET_DIR" "cd $argv[1] && claude --continue || claude")
    tmux set-option -g "$TMUX_OPTION" "$NEW_PANE_ID"
    tmux set-option -p -t "$NEW_PANE_ID" @is_claude_pane true
end
