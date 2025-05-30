return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        text = { 'vale' },
        python = { 'pylint' },
        zsh = { 'shellcheck' },
        typescript = { 'eslint' },
        javascript = { 'eslint' },
      }

      local pylint = lint.linters.pylint
      pylint.args {
        '--rcfile',
        vim.fs.find('pyproject.toml')[1],
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
