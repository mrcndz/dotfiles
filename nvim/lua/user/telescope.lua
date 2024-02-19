local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
require('telescope').load_extension('bookmarks')

vim.keymap.set('n', '<F2>', builtin.find_files, {})

require('telescope').setup{
  defaults = {
    -- outras configurações padrão
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-u>"] = actions.results_scrolling_up,
        ["<C-d>"] = actions.results_scrolling_down
      },
    },
  }
}

