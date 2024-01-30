--To install plugin use `:PlugInstall`
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
Plug 'phaazon/hop.nvim'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-commentary'
vim.call('plug#end')
