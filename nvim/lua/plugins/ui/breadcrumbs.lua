return {
  {
    'Bekaboo/dropbar.nvim',
    event = 'BufReadPost',
    config = function()
      require('dropbar').setup { enable = true }
    end,
  },
}
