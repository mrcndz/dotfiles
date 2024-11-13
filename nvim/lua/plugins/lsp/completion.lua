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
            local suggestion = require 'supermaven-nvim.completion_preview'
            if suggestion.has_suggestion() then
              return vim.schedule(suggestion.on_accept_suggestion)
            end
          end,
          function(cmp)
            if cmp.is_in_snippet() then
              return cmp.accept()
            end
          end,
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
            enabled_providers = { 'lsp', 'path', 'buffer', 'snippets' },
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

      local suggestion = require 'supermaven-nvim.completion_preview'
      local accept_suggestion = function()
        if suggestion.has_suggestion() then
          suggestion.on_accept_suggestion()
          return true
        end
        return false
      end
    end,
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp',
  },
  --   dependencies = {
  --     'hrsh7th/cmp-buffer',
  --     'hrsh7th/cmp-path',
  --     'hrsh7th/cmp-cmdline',
  --     'L3MON4D3/LuaSnip',
  --     'saadparwaiz1/cmp_luasnip',
  --     'hrsh7th/cmp-nvim-lsp-signature-help',
  --     'onsails/lspkind-nvim',
  --     'supermaven-inc/supermaven-nvim',
  --   },
  --   config = function()
  --     --     local cmp = require 'cmp'
  --     --     local lspkind = require 'lspkind'
  --     --     local suggestion = require 'supermaven-nvim.completion_preview'
  --     --     require('supermaven-nvim').setup { disable_keymaps = true }
  --     --
  --     --     cmp.setup {
  --     --       snippet = {
  --     --         expand = function(args)
  --     --           require('luasnip').lsp_expand(args.body)
  --     --         end,
  --     --       },
  --     --
  --     --       sources = cmp.config.sources({
  --     --         { name = 'nvim_lsp' },
  --     --         { name = 'nvim_lsp_signature_help' },
  --     --         { name = 'path' },
  --     --         { name = 'luasnip' },
  --     --       }, {
  --     --         { name = 'buffer' },
  --     --       }),
  --     --
  --     --       mapping = cmp.mapping.preset.insert {
  --     --         ['<Tab>'] = cmp.mapping(function(fallback)
  --     --           local entry = cmp.get_selected_entry()
  --     --
  --     --           if cmp.visible() and entry ~= nil then
  --     --             cmp.confirm { select = false }
  --     --           elseif suggestion.has_suggestion() then
  --     --             suggestion.on_accept_suggestion()
  --     --           else
  --     --             fallback()
  --     --           end
  --     --         end, { 'i', 's' }),
  --     --         ['<S-Tab>'] = cmp.mapping(function(fallback)
  --     --           local entry = cmp.get_selected_entry()
  --     --
  --     --           if cmp.visible() and entry ~= nil then
  --     --             cmp.mapping.close()
  --     --           else
  --     --             fallback()
  --     --           end
  --     --         end, { 'i', 's' }),
  --     --         ['<CR>'] = cmp.mapping.confirm { select = false },
  --     --         ['<C-j>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
  --     --         ['<C-k>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
  --     --         ['<C-d>'] = cmp.mapping.scroll_docs(-4),
  --     --         ['<C-u>'] = cmp.mapping.scroll_docs(4),
  --     --         ['<C-Enter>'] = cmp.mapping.complete(),
  --     --         ['<C-Space>'] = cmp.mapping.complete(),
  --     --       },
  --     --     }
  --   end,
  -- },
}
