local function restore_nvim_tree()
    local nvim_tree_api = require('nvim-tree.api')

    nvim_tree_api.tree.search_node(vim.fn.getcwd())
end

return {
    {
        'rmagatti/auto-session',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        init = function()
            vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
        end,
        config = function()
            require('auto-session').setup({
                auto_create = function()
                    local cmd = 'git rev-parse --is-inside-work-tree'
                    return vim.fn.system(cmd) == 'true\n'
                end,
                auto_save_enabled = true,
                auto_restore_enabled = true,
                log_level = 'error',
                post_restore_cmds = { restore_nvim_tree },
                auto_session_suppress_dirs = {
                    '~/',
                    '~/.temp/',
                    '~/temp',
                    '~/Downloads',
                },
            })
        end,
    },
}
