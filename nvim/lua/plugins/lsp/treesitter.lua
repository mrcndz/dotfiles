return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    dependencies = {
      'RRethy/nvim-treesitter-endwise',
    },
    config = function()
      require('nvim-treesitter').install {
        'bash',
        'c',
        'css',
        'git_config',
        'go',
        'html',
        'javascript',
        'json',
        'python',
        'toml',
        'rust',
        'jsdoc',
        'fish',
        'lua',
        'sql',
        'typescript',
        'xml',
        'yaml',
        'markdown',
        'markdown_inline',
      }

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('nvim-treesitter-textobjects').setup {
        select = {
          lookahead = true,
          selection_modes = {
            ['@function.outer'] = 'V',
            ['@function.inner'] = 'V',
            ['@class.outer'] = 'V',
            ['@class.inner'] = 'V',
          },
          include_surrounding_whitespace = true,
        },
      }

      local select = require 'nvim-treesitter-textobjects.select'
      local maps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      }
      for key, obj in pairs(maps) do
        vim.keymap.set({ 'x', 'o' }, key, function()
          select.select_textobject(obj, 'textobjects')
        end, { desc = 'Select ' .. obj })
      end
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
}
