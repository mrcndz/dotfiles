local Utils = require('utils')
local noremap = Utils.noremap
local nnoremap = Utils.nnoremap
local vnoremap = Utils.vnoremap
local xnoremap = Utils.xnoremap
local inoremap = Utils.inoremap
local tnoremap = Utils.tnoremap
local nmap = Utils.nmap
local xmap = Utils.xmap
local vmap = Utils.vmap
local map = Utils.map
local imap = Utils.imap

nnoremap('<space>', ':WhichKey <leader><CR>')

-- Move text
vnoremap('J', ":m '>+1<CR>gv=gv")
vnoremap('K', ":m '<-2<CR>gv=gv")

-- search centering
nnoremap('n', 'nzzzv')
nnoremap('N', 'Nzzzv')

-- Buffer
nnoremap('<A-l>', '<cmd>BufferNext<CR>')
nnoremap('<A-h>', '<cmd>BufferPrevious<CR>')
nnoremap('<A-<>', '<cmd>BufferMovePrevious<CR>')
nnoremap('<A->>', '<cmd>BufferMoveNext<CR>')
nnoremap('<C-p>', '<cmd>BufferPin<cr>')

-- Macro over visual
vim.cmd([[
  xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

  function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
  endfunction

]])

nnoremap('<C-s>', ':w<CR>')
nnoremap('<C-q>', ':q<CR>')

-- Yank to end of line
nnoremap('Y', 'y$')

-- Different register for delete and paste
nnoremap('<leader>d', '"_d')
vnoremap('<leader>d', '"_d')
nnoremap('d', '"_d')
vnoremap('d', '"_d')
nnoremap('x', '"_x')
vnoremap('p', '"_dP')
nnoremap('P', '"_d')
vnoremap('<LeftRelease>', '"+y<LeftRelease>')

-- Copy to system clippboard
nnoremap('y', '"+y')
vnoremap('y', '"+y')
vnoremap('<C-c>', '"+y') -- Windows behavior

-- Paste from system clippboard
nnoremap('p', '"+p')
vnoremap('p', '"+p')
vnoremap('<C-v>', '"+p') -- Windows behavior

-- Easy motion for begin and end lines
nnoremap('L', '$')
nnoremap('H', '^')
vnoremap('L', '$')
vnoremap('H', '^')

-- Select ocurrence and replace
nnoremap('R', '*``cgn')
vim.cmd([[xnoremap R y<cmd>let @/=escape(@", '/')<cr>"_cgn]])
