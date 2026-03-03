#!/usr/bin/env fish

source $DOTFILES/fzf/git-repos.fish
source $DOTFILES/fzf/claude-sessions.fish

set -l action ($DOTFILES/tmux/popup-capture.fish "fish -c 'source $DOTFILES/fzf/git-repos.fish; git-repos'")

test -z "$action"; and exit 0

set -l parts (string split ' ' $action)

switch $parts[1]
    case claude
        set -l dir $parts[2]
        set -l name (_claude_next_name (basename "$dir"))
        tmuxinator start claude dir="$dir" repo=(basename "$dir") name="$name" claude_args="--continue" --no-attach
        tmux switch-client -t "$name$CLAUDE_PANE" 2>/dev/null; or tmux switch-client -t "$name:claude"
    case open
        gh browse -R (git -C "$parts[2]" remote get-url origin)
    case lazygit
        tmux display-popup -d "$parts[2]" -xC -yC -w80% -h80% -E "lazygit"
    case prs
        set -l pr_action ($DOTFILES/tmux/popup-capture.fish "fish -c 'source $DOTFILES/fzf/git-repos.fish; git-repos-prs $parts[2]'")
        test -z "$pr_action"; and exit 0
        set -l pr_parts (string split ' ' $pr_action)
        gh pr view $pr_parts[3] -R (git -C "$pr_parts[2]" remote get-url origin) --web
    case cd
        tmux send-keys "cd $parts[2]" Enter
end
