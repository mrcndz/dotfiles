#!/usr/bin/env fish

# Exit if not in a tmux session
if not command -v tmux &>/dev/null; or not tmux info &>/dev/null
    exit 1
end

# -- Configuration
set PANE_TITLE claude-pane

set CLAUDE_CONTINUE_COMMAND "claude --continue"
set CLAUDE_COMMAND claude

# Check if the current directory has a session to resume
ls $HOME/.claude/projects | sed 's/--/-./g' | sed 's/-/\//g' | grep (pwd)'$' >/dev/null

if test $status -eq 0
    echo 'Resuming claude session'
    set CLAUDE_COMMAND $CLAUDE_CONTINUE_COMMAND
end

# Find pane by its exact title
set PANE_ID (tmux list-panes -F "#{pane_id} #{pane_title}" | grep -w "$PANE_TITLE" | awk '{print $1}')

# If pane not found, create it. Otherwise, focus it.
if test -z "$PANE_ID"
    # Create pane in the current directory (-c), set title, then run command
    tmux split-window -v -l 30% -c "#{pane_current_path}" "tmux select-pane -T '$PANE_TITLE'; $CLAUDE_COMMAND"
else
    # Focus existing pane
    tmux select-pane -t "$PANE_ID"
end

