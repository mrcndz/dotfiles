return {
  'stevearc/quicker.nvim',
  event = 'FileType qf',
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {},
  config = function()
    require('quicker').setup {
      on_qf = function(bufnr)
        feed_esc()
        vim.keymap.set('n', 'q', function()
          require('quicker').close()
        end, { buffer = bufnr, nowait = true, silent = true })

        vim.keymap.set('n', '>', function()
          require('quicker').expand { before = 2, after = 2, add_to_existing = true }
        end, { buffer = bufnr, nowait = true, silent = true })

        vim.keymap.set('n', '<', function()
          require('quicker').collapse()
        end, { buffer = bufnr, nowait = true, silent = true })
      end,
    }
  end,
  keys = {
    {
      '<leader>q',
      function()
        require('quicker').toggle { focus = true }
      end,
      desc = 'Quickfix',
    },
    -- {
    --   '<leader>l',
    --   function()
    --     require('quicker').toggle { loclist = true, focus = true }
    --   end,
    --   desc = 'Location List',
    -- },
  },
}
