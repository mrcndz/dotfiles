return {
  {
    'marko-cerovac/material.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.material_style = 'deep ocean'

      local hour = tonumber(os.date('%H'))
      if hour > 7 and hour < 17 then
        vim.g.material_style = 'lighter'
      end
    end,
    config = function()
      require('material').setup({
        disable = {
          background = false,
        },
        lualine_style = 'stealth',
      })

      vim.cmd('colorscheme material')
    end,
  },
}
