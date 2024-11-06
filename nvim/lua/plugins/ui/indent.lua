return {
  {
    'nmac427/guess-indent.nvim',
    config = function()
      require('guess-indent').setup {}
    end,
  },
  {
    'shellRaining/hlchunk.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('hlchunk').setup {
        chunk = {
          enable = true,
          chars = {
            horizontal_line = '─',
            vertical_line = '│',
            left_top = '┌',
            left_bottom = '└',
            right_arrow = '─',
          },
          style = '#ffb964',
          use_treesitter = true,
        },
        indent = {
          enable = true,
          use_treesitter = true,
          chars = {
            '│',
          },
        },
        line_num = {
          enable = true,
          style = '#ffb964',
          use_treesitter = true,
        },
        blank = {
          enable = false,
        },
      }
    end,
  },
}
