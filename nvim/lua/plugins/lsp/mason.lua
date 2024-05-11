return {
  'williamboman/mason.nvim',

  dependencies = {
    'williamboman/mason-lspconfig.nvim',
  },

  config = function()
    require('mason').setup({
      ensure_installed = {
        'bashls',
        'marksman',
        'lua_ls',
        'dockerls',
        'cssls',
        'dockerls',
        'ltex',
        'html',
        'jsonls',
        'pyright',
        'mypy',
        'ruff',
        'black',
        'tsserver',
        'sqlls',
        'yamlls',
        'rust_analyzer',
      },
    })

    require('mason-lspconfig').setup({
      ensure_installed = {
        'bashls',
        'marksman',
        'lua_ls',
        'dockerls',
        'cssls',
        'dockerls',
        'ltex',
        'html',
        'jsonls',
        'pyright',
        'tsserver',
        'sqlls',
        'yamlls',
        'rust_analyzer',
      },
    })
  end
}
