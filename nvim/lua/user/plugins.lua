--To install plugin use `:PlugInstall`
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'nvim-lua/plenary.nvim'                        -- Telescope
Plug('nvim-telescope/telescope.nvim', { tag = '0.1.5' })

Plug 'prabirshrestha/vim-lsp'              -- LSP
Plug 'mattn/vim-lsp-settings'

Plug 'nvim-treesitter/nvim-treesitter'    -- Treesitter
Plug 'preservim/nerdtree'                 -- Nerdtree

-- Plug 'folke/which-key.nvim'               -- Which-key

-- Themes
Plug 'ryanoasis/vim-devicons'             -- Devicons
Plug 'luochen1990/rainbow'                -- Rainbow

-- Keymaps
Plug 'subnut/visualstar.vim'              -- * for visual mode
Plug 'phaazon/hop.nvim'                   -- Hop
Plug 'Jorengarenar/vim-MvVis'             -- Move selected text

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
Plug 'sainnhe/everforest'

vim.call('plug#end')

-- require "plugin.telescope"
-- require "plugin.which-key"
