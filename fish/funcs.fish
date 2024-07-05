set -gx NVIM_RECENTS_PATH $DOTFILES/data
set -gx NVIM_RECENTS_FILE $NVIM_RECENTS_PATH/nvim_recents.txt

function __save_path_to_recents

    if test -d $NVIM_RECENTS_PATH
        set -l nvim_recents (cat $NVIM_RECENTS_FILE)
    else
        mkdir -p $NVIM_RECENTS_PATH
        set -l nvim_recents ""
    end

    set -l new_recent $(pwd)
    if not contains $new_recent $nvim_recents
        echo $new_recent >>$NVIM_RECENTS_PATH
    end
end

function __fzf_nvim_recents

    set -l nvim_recents (cat $NVIM_RECENTS_PATH)

    set -l fzf_query (cat $NVIM_RECENTS_PATH)

    if test -z $fzf_query
        set fzf_query (pwd)
    end

    fzf --query=$fzf_query --select-1 --exit-0 --multi --preview="nvim --cmd 'set ft? ft' --cmd 'set nu? nu' --cmd 'set nuw? nuw' --cmd 'set hidden? hidden' --cmd 'set nonu? nonu' --cmd 'set nornu? nornu' --cmd 'set nornuw? nornuw' {}"
end
