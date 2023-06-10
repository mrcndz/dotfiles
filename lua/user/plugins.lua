--To install plugin use `:PlugInstall`
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
Plug 'phaazon/hop.nvim'
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'luochen1990/rainbow'
Plug 'Jorengarenar/vim-MvVis'
Plug 'zchee/deoplete-jedi'
Plug 'neomake/neomake'
Plug 'github/copilot.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'memgraph/cypher.vim'
Plug 'machakann/vim-sandwich'
Plug 'honza/vim-snippets'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'psliwka/vim-smoothie'
Plug 'wellle/tmux-complete.vim'
Plug 'tpope/vim-eunuch'
vim.call('plug#end')

--Colorscheme
vim.cmd[[
  syntax enable
  colorscheme gruvbox
]]