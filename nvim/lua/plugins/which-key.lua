return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    local wk = require 'which-key'
    local wkicon = require 'which-key.icons'

    wk.add {
      { '<leader>a', group = 'AI' },
    }

    -- LSP
    wk.add {
      { '<leader>l', group = 'LSP' },
      { '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<CR>', desc = 'Rename Symbol', mode = 'n', icon = '󰀘 ' },
    }
    -- LazyGit
    wk.add {
      { '<leader>g', group = 'Git' },
    }
    -- Utils
    -- Clear Buffers
    wk.add {
      { '<leader>b', group = 'Actions' },
      { '<leader>bD', "<cmd>bufdo if bufnr('%') != bufnr('#') | bdelete | endif<cr>", desc = 'Clear Buffers', mode = 'n', icon = '󰃢' },
      { '<leader>bd', '<cmd>:bd<CR>', desc = 'Close Buffer', mode = 'n', icon = ' x' },
    }
  end,
  opts = {
    preset = 'helix',
    sort = { 'group', 'manual', 'order', 'alphanum', 'mod', 'lower', 'icase' },
  },
}
