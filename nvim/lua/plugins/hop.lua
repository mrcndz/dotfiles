return {
  'smoka7/hop.nvim',
  version = '*',
  opts = {},
  config = function()
    local hop = require 'hop'
    local opts = { silent = true, noremap = false }
    local keymap = vim.api.nvim_set_keymap
    local directions = require('hop.hint').HintDirection

    hop.setup {
      keys = 'etovxqpdygfblzhckisuran',
    }

    local directions = require('hop.hint').HintDirection
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
}

