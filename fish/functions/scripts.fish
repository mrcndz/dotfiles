function __fzf_open_file_with_nvim
    set -l selected $(fzf)
    nvim $selected

    cat $selected >>fzf
end

function __cd_back_to
    set target (string match -r ".*$argv" (pwd))
    if test -d $target
        cd $target
    else
        # Try matching a substring if the exact match fails
        set target (string match -r ".*$argv.*" (pwd))
        if test -d $target
            cd $target
        else
            echo "Directory $argv not found in path"
        end
    end
end
