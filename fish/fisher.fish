function __install_fisher__
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
end

function fisher_plugin_install
    if not functions -q fisher
        install_fisher
    end

    if not fisher list | grep -qi $argv
        echo $argv >> $__fish_config_dir/fish_plugins
        if not set -q was_run_fisher_update
            fisher update
            set -g was_run_fisher_update 0
        end
    end
end
