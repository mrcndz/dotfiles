return {
  {
    'marko-cerovac/material.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('material').setup({
        disable = {
          background = true,
        },
      })

      vim.cmd('colorscheme material')
    end,
  },
}
