return {
  cmd = { 'vtsls', '--stdio' },
  filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  root_markers = {
    '.eslintrc.js',
    '.eslintrc.json',
    '.eslintrc.mjs',
    '.eslintrc.yaml',
    '.eslintrc.yml',
    '.eslintrc',
    'eslint.config.js',
    'eslint.config.mjs',
    'eslint.config.ts',
    'node_modules/',
    'package.json',
  },
}
