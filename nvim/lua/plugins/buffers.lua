return {
  'axkirillov/hbac.nvim',
  event = 'BufReadPost',
  config = function()
    require('hbac').setup {
      threshold = 6,
    }
  end,
}
