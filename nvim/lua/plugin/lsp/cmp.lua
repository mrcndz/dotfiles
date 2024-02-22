  -- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = cmp.mapping.preset.insert({
    -- Enter key confirms completion item
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<C-Tab>'] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
    ['<C-j>'] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
    ['<C-k>'] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require('vsnip#anonymous')(args.body)
    end,
  },
})
