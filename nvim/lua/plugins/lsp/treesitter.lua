return {
  'nvim-treesitter/nvim-treesitter',

  dependencies = {
    'windwp/nvim-ts-autotag',
  },

  build = ':TSUpdate',
  event = 'bufWinEnter',

  config = function()
    local treesitter = require('nvim-treesitter.configs')
    treesitter.setup({
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
      indent = {
        enable = false,
      },
    })
  end,
}
