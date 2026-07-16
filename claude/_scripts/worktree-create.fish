#!/usr/bin/env fish

# Receives JSON payload on stdin: {name, cwd, ...}
# Must create a git worktree and echo its absolute path.

set -l payload (cat)
set -l name (echo $payload | jq -r '.name')
set -l cwd (echo $payload | jq -r '.cwd')
set -l wt_path "$cwd/.claude/worktrees/$name"
set -l branch "claude/$name"

cd $cwd

mkdir -p "$cwd/.claude/worktrees"
git worktree add -b $branch $wt_path HEAD >&2

# Copy .worktreeinclude files into new worktree
if test -f .worktreeinclude
    for file in (git ls-files --others --ignored --exclude-from=.worktreeinclude)
        mkdir -p (dirname $wt_path/$file)
        cp $file $wt_path/$file
    end
end

# Pane-scoped worktree dir for tmux bindings/status
if test -n "$TMUX"
    tmux set -p @worktree_dir "$wt_path"
end

echo $wt_path
