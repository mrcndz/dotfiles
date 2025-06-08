return {
  { 'saghen/blink.compat' },
  {
    'saghen/blink.cmp',
    lazy = false,
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    version = '*',
    opts = {
      keymap = {
        ['<CR>'] = { 'accept', 'fallback' },
        ['<C-l>'] = { 'select_and_accept', 'fallback' },
        ['<C-Space>'] = { 'show', 'hide' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-s>'] = { 'show_signature', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      },
      cmdline = {
        keymap = {
          ['<Tab>'] = { 'show', 'accept' },
          ['<C-l>'] = { 'select_and_accept', 'fallback' },
          ['<C-Space>'] = { 'show', 'hide' },
          ['<C-j>'] = { 'select_next', 'fallback' },
          ['<C-k>'] = { 'select_prev', 'fallback' },
          ['<C-w>?'] = { 'show_signature', 'fallback' },
          ['<Down>'] = { 'select_next', 'fallback' },
          ['<Up>'] = { 'select_prev', 'fallback' },
          ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
          ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        },
        completion = { menu = { auto_show = true } },
      },
      completion = {
        keyword = { range = 'full' },
        accept = { auto_brackets = { enabled = false } },
        list = { selection = { preselect = true, auto_insert = true } },
        menu = {
          border = 'single',
          auto_show = true,
          draw = {
            columns = {
              { 'label', 'label_description', gap = 1 },
              { 'kind_icon', 'kind' },
            },
          },
        },
        documentation = { window = { border = 'single' }, auto_show = true, auto_show_delay_ms = 500 },
        ghost_text = { enabled = false },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          buffer = {
            opts = {
              get_bufnrs = function()
                return vim.tbl_filter(function(bufnr)
                  return vim.bo[bufnr].buftype == ''
                end, vim.api.nvim_list_bufs())
              end,
            },
          },
          -- lazydev = {
          --   name = 'LazyDev',
          --   module = 'lazydev.integrations.blink',
          --   score_offset = 100,
          -- },
        },
      },
      snippets = { preset = 'default' },
      signature = {
        window = { border = 'single', show_documentation = true },
        enabled = true,
      },
    },
  },
  {
    'supermaven-inc/supermaven-nvim',
    config = function()
      require('supermaven-nvim').setup {
        keymaps = {
          accept_suggestion = '<Tab>',
          clear_suggestion = '<C-]>',
          accept_word = '<A-l>',
        },
        ignore_filetypes = {},
      }

      -- Show signature when cursor is in function call
      vim.api.nvim_create_augroup('CursorHoldSignature', {})
      vim.api.nvim_create_autocmd({ 'TextChangedI', 'CursorHold' }, {
        group = 'CursorHoldSignature',
        callback = function()
          local cmp = require 'blink.cmp'
          local node = vim.treesitter.get_node()

          if not node or node:type() ~= 'arguments' or node:parent():type() ~= 'function_call' and cmp.is_signature_visible() then
            cmp.hide_signature()
            return
          end

          cmp.show_signature()
        end,
      })
    end,
  },
}
