return {
  'axkirillov/hbac.nvim',
  config = function()
    require('hbac').setup {
      threshold = 5,
    }
  end,
}
