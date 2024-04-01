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
          file_ignore_patterns = {
            '.git/',
            'node_modules/',
            'opt/',
            'Library/',
            '.DS_Store',
            '.AppleDouble',
            '.LSOverride',
            'opt/',
            'Music/',
            'Movies/',
            'Applications/',
            'Pictures/',
            'Remote/',
            'Icon',
            '.DocumentRevisions-V100',
            '.fseventsd',
            '.Spotlight-V100',
            '.TemporaryItems',
            '.Trashes',
            '.VolumeIcon.icns',
            '.com.apple.timemachine.donotpresent',
            'Downloads/',
            '.AppleDB',
            '.AppleDesktop',
            'Network Trash Folder',
            'Temporary Items',
            'Library/',
            'Photos Library.photoslibrary/',
            '.log',
            'Documents/',
            '*Google Drive',
          },
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
          git_bcommits = {
            mappings = {
              i = {
                ['<C-o>'] = function() -- show diffview for the selected commit of current buffer
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
