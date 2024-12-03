return {
  {
    'saghen/blink.cmp',
    lazy = false,
    version = 'v0.*',
    dependencies = {
      'rafamadriz/friendly-snippets',
      { 'saghen/blink.compat', version = '*', opts = { impersonate_nvim_cmp = true } },
    },
    opts = {
      keymap = {
        ['<Tab>'] = {
          function(cmp)
            local completion_list = require 'blink.cmp.completion.list'
            local item = completion_list.get_selected_item()
            local supermaven_has_suggestion = require('supermaven-nvim.completion_preview').has_suggestion

            if item == nil and supermaven_has_suggestion() then
              vim.schedule(function()
                vim.api.nvim_command 'lua require "supermaven-nvim.completion_preview".on_accept_suggestion()'
              end)
            elseif item == nil then
              return
            end
            vim.schedule(function()
              completion_list.accept()
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
      completion = {
        menu = {
          draw = {
            columns = { { 'item_idx' }, { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
            components = {
              item_idx = {
                text = function(ctx)
                  return tostring(ctx.idx)
                end,
                highlight = 'BlinkCmpItemIdx',
              },
            },
          },
        },
        list = {
          max_items = 200,
          selection = 'manual',
        },
        accept = {
          create_undo_point = true,
          auto_brackets = {
            enabled = false,
            default_brackets = { '(', ')' },
            override_brackets_for_filetypes = {},
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 400,
          update_delay_ms = 50,
          treesitter_highlighting = true,
        },
        ghost_text = {
          enabled = false,
        },
      },
      signature = {
        enabled = true,
      },
      sources = {
        completion = {
          enabled_providers = { 'lsp', 'path', 'snippets', 'buffer' },
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
