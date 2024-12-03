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
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      require('lint').linters.pylint.cmd = 'python'
      require('lint').linters.pylint.args = {
        '-m',
        'pylint',
        '-f',
        'json',
        '--from-stdin',
        function()
          return vim.api.nvim_buf_get_name(0)
        end,
      }
      -- require('lint').linters.pylint.args = { '-m', 'pylint', '-f', 'json' }
    end,
  },
}
