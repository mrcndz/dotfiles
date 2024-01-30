local status_ok, hop = pcall(require, "hop")
if not status_ok then
  return
end

-- remap default vim bindings
local opts = { silent = true , noremap=false }
local keymap = vim.api.nvim_set_keymap
local directions = require('hop.hint').HintDirection
hop.setup {
  keys = 'etovxqpdygfblzhckisuran'
}
local directions = require('hop.hint').HintDirection
vim.keymap.set({'n', 'v'}, 't', function()
   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false})
end, {remap=true})
vim.keymap.set({'n', 'v'}, 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false})
end, {remap=true})
vim.keymap.set({'n', 'v'}, 'gj', function()
  hop.hint_lines({ direction = directions.AFTER_CURSOR })
end, {remap=true})
vim.keymap.set({'n', 'v'}, 'gk', function()
  hop.hint_lines({ direction = directions.BEFORE_CURSOR })
end, {remap=true})
