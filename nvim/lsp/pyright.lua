return {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { '.venv', '.env', 'pyproject.toml', 'setup.py', 'requirements.txt', 'Pipfile', 'poetry.lock' },
  settings = {
    capabilities = function()
      local c = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
      c.workspace.didChangeWatchedFiles.dynamicRegistration = false

      return c
    end,
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'workspace',
      },
    },
  },
}
