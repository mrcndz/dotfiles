return {
  {
    'smoka7/hop.nvim',
    version = '*',
    event = 'BufReadPost',
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
    keys = {
      { '<C-h>', '<cmd>NvimTmuxNavigateLeft<CR>', desc = 'Navigate Left' },
      { '<C-l>', '<cmd>NvimTmuxNavigateRight<CR>', desc = 'Navigate Right' },
      { '<C-j>', '<cmd>NvimTmuxNavigateDown<CR>', desc = 'Navigate Down' },
      { '<C-k>', '<cmd>NvimTmuxNavigateUp<CR>', desc = 'Navigate Up' },
    },
    config = function()
      require('nvim-tmux-navigation').setup {}
    end,
  },
}
