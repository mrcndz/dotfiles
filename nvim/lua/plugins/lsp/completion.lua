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
        ['<Tab>'] = {
          function(cmp)
            local item = cmp.get_selected_item()
            local supermaven_has_suggestion = require('supermaven-nvim.completion_preview').has_suggestion

            if item == nil and supermaven_has_suggestion() then
              vim.schedule(function()
                vim.api.nvim_command 'lua require "supermaven-nvim.completion_preview".on_accept_suggestion()'
              end)
            elseif item == nil then
              return
            end
            vim.schedule(function()
              cmp.accept()
            end)
            return true
          end,
          'snippet_forward',
          'fallback',
        },
        ['<C-Space>'] = { 'show', 'hide' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      },
      --
      completion = {
        keyword = { range = 'full' },
        accept = { auto_brackets = { enabled = false } },
        list = { selection = { preselect = false, auto_insert = true } },
        menu = {
          auto_show = true,
          draw = {
            columns = {
              { 'label', 'label_description', gap = 1 },
              { 'kind_icon', 'kind' },
            },
          },
        },
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        ghost_text = { enabled = true },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
        cmdline = {},
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },
      snippets = { preset = 'default' },
      signature = { enabled = true },
    },
  },
  {
    'supermaven-inc/supermaven-nvim',
    config = function()
      require('supermaven-nvim').setup {
        disable_keymaps = true,
      }
    end,
  },
}
