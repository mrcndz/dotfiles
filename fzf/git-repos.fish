function git-repos
    set -l repo (fd -t d -H '^.git$' ~/Workspace --max-depth 4 --prune -x echo {//} | \
        awk 'NR==FNR {scores[$2]=$1+0; next} {print (($0 in scores) ? scores[$0] : 0) "\t" $0}' \
            (zoxide query -ls | psub) - | sort -rn -t\t -k1 | cut -f2 | \
        fzf --prompt="Repo> " --height=100% --reverse \
            --header='enter: cd | ctrl-n: claude | ctrl-o: github | ctrl-p: PRs | ctrl-g: lazygit' \
            --expect='ctrl-n,ctrl-o,ctrl-p,ctrl-g' \
            --preview='git -C {} log --oneline --color=always -20' \
            --preview-window='right:50%')

    set -l key $repo[1]
    set -l dir $repo[2]

    test -z "$dir"; and return 1

    switch $key
        case ctrl-n
            echo "claude $dir"
        case ctrl-o
            echo "open $dir"
        case ctrl-g
            echo "lazygit $dir"
        case ctrl-p
            echo "prs $dir"
        case '*'
            echo "cd $dir"
    end
end

function git-repos-prs --argument-names dir
    set -l pr (gh pr list -R (git -C "$dir" remote get-url origin) --json number,title,author,headRefName \
        --jq '.[] | "#\(.number) \(.title) (\(.author.login)) [\(.headRefName)]"' 2>/dev/null | \
        fzf --prompt="PR> " --height=40% --reverse \
            --header='enter: open in browser')

    test -z "$pr"; and return 1

    set -l number (string match -r '#(\d+)' $pr)[2]
    echo "pr $dir $number"
end
