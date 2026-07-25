return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = 'markdown',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    { 'echasnovski/mini.icons', config = function() require('mini.icons').setup() end },
  },
  opts = {},
}
