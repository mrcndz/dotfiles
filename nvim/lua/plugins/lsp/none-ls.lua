return {
    'nvimtools/none-ls.nvim',
    ft = { "python" },
    opts = function()
        local null_ls = require("null-ls")

        return {
            sources = {
                -- Diagnostics
                null_ls.builtins.diagnostics.mypy,
                -- Formatting
                null_ls.builtins.formatting.isort,
                -- Code Actions
                null_ls.builtins.code_actions.refactoring,
            },
        }
    end
}
