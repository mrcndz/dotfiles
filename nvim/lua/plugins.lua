--To install plugin use `:PlugInstall`
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'nvim-lua/plenary.nvim'                        -- Telescope
Plug('nvim-telescope/telescope.nvim', { tag = '0.1.5' })

Plug 'prabirshrestha/vim-lsp'              -- LSP
Plug 'mattn/vim-lsp-settings'
Plug 'nvim-treesitter/nvim-treesitter'    -- Treesitter
Plug 'preservim/nerdtree'                 -- Nerdtree

Plug 'folke/which-key.nvim'               -- Which-key

-- Themes
Plug 'ryanoasis/vim-devicons'             -- Devicons
Plug 'luochen1990/rainbow'                -- Rainbow

-- Keymaps
Plug 'subnut/visualstar.vim'              -- * for visual mode
Plug 'phaazon/hop.nvim'                   -- Hop
Plug 'Jorengarenar/vim-MvVis'             -- Move selected text
Plug 'tomasky/bookmarks.nvim'            -- Bookmarks

Plug 'cohama/lexima.vim'                  -- Lexima
Plug 'alexghergh/nvim-tmux-navigation'     -- Tmux navigation
Plug 'zchee/deoplete-jedi'                -- Deoplete
Plug 'neomake/neomake'                    -- Neomake
Plug 'github/copilot.vim'                 -- Copilot
Plug 'christoomey/vim-tmux-navigator'     -- Tmux navigator
Plug 'memgraph/cypher.vim'                -- Cypher
Plug 'machakann/vim-sandwich'             -- Sandwich
Plug 'honza/vim-snippets'                 -- Snippets
Plug 'Yggdroot/indentLine'                -- Indent line
Plug 'tpope/vim-commentary'               -- Comment
Plug 'tpope/vim-fugitive'                 -- Fugitive
Plug 'psliwka/vim-smoothie'               -- Smoothie
Plug 'wellle/tmux-complete.vim'
Plug 'tpope/vim-eunuch'
Plug 'sainnhe/everforest'

vim.call('plug#end')

require "plugin.telescope"
require "plugin.which-key"
require "plugin.bookmarks"
