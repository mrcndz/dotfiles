-- General keymaps that are not pluggin dependant
local Utils = require('utils')

-- local exprnnoremap = Utils.exprnnoremap
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

vim.g.mapleader = " "
nnoremap("<space>", ":WhichKey <leader><CR>")

-- Plugins ---------------------------------------
-- MvVis
vnoremap("H", "<Plug>(MvVisLeft)")
vnoremap("J", "<Plug>(MvVisDown)")
vnoremap("K", "<Plug>(MvVisUp)")
vnoremap("L", "<Plug>(MvVisRight)")

-- Buffer
nnoremap("<A-.>", "<cmd>BufferNext<CR>")
nnoremap("<A-,>", "<cmd>BufferPrevious<CR>")
nnoremap("<A-<>", "<cmd>BufferMovePrevious<CR>")
nnoremap("<A->>", "<cmd>BufferMoveNext<CR>")

-- Smoothie
vim.cmd[[
nnoremap <unique> <C-D> <cmd>call smoothie#do("\<C-D>") <CR>
vnoremap <unique> <C-D> <cmd>call smoothie#do("\<C-D>") <CR>
nnoremap <unique> <C-U> <cmd>call smoothie#do("\<C-U>") <CR>
vnoremap <unique> <C-U> <cmd>call smoothie#do("\<C-U>") <CR>
vnoremap <unique> zz <cmd>call smoothie#do("zz") <CR>
nnoremap <unique> zz <cmd>call smoothie#do("zz") <CR>
vnoremap <unique> zu <cmd>call smoothie#do("zt") <CR>
nnoremap <unique> zu <cmd>call smoothie#do("zt") <CR>
vnoremap <unique> zd <cmd>call smoothie#do("zb") <CR>
nnoremap <unique> zd <cmd>call smoothie#do("zb") <CR>
vnoremap <unique> <C-E> <cmd>call smoothie#do("\<C-E>") <CR>
nnoremap <unique> <C-E> <cmd>call smoothie#do("\<C-E>") <CR>
]]

-- Copilot
imap("<C-L>", "<Plug>(copilot-accept-word)")
imap("<C-J>", "<Plug>(copilot-accept-line)")
imap("<C-]>", "<Plug>(copilot-next)")
imap("<C-[>", "<Plug>(copilot-previous)")

-- Sandwich
nmap("si", "<Plug>(sandwich-add)")
xmap("si", "<Plug>(sandwich-add)")
nmap("sd", "<Plug>(sandwich-delete)")
xmap("sd", "<Plug>(sandwich-delete)")
nmap("sr", "<Plug>(sandwich-replace)")
xmap("sr", "<Plug>(sandwich-replace)")

-- Tmux
nnoremap("<C-h>", ":NvimTmuxNavigateLeft<CR>")
nnoremap("<C-l>", ":NvimTmuxNavigateRight<CR>")
nnoremap("<C-j>", ":NvimTmuxNavigateDown<CR>")
nnoremap("<C-k>", ":NvimTmuxNavigateUp<CR>")


-- Telescope bookmark
nmap("ml", ":Telescope bookmarks list theme=dropdown<CR>")

-- End Plugins ---------------------------------------

-- Macro over visual
vim.cmd[[
  xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

  function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
  endfunction

]]

nnoremap("<C-s>", ":w<CR>")
nnoremap("<C-q>", ":q<CR>")

-- Yank to end of line
nnoremap("Y", "y$")

-- Different register for delete and paste
nnoremap("<leader>d", '\"_d')
vnoremap("<leader>d", '\"_d')
nnoremap("d", '\"_d')
vnoremap("d", '\"_d')
nnoremap("x", '\"_x')
vnoremap("p", '\"_dP')
nnoremap("P", '\"_d')
vnoremap("<LeftRelease>", '\"+y<LeftRelease>')

-- Copy to system clippboard
nnoremap("y", '\"+y')
vnoremap("y", '\"+y')
vnoremap("<C-c>", '\"+y') -- Windows behavior

-- Paste from system clippboard
nnoremap("p", '\"+p')
vnoremap("p", '\"+p')
vnoremap ("<C-v>", '\"+p') -- Windows behavior

-- Easy motion for begin and end lines
nnoremap("L", "$")
nnoremap("H", "^")
vnoremap("L", "$")
vnoremap("H", "^")

-- Select ocurrence and replace
nnoremap("R", "*``cgn")
vim.cmd[[xnoremap R y<cmd>let @/=escape(@", '/')<cr>"_cgn]]
