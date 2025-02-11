return {
  cmd = { 'json-languageserver', '--stdio' },
  filetypes = { 'json' },
  root_markers = { '.git', '.venv', '.env' },
  settings = {
    capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
  },
}
