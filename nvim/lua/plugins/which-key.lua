return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    local wk = require 'which-key'
    local wkicon = require 'which-key.icons'

    -- LSP
    wk.add {
      { '<leader>l', group = 'LSP' },
      { '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<CR>', desc = 'Rename Symbol', mode = 'n', icon = '󰀘 ' },
    }

    -- Git
    wk.add {
      { '<leader>g', group = 'Git' },
      {
        '<leader>gd',
        function()
          local gs = require 'gitsigns'
          local on = not vim.b.inline_diff_on
          gs.toggle_deleted(on)
          gs.toggle_linehl(on)
          gs.toggle_word_diff(on)
          vim.b.inline_diff_on = on
        end,
        desc = 'Inline diff (toggle)',
        mode = 'n',
        icon = '󰦓',
      },
    }

    -- Utils
    -- Clear Buffers
    wk.add {
      { '<leader>b', group = 'Actions' },
      { '<leader>bD', "<cmd>bufdo if bufnr('%') != bufnr('#') | bdelete | endif<cr>", desc = 'Clear Buffers', mode = 'n', icon = '󰃢' },
      { '<leader>bd', '<cmd>:bd<CR>', desc = 'Close Buffer', mode = 'n', icon = ' x' },
    }
    wk.add {
      { '<leader>Q', '<cmd>qa!<CR>', desc = 'Quit All', mode = 'n', icon = '󰩈' },
    }

    wk.add {
      { '<leader>q', '<cmd>qa<CR>', desc = 'Quit All', mode = 'n', icon = '󰩈' },
    }
  end,
  opts = {
    preset = 'helix',
    sort = { 'group', 'manual', 'order', 'alphanum', 'mod', 'lower', 'icase' },
  },
}
