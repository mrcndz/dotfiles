local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

vim.keymap.set('n', '<A-f>', builtin.find_files, {})

require('telescope').setup{
  defaults = {
    -- outras configurações padrão
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-u>"] = actions.results_scrolling_up
        ["<C-d>"] = actions.results_scrolling_down
      },
    },
  }
}
