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
--require
-- require('plug-setup')
-- require('key')
--
--Hop setup
local status_ok, hop = pcall(require, "hop")
if not status_ok then
  return
end

hop.setup {
  keys = 'etovxqpdygfblzhckisuran'
}

local opts = {
  silent = true,
  noremap=true,
  callback=nil,
  desc=nil,
}

local keymap = vim.api.nvim_set_keymap
local directions = require('hop.hint').HintDirection

local bindings = {
    {
      mode = 'n',
      mapping = 'f',
      desc = '',
      func = function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true }) end
    },
    {
      mode = 'n',
      mapping = 'F',
      desc = '',
      func = function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true }) end
    },
    {
      mode = 'n',
      mapping = 't',
      desc = '',
      func = function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }) end
    },
    {
      mode = 'n',
      mapping = 'T',
      desc = '',
      func = function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }) end
    },
}


table.foreach(bindings, function(idx, binding)
  opts.callback = binding.func
  opts.desc = binding.desc
  keymap(binding.mode, binding.mapping, '', opts)
end)
