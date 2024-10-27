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
      local utils = require('utils')

      local open_buffer_vsplit = function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        local bufnr = utils.get_bufnr(selection.value)

        if bufnr then
          vim.api.nvim_command('vsplit #' .. bufnr)
        else
          vim.api.nvim_command('vsplit ' .. selection.value)
        end
      end

      local open_buffer_split = function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local bufnr = utils.get_bufnr(selection.value)
        actions.close(prompt_bufnr)

        if bufnr then
          vim.api.nvim_command('split #' .. bufnr)
        else
          vim.api.nvim_command('split ' .. selection.value)
        end
      end

      local open_buffer_only = function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local bufnr = utils.get_bufnr(selection.value)
        actions.close(prompt_bufnr)

        if bufnr then
          vim.api.nvim_command('b ' .. bufnr)
        else
          vim.api.nvim_command('edit ' .. selection.value)
        end

        vim.api.nvim_command('only')
      end

      require('telescope').setup({
        defaults = {
          file_ignore_patterns = {},
          mappings = {
            i = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-u>'] = actions.preview_scrolling_up,
              ['<C-d>'] = actions.preview_scrolling_down,
              ['<C-|'] = actions.file_vsplit,
              ['<C-_'] = actions.file_split,
            },
            n = {
              ['q'] = actions.close,
              ['-'] = actions.file_split,
              ['|'] = actions.file_vsplit,
            },
          },
        },
        pickers = {
          buffers = {
            initial_mode = 'normal',
            sort_lastused = true,
            sort_mru = true,
            mappings = {
              i = { ['<C-x>'] = actions.delete_buffer },
              n = {
                ['d'] = actions.delete_buffer,
                ['|'] = open_buffer_vsplit,
                ['-'] = open_buffer_split,
                ['e'] = open_buffer_only,
              },
            },
          },
        },
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
      })

      require('telescope').load_extension('emoji')
      require('telescope').load_extension('ui-select')
      require('telescope').load_extension('fzf')
    end,
  },
}
