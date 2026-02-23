function claude-tools --argument-names dir
    set -l hfile (test -n "$dir"; and echo $dir; or pwd)/.claude/tool_history.jsonl
    test -f $hfile; or return 1
    jq -r '"\(.timestamp // "")|\(.tool_use_id)|\(.tool_name)|\(.hook_event_name)|\(
      if .tool_name == "Bash" then .tool_input.command[:80]
      elif .tool_name == "Grep" then .tool_input.pattern
      elif .tool_name == "Glob" then .tool_input.pattern
      else (.tool_input | tostring)[:60]
      end)"' $hfile | sort -r | \
    fzf --delimiter='|' \
        --with-nth='1,3,5' \
        --preview="$DOTFILES/scripts/claude-tools-preview.sh {2} $hfile" \
        --preview-window='right:60%' \
        --bind='ctrl-y:execute-silent(echo {5} | pbcopy)' \
        --header='ctrl-y: copy input'
end

function claude-tools-popup --argument-names dir
    set -l target (test -n "$dir"; and realpath $dir; or pwd)
    $DOTFILES/tmux/popup-capture.fish "fish -c 'source $DOTFILES/fzf/claude-tools.fish; claude-tools $target'"
end
