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
      local nnoremap = require('utils').nnoremap
      nnoremap('<C-h>', ':NvimTmuxNavigateLeft<CR>')
      nnoremap('<C-l>', ':NvimTmuxNavigateRight<CR>')
      nnoremap('<C-j>', ':NvimTmuxNavigateDown<CR>')
      nnoremap('<C-k>', ':NvimTmuxNavigateUp<CR>')
    end,
  },
}
