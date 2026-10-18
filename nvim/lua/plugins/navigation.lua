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
    'christoomey/vim-tmux-navigator',
    lazy = false,
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
    config = function()
      dofile(vim.fn.expand '~/Workspace/Repos/tern-kit/editor/nvim.lua')
    end,
  },
}
