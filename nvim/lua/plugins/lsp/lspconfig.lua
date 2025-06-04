vim.lsp.config('*', {
  root_markers = { '.git' },
})

vim.lsp.enable {
  'luals',
  'jsonls',
  'pyright',
  'marksman',
}

vim.keymap.set('n', '<leader>ld', function()
  vim.diagnostic.open_float(nil, { focusable = true, source = 'if_many' })
end, { desc = 'Show diagnostics' })

vim.diagnostic.config {
  update_in_insert = true,
  underline = false,
  virtual_text = {
    severity = vim.diagnostic.severity.ERROR,
    spacing = 4,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󱔷',
      [vim.diagnostic.severity.WARN] = '󰾕',
      [vim.diagnostic.severity.HINT] = '',
      [vim.diagnostic.severity.INFO] = '󰾚',
    },
    line_hl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
    },
  },
}

return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      { 'williamboman/mason.nvim', opts = true },
      { 'williamboman/mason-lspconfig.nvim', opts = true },
    },
    opts = {
      ensure_installed = {
        -- Lua
        'lua_ls',
        'stylua',
        -- Python
        'pyright',
        'ruff',
        'debugpy',
        'black',
        'isort',
        'taplo',
        -- Markdown
        'marksman',
        -- Json
        'jsonls',
        -- Yaml
        'yamlls',
        -- Javascript
        'eslint',
        'prettier',
        'prettierd',
      },
    },
  },
  -- {
  --   'folke/lazydev.nvim',
  --   ft = 'lua',
  --   opts = {
  --     library = {
  --       'lazy.nvim',
  --       'luvit-meta/library',
  --       'LazyVim',
  --       { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  --       { path = vim.fn.stdpath 'data' .. '/lazy' },
  --     },
  --     enabled = true,
  --   },
  -- },
}
