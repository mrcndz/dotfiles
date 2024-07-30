return {
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'xiyaowong/telescope-emoji.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
      local builtin = require('telescope.builtin')
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')

      require('telescope').setup({
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
          ['ui-select'] = { require('telescope.themes').get_dropdown({}) },
        },
        defaults = {
          file_ignore_patterns = {},
          mappings = {
            i = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-u>'] = actions.preview_scrolling_up,
              ['<C-d>'] = actions.preview_scrolling_down,
            },
            n = { ['q'] = actions.close },
          },
          pickers = {
            buffers = {
              initial_mode = 'normal',
              sort_lastused = true,
              sort_mru = true,
              mappings = {
                i = { ['<C-x>'] = actions.delete_buffer },
                n = { ['x'] = actions.delete_buffer },
              },
            },
          },
        },
      })

      require('telescope').load_extension('emoji')
      require('telescope').load_extension('ui-select')
      vim.keymap.set('n', '<F1>', '<cmd>Telescope buffers theme=dropdown<cr>')
      require('telescope').load_extension('fzf')
    end,
  },
}
