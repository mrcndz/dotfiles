return {
  -- Current using hlchnk :)
  -- {
  --   'lukas-reineke/indent-blankline.nvim',
  --   main = 'ibl',
  --   opts = {},
  --   config = function()
  --     local hooks = require('ibl.hooks')
  --     require('ibl').setup({
  --       whitespace = {
  --         remove_blankline_trail = false,
  --       },
  --     })
  --     hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  --   end,
  -- },
  {
    'nmac427/guess-indent.nvim',
    config = function()
      require('guess-indent').setup({})
    end,
  },
  {
    'shellRaining/hlchunk.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('hlchunk').setup({
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
            '¦',
            '┆',
            '┊',
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
      })
    end,
  },
}
