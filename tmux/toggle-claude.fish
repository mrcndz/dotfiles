#!/usr/bin/env fish

# Exit if not in a tmux session
if not command -v tmux &>/dev/null; or not tmux info &>/dev/null
    exit 1
end

# -- Configuration
set PANE_TITLE claude
set CLAUDE_CONTINUE_COMMAND "claude --continue"
set CLAUDE_COMMAND claude

if not test -d "$argv"
    echo "error dir: $argv"
    exit 2
end

cd $argv

ls $HOME/.claude/projects | sed 's/--/-./g' | sed 's/-/\//g' | grep (pwd)'$' >/dev/null

if test $status -eq 0
    # echo 'Resuming claude session'
    set CLAUDE_COMMAND $CLAUDE_CONTINUE_COMMAND
end

# Find pane by its exact title
set PANE_ID (tmux list-panes -F "#{pane_id} #{pane_title}" | grep -w "$PANE_TITLE" | awk '{print $1}')

if test -z "$PANE_ID"
    # If found, parse it. Otherwise, use current dir as fallback.
    if test $status -eq 0
        set project_path (echo "$tmux_var" | string split -m 1 -r '=')[2]
    else
        set project_path (pwd)
    end

    # Create pane with the resolved path, set title, then run command
    # echo "Creating new claude pane"
    tmux split-window -v -l 30% -c "$project_path" "tmux select-pane -T '$PANE_TITLE'; $CLAUDE_COMMAND && exit"
else
    # echo "Resuming existing claude session"
    tmux select-pane -t "$PANE_ID"
end
