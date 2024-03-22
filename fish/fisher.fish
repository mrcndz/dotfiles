function install_plugins --description 'Install fisher'
    if not functions -q fisher
        echo "Fisher not found, installing..."
        __install_fisher__
    end

    if test -f plugins.txt
        while read -r line
            fisher_plugin_install $line
        end <plugins.txt
    end

    echo OK
end

function __install_fisher__
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
end

function fisher_plugin_install
    if not fisher list | grep -qi $argv
        echo $argv >>$__fish_config_dir/fish_plugins
        if not set -q was_run_fisher_update
            fisher update
            set -g was_run_fisher_update 0
        end
    end
end

install_plugins
