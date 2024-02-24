--To install plugin use `:PlugInstall'
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-- Icons --------------------------------------------------
Plug 'nvim-tree/nvim-web-devicons'        -- Devicons    --
Plug 'ryanoasis/vim-devicons'             -- Devicons    --
-----------------------------------------------------------

-- Telescope ----------------------------------------------
Plug 'nvim-lua/plenary.nvim'                             --
Plug('nvim-telescope/telescope.nvim', { tag = '0.1.5' }) --
-----------------------------------------------------------

-- LSP ---------------------------------------------------
Plug 'williamboman/mason.nvim'                          --
Plug 'williamboman/mason-lspconfig.nvim'                --
Plug 'neovim/nvim-lspconfig'                            --
-- CMP ---------------------------------------------------
Plug 'hrsh7th/cmp-nvim-lsp'                             --
Plug 'hrsh7th/cmp-buffer'                               --
Plug 'hrsh7th/cmp-path'                                 --
-- Plug 'hrsh7th/cmp-cmdline'              Error        --
Plug 'hrsh7th/nvim-cmp'                                 --
Plug 'hrsh7th/cmp-nvim-lua'                             --
-- SNIPPETS ----------------------------------------------
Plug 'hrsh7th/cmp-vsnip'                                --
Plug 'hrsh7th/vim-vsnip'                                --
-- None LS -----------------------------------------------
Plug "nvimtools/none-ls.nvim"                           --
----------------------------------------------------------

-- Essentials ---------------------------------------------
Plug 'RRethy/vim-illuminate'              -- Illuminate  --
Plug 'nvim-treesitter/nvim-treesitter'    -- Treesitter  --
Plug 'folke/which-key.nvim'               -- Which-key   --
Plug 'tomasky/bookmarks.nvim'             -- Bookmarks   --
Plug 'cohama/lexima.vim'                  -- Lexima      --
Plug 'machakann/vim-sandwich'             -- Sandwich    --
Plug 'psliwka/vim-smoothie'               -- Smoothie    --
Plug 'nvim-tree/nvim-tree.lua'            -- Nvim-tree   --
-----------------------------------------------------------

-- Themes -------------------------------------------------
Plug 'luochen1990/rainbow'                -- Rainbow     --
Plug 'sainnhe/everforest'                 -- Everforest  --
Plug 'sainnhe/sonokai'                    -- Sonokai     --
Plug 'sainnhe/edge'                       -- Edge        --
-- Visual -------------------------------------------------
Plug 'nvim-lualine/lualine.nvim'          -- statusline  --
Plug 'romgrk/barbar.nvim'                 -- tabline     --
-----------------------------------------------------------

-- Keymaps ----------------------------------------------------------
Plug 'subnut/visualstar.vim'              -- * for visual mode     --
Plug 'phaazon/hop.nvim'                   -- Jump letters          --
Plug 'Jorengarenar/vim-MvVis'             -- Move selected text    --
Plug 'tpope/vim-commentary'               -- Comment               --
---------------------------------------------------------------------

-- Etc --------------------------------------------------------------
Plug 'alexghergh/nvim-tmux-navigation'    -- Tmux navigation       --
Plug 'christoomey/vim-tmux-navigator'     --                       --
Plug 'github/copilot.vim'                 -- Copilot               --
Plug 'Yggdroot/indentLine'                -- Indent line           --
Plug 'tpope/vim-fugitive'                 -- Fugitive              --
---------------------------------------------------------------------

vim.call('plug#end')

require "plugin.lsp.mason"
require "plugin.lsp.cmp"
require "plugin.lsp.lspconfig"
require "plugin.telescope"
require "plugin.which-key"
require "plugin.bookmarks"
require "plugin.nvim-tree"
require "plugin.lualine"
require "plugin.barbar"

