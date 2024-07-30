return {
  {
    'sho-87/kanagawa-paper.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    init = function()
      vim.cmd('colorscheme kanagawa-paper')
    end,
  },
}
