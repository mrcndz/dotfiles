return {
  {
    'smoka7/hop.nvim',
    version = '*',
    opts = {},
    config = function()
      local hop = require 'hop'
      local directions = require('hop.hint').HintDirection

      hop.setup {
        keys = 'etovxqpdygfblzhckisuran',
      }

      vim.keymap.set({ 'n', 'v' }, 't', function()
        hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = false }
      end, { remap = true })
      vim.keymap.set({ 'n', 'v' }, 'T', function()
        hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = false }
      end, { remap = true })
      vim.keymap.set({ 'n', 'v' }, 'gl', function()
        hop.hint_lines {}
      end, { remap = true })
    end,
  },
  {
    'alexghergh/nvim-tmux-navigation',
    config = function()
      require('nvim-tmux-navigation').setup {}
      local keymap = vim.keymap.set

      keymap({ 'n' }, '<C-h>', ':NvimTmuxNavigateLeft<CR>', { noremap = true, silent = true })
      keymap({ 'n' }, '<C-l>', ':NvimTmuxNavigateRight<CR>', { noremap = true, silent = true })
      keymap({ 'n' }, '<C-j>', ':NvimTmuxNavigateDown<CR>', { noremap = true, silent = true })
      keymap({ 'n' }, '<C-k>', ':NvimTmuxNavigateUp<CR>', { noremap = true, silent = true })
    end,
  },
}
