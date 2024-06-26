return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<F2>',
      function()
        require('conform').format({ async = true, lsp_fallback = true })
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'blue' },
      javascript = { { 'prettierd', 'prettier' } },
      json = { { 'prettierd', 'prettier' } },
      fish = { 'fish_indent' },
      rust = { 'rustfmt' },
    },
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
    formatters = {
      shfmt = {
        prepend_args = { '-i', '2' },
      },
      blue = {
        args = { '--line-length', '120' },
      },

    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
