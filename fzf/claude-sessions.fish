set -g CLAUDE_PANE ":claude.2"

function _claude_next_name --argument-names repo
    set -l sessions (tmux list-sessions -F '#{session_name}' 2>/dev/null | grep '^claude-')
    set -l base "claude-$repo"
    if not contains "$base" $sessions
        echo $base
        return
    end
    set -l i 1
    while contains "$base-$i" $sessions
        set i (math $i + 1)
    end
    echo "$base-$i"
end

# Outputs an action string, does NOT execute it
function claude-sessions --argument-names dir
    set -l target (test -n "$dir"; and echo $dir; or pwd)

    while true
        set -l sessions (tmux list-sessions -F '#{session_name}' 2>/dev/null | grep '^claude-')

        if test -z "$sessions"
            echo "create $target --continue"
            return 0
        end

        set -l result (printf '%s\n' $sessions | \
            fzf --prompt="Claude session> " --height=40% --reverse \
                --header='enter: switch | ctrl-x: kill | ctrl-n: new' \
                --expect='ctrl-x,ctrl-n')

        set -l key $result[1]
        set -l session $result[2]

        if test "$key" = ctrl-n
            echo "create $target"
            return 0
        else if test -z "$session"
            return 1
        else if test "$key" = ctrl-x
            set -l confirm (printf "yes\nno" | fzf --prompt="Kill $session? " --height=40% --reverse)
            if test "$confirm" = yes
                tmux kill-session -t "$session"
            end
            # Loop back to session list
        else
            echo "switch $session"
            return 0
        end
    end
end

# Executes an action string from claude-sessions
function claude-sessions-exec --argument-names action_str
    set -l parts (string split ' ' $action_str)
    set -l cmd $parts[1]

    switch $cmd
        case create
            set -l target $parts[2]
            set -l claude_args $parts[3]
            set -l name (_claude_next_name (basename "$target"))
            tmuxinator start claude dir="$target" repo=(basename "$target") name="$name" claude_args="$claude_args" --no-attach
            tmux switch-client -t "$name$CLAUDE_PANE" 2>/dev/null; or tmux switch-client -t "$name:claude"
        case switch
            tmux switch-client -t "$parts[2]$CLAUDE_PANE" 2>/dev/null; or tmux switch-client -t "$parts[2]:claude"
    end
end
