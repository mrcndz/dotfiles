return {
  'coder/claudecode.nvim',
  config = function()
    require('claudecode').setup {
      terminal = {
        provider = 'snacks',
      },
    }

    vim.api.nvim_create_autocmd('TermOpen', {
      group = vim.api.nvim_create_augroup('ClaudeTermMapping', { clear = true }),
      pattern = 'term://*:claude*',
      callback = function()
        local opts = { silent = true, noremap = true, buffer = 0 }

        vim.keymap.set('t', 'jk', '<C-\\><C-n>', opts)
        vim.keymap.set('t', 'jj', '<C-\\><C-n>', opts)
        vim.keymap.set('t', '<C-h>', '<cmd>NvimTmuxNavigateLeft<cr>', opts)
        vim.keymap.set('t', '<C-l>', '<cmd>NvimTmuxNavigateRight<cr>', opts)
        vim.keymap.set('t', '<C-k>', '<Up>', opts)
        vim.keymap.set('t', '<C-j>', '<Down>', opts)
      end,
    })

    return true
  end,
  keys = {
    { '<leader>ac', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude' },
    { '<leader>af', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude' },
    { '<leader>ar', '<cmd>ClaudeCode --resume<cr>', desc = 'Resume Claude' },
    { '<leader>aC', '<cmd>ClaudeCode --continue<cr>', desc = 'Continue Claude' },
    { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send to Claude' },
  },
}
