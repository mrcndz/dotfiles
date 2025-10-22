local function get_capabilities()
  local c = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
  c.workspace.didChangeWatchedFiles.dynamicRegistration = false
  return c
end

return {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyrightconfig.json', '.venv', 'pyproject.toml', 'setup.py', '.git' },
  capabilities = get_capabilities(),
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'workspace',
        typeCheckingMode = 'basic',
      },
    },
  },
}
