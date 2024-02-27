return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
    },
    config = function()
        local hooks = require "ibl.hooks"
        require("ibl").setup {
            whitespace = {
                remove_blankline_trail = false,
            },
        }
        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end
}
