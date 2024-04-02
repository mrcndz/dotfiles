return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'simrat39/rust-tools.nvim',
    'hrsh7th/cmp-nvim-lsp',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'VidocqH/lsp-lens.nvim',
    'folke/neodev.nvim',
  },
  config = function()
    local signs = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    require('lsp-lens').setup()
    require('neodev').setup()
    require('rust-tools').setup()

    local lspconfig = require('lspconfig')
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    local on_attach = function(client, bufnr)
      local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
      end
      local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
      end

      buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
      local opts = { noremap = true, silent = true }

      buf_set_keymap('n', 'gf', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
      buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts) -- gD go to declaration
      buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts) -- gd go to definition
      buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts) -- gi go to implementation
      buf_set_keymap('n', 'gl', '<cmd>lua vim.lsp.buf.hover()<CR>', opts) -- gl go to hover
      buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts) -- gr go to references
      buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts) -- gt go to type definition
      buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts) -- rename symbol
      buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts) -- code action
      buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts) -- add workspace folder
      buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove workspace_folder()<CR>', opts) -- remove workspace folder
      buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts) -- list workspace folders
      buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts) -- go to previous diagnostic]')
      buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts) -- go to next diagnostic
    end

    lspconfig['pyright'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = 'workspace',
          },
        },
      },
    })

    lspconfig['lua_ls'].setup({
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
        },
      },
    })

    lspconfig['tsserver'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['cssls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['marksman'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['jsonls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['bashls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['html'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['vimls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['yamlls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['dockerls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['ltex'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['sqlls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
}
