return {
  {
    'ramilito/winbar.nvim',
    event = 'VimEnter', -- Alternatively, BufReadPre if we don't care about the empty file when starting with 'nvim'
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('winbar').setup {}
    end,
  },
}
