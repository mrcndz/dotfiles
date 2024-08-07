return {
    'Vonr/align.nvim',
    branch = "v2",
    lazy = true,
    config = function()
        vim.api.nvim_create_user_command('AlignChar', function()
            require 'align'.align_to_char({
                preview = true,
                length = 1,
            })
        end, {})
        vim.api.nvim_create_user_command('AlignString', function()
            require 'align'.align_to_string({
                preview = true,
                regex = false,
            })
        end, {})
        vim.api.nvim_create_user_command('AlignRegex', function()
            require 'align'.align_to_string({
                preview = true,
                regex = true,
            })
        end, {})
    end
}
