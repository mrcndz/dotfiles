return {
  {
    'romgrk/barbar.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    init = function()
      vim.g.barbar_auto_setup = false
      vim.cmd('hi BufferDefaultCurrentMod guifg=black')
    end,
    opts = {
      exclude_ft = { 'javascript' },
      exclude_name = { 'package.json' },
      focus_on_close = 'left',
      hide = { extensions = false, inactive = false },
      highlight_alternate = false,
      highlight_inactive_file_icons = false,
      highlight_visible = false,
      icons = {
        buffer_index = true,
        buffer_number = false,
        button = '×',
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true, icon = '' },
          [vim.diagnostic.severity.WARN] = { enabled = false },
          [vim.diagnostic.severity.INFO] = { enabled = false },
          [vim.diagnostic.severity.HINT] = { enabled = false, icon = '' },
        },
        filetype = {
          custom_colors = false,
          enabled = true,
        },
        separator_at_end = true,
        modified = { button = '●' },
        pinned = { button = '󰐃', filename = true },

        preset = 'default',

        alternate = { filetype = { enabled = false } },
        current = { buffer_index = true },
        inactive = { button = '' },
        visible = { modified = { buffer_number = false } },
      },
      sidebar_filetypes = {
        NvimTree = true,
      },
    },
  },
}
