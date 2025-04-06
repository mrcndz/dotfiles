vim.lsp.config('*', {
  root_markers = { '.git' },
})

vim.lsp.enable {
  'luals',
  'jsonls',
  'marksman',
  'pyright',
}

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
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },
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
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        'lazy.nvim',
        'luvit-meta/library',
        'LazyVim',
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<F2>',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        javascript = { { 'prettierd', 'prettier' } },
        json = { { 'prettierd', 'prettier' } },
        fish = { 'fish_indent' },
        rust = { 'rustfmt' },
      },
      format_on_save = { timeout_ms = 1500, lsp_fallback = true },
      formatters = {
        shfmt = {
          prepend_args = { '-i', '2' },
        },
      },
    },

    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
