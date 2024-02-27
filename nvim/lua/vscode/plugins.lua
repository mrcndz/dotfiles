-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Icons
  {"nvim-tree/nvim-web-devicons"}, -- Devicons
  {"ryanoasis/vim-devicons"},

  -- Telescope
  {"nvim-lua/plenary.nvim"},
  {"nvim-telescope/telescope.nvim", tag = "0.1.5"},

  -- LSP
  {"williamboman/mason.nvim"},
  {"williamboman/mason-lspconfig.nvim"},
  {"neovim/nvim-lspconfig"},

  -- CMP
  {"hrsh7th/cmp-nvim-lsp"},
  {"hrsh7th/cmp-buffer"},
  {"hrsh7th/cmp-path"},
  -- {"hrsh7th/cmp-cmdline"}, -- Error
  {"hrsh7th/nvim-cmp"},
  {"hrsh7th/cmp-nvim-lua"},

  -- SNIPPETS
  {"hrsh7th/cmp-vsnip"},
  {"hrsh7th/vim-vsnip"},

  -- None LS
  {"nvimtools/none-ls.nvim"},

  -- Essentials
  {"RRethy/vim-illuminate"},
  {"nvim-treesitter/nvim-treesitter"},
  {"folke/which-key.nvim"},
  {"tomasky/bookmarks.nvim"},
  {"cohama/lexima.vim"},
  {"machakann/vim-sandwich"},
  {"psliwka/vim-smoothie"},
  {"nvim-tree/nvim-tree.lua"},

  -- Themes
  {"luochen1990/rainbow"},
  {"sainnhe/everforest"},
  {"sainnhe/sonokai"},
  {"sainnhe/edge"},

  -- Visual
  {"nvim-lualine/lualine.nvim"},
  {"romgrk/barbar.nvim"},

  -- Keymaps
  {"subnut/visualstar.vim"},
  {"phaazon/hop.nvim"},
  {"Jorengarenar/vim-MvVis"},
  {"tpope/vim-commentary"},

  -- Etc
  {"alexghergh/nvim-tmux-navigation"},
  {"github/copilot.vim"},
  -- {"Yggdroot/indentLine"}, -- Indent line
  {"tpope/vim-fugitive"},
  {"lukas-reineke/indent-blankline.nvim"},
}, {})

