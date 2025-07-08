vim.keymap.set('n', '<space>', '<Nop>', { silent = true, desc = 'Disable space key' })
vim.keymap.set('n', ';', ':', { silent = true, desc = 'Enter command mode' })
vim.keymap.set('n', 'q;', 'q:', { silent = true, desc = 'Open command-line window' })

vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, silent = true, desc = 'Quick escape from insert mode' })
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true, desc = 'Quick escape from insert mode' })
vim.keymap.set('i', '<Esc>', '<Esc>', { noremap = true, silent = true, desc = 'Escape from insert mode' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = 'Move selected text down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = 'Move selected text up' })

vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true, desc = 'Next search result (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true, desc = 'Previous search result (centered)' })

vim.keymap.set('n', '<Tab>', ':bprevious<CR>', { noremap = true, silent = true, desc = 'Previous buffer' })
vim.keymap.set('n', '<S-Tab>', ':bnext<CR>', { noremap = true, silent = true, desc = 'Next buffer' })
vim.keymap.set('n', 'gp', '`[v`]', { desc = 'Select pasted text' })

-- Macro over visual
vim.cmd [[
  xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

  function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
  endfunction

]]

vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true, desc = 'Save file' })
vim.keymap.set('n', '<C-q>', ':q<CR>', { noremap = true, silent = true, desc = 'Quit' })

vim.keymap.set('n', 'Y', 'y$', { noremap = true, silent = true, desc = 'Yank to end of line' })

-- Different register for delete and paste
vim.keymap.set('n', 'd', '"_d', { noremap = true, silent = true, desc = 'Delete to black hole register' })
vim.keymap.set('v', 'd', '"_d', { noremap = true, silent = true, desc = 'Delete to black hole register' })
vim.keymap.set('n', 'x', '"_x', { noremap = true, silent = true, desc = 'Delete character to black hole register' })
vim.keymap.set('v', 'p', '"_dP', { noremap = true, silent = true, desc = 'Paste over selection (keep original)' })
vim.keymap.set('n', 'P', '"_d', { noremap = true, silent = true, desc = 'Delete to black hole register' })
vim.keymap.set('v', '<LeftRelease>', '"+y<LeftRelease>', { noremap = true, silent = true, desc = 'Copy selection to clipboard on mouse release' })

-- Copy to system clippboard
vim.keymap.set('n', 'y', '"+y', { noremap = true, silent = true, desc = 'Yank to system clipboard' })
vim.keymap.set('v', 'y', '"+y', { noremap = true, silent = true, desc = 'Yank to system clipboard' })
vim.keymap.set('v', '<C-c>', '"+y', { noremap = true, silent = true, desc = 'Copy to system clipboard (Windows behavior)' })

-- Paste from system clippboard
vim.keymap.set('n', 'p', '"+p', { noremap = true, silent = true, desc = 'Paste from system clipboard' })
vim.keymap.set('v', 'p', '"+p', { noremap = true, silent = true, desc = 'Paste from system clipboard' })
vim.keymap.set('v', '<C-v>', '"+p', { noremap = true, silent = true, desc = 'Paste from system clipboard (Windows behavior)' })
