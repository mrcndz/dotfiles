return {
  'williamboman/mason.nvim',

  dependencies = {
    'williamboman/mason-lspconfig.nvim',
  },

  config = function()
    require('mason').setup()

    require('mason-lspconfig').setup({
      ensure_installed = {
        'bashls',
        'marksman',
        'lua_ls',
        'cmake',
        'dockerls',
        'cssls',
        'dockerls',
        'ltex',
        'html',
        'jsonls',
        'pyright',
        'tsserver',
        'vimls',
        'sqlls',
        'yamlls',
        'rust_analyzer',
      },
    })
  end,
}
