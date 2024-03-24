return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'xiyaowong/telescope-emoji.nvim',
    },
    config = function()
      local builtin = require('telescope.builtin')
      local actions = require('telescope.actions')

      require('telescope').setup({
        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown({}) },
        },
        defaults = {
          -- outras configurações padrão
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
      })

      require('telescope').load_extension('emoji')
    end,
  },
}
