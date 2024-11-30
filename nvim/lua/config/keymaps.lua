local Utils = require 'utils'
local noremap = Utils.noremap
local nnoremap = Utils.nnoremap
local vnoremap = Utils.vnoremap
local inoremap = Utils.inoremap
local nmap = Utils.nmap

nmap('<space>', '<Nop>')

-- map leader to space
inoremap('jj', '<Esc>l')

-- Move text
vnoremap('J', ":m '>+1<CR>gv=gv")
vnoremap('K', ":m '<-2<CR>gv=gv")

-- Quickly move to end and beginning of line
nnoremap('H', '_')
nnoremap('L', '$')

-- search centering
nnoremap('n', 'nzzzv')
nnoremap('N', 'Nzzzv')

-- Macro over visual
vim.cmd [[
  xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

  function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
  endfunction

]]

nnoremap('<C-s>', ':w<CR>')
nnoremap('<C-q>', ':q<CR>')

-- Yank to end of line
nnoremap('Y', 'y$')

-- Different register for delete and paste
-- nnoremap('<leader>d', '"_d')
-- vnoremap('<leader>d', '"_d')
nnoremap('d', '"_d')
vnoremap('d', '"_d')
nnoremap('x', '"_x')
vnoremap('p', '"_dP')
nnoremap('P', '"_d')
vnoremap('<LeftRelease>', '"+y<LeftRelease>')
nnoremap('gp', 'i<C-r><C-o>+<ESC>l=`[`]$')

-- Copy to system clippboard
nnoremap('y', '"+y')
vnoremap('y', '"+y')
vnoremap('<C-c>', '"+y') -- Windows behavior

-- Paste from system clippboard
nnoremap('p', '"+p')
vnoremap('p', '"+p')
vnoremap('<C-v>', '"+p') -- Windows behavior
