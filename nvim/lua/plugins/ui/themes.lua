return {
  {
    'marko-cerovac/material.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.material_style = 'deep ocean'
    end,
    config = function()
      require('material').setup({
        disable = {
          background = false,
        },
      })

      vim.cmd('colorscheme material')
    end,
  },
}
