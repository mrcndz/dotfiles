return {
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    config = function()
      require("everforest").setup({})
    end,
  },
  {
    'ramojus/mellifluous.nvim',
    -- version = "v0.*", -- uncomment for stable config (some features might be missed if/when v1 comes out)
    priority = 1000,
    config = function()
        require'mellifluous'.setup({
            comments = { italic = true },
            transparent_background = {
            enabled = true,
            floating_windows = true,
            telescope = true,
            file_tree = true,
            cursor_line = true,
            status_line = false,
            },
        })
    end,
  }
}
