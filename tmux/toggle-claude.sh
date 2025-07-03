#!/bin/bash

# Exit if not in a tmux session
if ! command -v tmux &> /dev/null || ! tmux info &> /dev/null; then
    exit 1
fi

# -- Configuration
PANE_TITLE="claude-pane"
CLAUDE_COMMAND="claude --continue"

# Find pane by its exact title
PANE_ID=$(tmux list-panes -F "#{pane_id} #{pane_title}" | grep -w "$PANE_TITLE" | awk '{print $1}')

# If pane not found, create it. Otherwise, focus it.
if [ -z "$PANE_ID" ]; then
  # Create pane in the current directory (-c), set title, then run command
  tmux split-window -h -l 30% -c "#{pane_current_path}" "tmux select-pane -T '$PANE_TITLE'; $CLAUDE_COMMAND"
else
  # Focus existing pane
  tmux select-pane -t "$PANE_ID"
fi
