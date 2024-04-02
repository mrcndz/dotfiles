return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
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
          },
        },
        pickers = {
          git_commits = {
            mappings = {
              i = {
                ['<C-o>'] = function() -- show diffview for the selected commit
                  -- Open in diffview
                  local entry = action_state.get_selected_entry()
                  -- close Telescope window properly prior to switching windows
                  actions.close(vim.api.nvim_get_current_buf())
                  vim.cmd(('DiffviewOpen %s^!'):format(entry.value))
                end,
              },
            },
          },
          git_status = {
            mappings = {
              i = {
                ['<C-o>'] = function() -- show diffview for the selected file
                  -- Open in diffview
                  local entry = action_state.get_selected_entry()
                  -- close Telescope window properly prior to switching windows
                  actions.close(vim.api.nvim_get_current_buf())
                  print(entry.value)
                  local dotgitpath = vim.fn.finddir('.git', '.;')
                  vim.cmd(('DiffviewFileHistory ' .. vim.fn.fnamemodify(dotgitpath, ':h') .. '/' .. entry.value))
                end,
              },
            },
          },
          git_bcommits = {
            mappings = {
              i = {
                ['<C-o>'] = function() -- DiffviewOpen
                  -- Open in diffview
                  local entry = action_state.get_selected_entry()
                  -- close Telescope window properly prior to switching windows
                  actions.close(vim.api.nvim_get_current_buf())
                  vim.cmd(('DiffviewOpen %s^!'):format(entry.value))
                end,
              },
            },
          },
          git_branches = {
            mappings = {
              i = {
                ['<C-o>'] = function() -- show diffview comparing the selected branch with the current branch
                  -- Open in diffview
                  local entry = action_state.get_selected_entry()
                  -- close Telescope window properly prior to switching windows
                  actions.close(vim.api.nvim_get_current_buf())
                  vim.cmd(('DiffviewOpen %s..'):format(entry.value))
                end,
              },
            },
          },
        },
      })

      require('telescope').load_extension('emoji')
      require('telescope').load_extension('ui-select')
      vim.keymap.set('n', '<F1>', '<cmd>Telescope buffers theme=dropdown<cr>')
    end,
  },
}
