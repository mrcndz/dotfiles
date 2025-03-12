local esc = vim.api.nvim_replace_termcodes('<esc>', true, false, true)
vim.api.nvim_feedkeys(esc, 'n', false)

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  ---
  keys = {
    {
      '<leader>F',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>e',
      function()
        Snacks.explorer.toggle()
      end,
      desc = 'File Explorer',
    },
    {
      '<leader><leader>',
      function()
        Snacks.picker.buffers()
        feed_esc()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>f',
      function()
        Snacks.picker.files()
        feed_esc()
      end,
      desc = 'Buffers',
    },
  },
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = false },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
}
