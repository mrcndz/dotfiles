function install_fisher
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
end

function update_fisher
    curl -sL https://git.io/fisher | source && fisher update
end
