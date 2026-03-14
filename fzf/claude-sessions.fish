function _claude_next_name --argument-names base
    set -l sessions (tmux list-sessions -F '#{session_name}' 2>/dev/null | grep '^claude-')
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

function _claude_session_list
    lua "$DOTFILES/claude/_scripts/session-list.lua"
end

function claude-sessions --argument-names dir
    set -l target (test -n "$dir"; and echo $dir; or pwd)

    while true
        set -l items (_claude_session_list)

        if test -z "$items"
            echo "create $target"
            return 0
        end

        set -l preview "$DOTFILES/claude/_scripts/session-preview.sh {1} {5}"
        set -l result (printf '%s\n' $items | \
            fzf --prompt="Claude> " --height=100% --reverse \
                --ansi \
                --delimiter='\t' \
                --with-nth='2' \
                --header='enter: open | ctrl-n: new' \
                --expect='ctrl-n' \
                --preview="$preview" \
                --preview-window='down:40%:wrap')

        set -l key $result[1]
        set -l selected $result[2]

        if test "$key" = ctrl-n
            echo "create $target"
            return 0
        else if test -z "$selected"
            return 1
        end

        set -l parts (string split \t $selected)
        set -l sid $parts[1]
        set -l tmux_sess $parts[3]
        set -l tmux_pane $parts[4]
        set -l project_path $parts[5]

        if test -n "$tmux_pane"
            echo "focus $tmux_sess $tmux_pane"
            return 0
        end

        echo "resume $project_path $sid"
        return 0
    end
end

function claude-sessions-exec --argument-names action_str
    set -l parts (string split ' ' $action_str)
    set -l cmd $parts[1]

    switch $cmd
        case create
            set -l target $parts[2]
            set -l name (_claude_next_name "claude-"(basename "$target"))
            tmux new-session -d -s "$name" -c "$target"
            tmux send-keys -t "$name" "claude" Enter
            tmux switch-client -t "$name"
        case focus
            set -l tmux_sess $parts[2]
            set -l tmux_pane $parts[3]
            tmux switch-client -t "$tmux_sess"
            tmux select-pane -t "$tmux_pane"
        case resume
            set -l target $parts[2]
            set -l session_id $parts[3]
            set -l name (_claude_next_name "claude-"(basename "$target"))
            tmux new-session -d -s "$name" -c "$target"
            tmux send-keys -t "$name" "claude --resume $session_id" Enter
            tmux switch-client -t "$name"
    end
end
