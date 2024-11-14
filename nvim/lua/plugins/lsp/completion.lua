return {
  { 'saghen/blink.compat' },
  {
    'saghen/blink.cmp',
    lazy = false,
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    version = 'v0.*',
    opts = {
      keymap = {
        ['<Tab>'] = {
          function(cmp)
            local item = cmp.windows.autocomplete.get_selected_item()
            local supermaven_has_suggestion = require('supermaven-nvim.completion_preview').has_suggestion

            if item == nil and supermaven_has_suggestion() then
              vim.schedule(function()
                vim.api.nvim_command 'lua require "supermaven-nvim.completion_preview".on_accept_suggestion()'
              end)
            elseif item == nil then
              return
            end
            vim.schedule(function()
              cmp.windows.autocomplete.accept()
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
      highlight = {
        use_nvim_cmp_as_default = false,
      },
      nerd_font_variant = 'mono',
      accept = { auto_brackets = { enabled = true } },
      trigger = { signature_help = { enabled = true }, completion = { show_in_snippet = false } },
      windows = {
        documentation = {
          border = vim.g.borderStyle,
          min_width = 15,
          max_width = 45,
          max_height = 10,
          auto_show = true,
          auto_show_delay_ms = 250,
        },
        autocomplete = {
          auto_show = true,
          selection = 'manual',
        },
        sources = {
          completion = {
            enabled_providers = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
          },
          providers = {
            lsp = { fallback_for = { 'lazydev' } },
            lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink' },
          },
        },
      },
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
