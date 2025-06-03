return {
  'nvim-treesitter/nvim-treesitter',

  dependencies = {
    'windwp/nvim-ts-autotag',
    'RRethy/nvim-treesitter-endwise',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },

  build = ':TSUpdate',
  event = 'bufWinEnter',

  config = function()
    local treesitter = require 'nvim-treesitter.configs'
    treesitter.setup {
      ensure_installed = {
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
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      autotag = {
        enable = true,
      },
      endwise = {
        enable = true,
      },
      indent = {
        enable = false,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
          selection_modes = {
            ['@function.outer'] = 'V',
            ['@function.inner'] = 'V',
            ['@class.outer'] = '<c-v>',
            ['@class.inner'] = 'V',
          },
          include_surrounding_whitespace = true,
        },
      },
    }
  end,
}
