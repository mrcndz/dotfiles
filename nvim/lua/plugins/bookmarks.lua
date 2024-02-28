return {
  {
    'tomasky/bookmarks.nvim',
    lazy = false,
    dependencies = { 'nvim-telescope/telescope.nvim' },
    init = function() end,
    config = function()
      require('bookmarks').setup({
        -- sign_priority = 8,  --set bookmark sign priority to cover other sign
        save_file = vim.fn.expand('$HOME/.bookmarks'), -- bookmarks save file path
        keywords = {
          ['@t'] = '☑️ ', -- mark annotation startswith @t ,signs this icon as `Todo`
          ['@w'] = '⚠️ ', -- mark annotation startswith @w ,signs this icon as `Warn`
          ['@f'] = '⛏ ', -- mark annotation startswith @f ,signs this icon as `Fix`
          ['@n'] = ' ', -- mark annotation startswith @n ,signs this icon as `Note`
        },

        on_attach = function(bufnr)
          local bm = require('bookmarks')
          local map = vim.keymap.set

          map('n', 'ml', '<cmd>Telescope bookmarks list<CR>') -- list all marks in local buffer
          map('n', 'mi', bm.bookmark_ann) -- add or edit mark annotation at current line
          map('n', 'md', bm.bookmark_clean) -- clean all marks in local buffer
          map('n', 'mn', bm.bookmark_next) -- jump to next mark in local buffer
          map('n', 'mp', bm.bookmark_prev) -- jump to previous mark in local buffer
        end,
      })
    end,
  },
}
