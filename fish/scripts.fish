function __fzf_open_file_with_nvim
    set -l selected $(fzf)
    nvim $selected

    cat $selected >>fzf
end
