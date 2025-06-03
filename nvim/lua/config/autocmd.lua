local autocmd = vim.api.nvim_create_autocmd

autocmd('CmdwinEnter', {
  group = vim.api.nvim_create_augroup('CmdwinEnter', {}),
  callback = function()
    vim.keymap.set('n', 'q', '<C-c><C-c>', { silent = true, buffer = true, nowait = true })
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.signcolumn = 'no'
    vim.opt_local.cursorline = false
  end,
})
