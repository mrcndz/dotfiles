-- General keymaps that are not pluggin dependant
local Utils = require('user.utils')

-- local exprnnoremap = Utils.exprnnoremap
local nnoremap = Utils.nnoremap
local vnoremap = Utils.vnoremap
local xnoremap = Utils.xnoremap
local inoremap = Utils.inoremap
local tnoremap = Utils.tnoremap
local nmap = Utils.nmap
local xmap = Utils.xmap

-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

-- Command mapping
nmap("<leader>r", ":so ~/.config/nvim/init.lua<CR>")
nnoremap("<leader>e", ":PlugInstall<CR>")
nnoremap("<leader>q", ":q<CR>")
nmap("si", "<Plug>(sandwich-add)")

-- Move lines
-- nnoremap("<A-k>", ":m .-2<CR>==")
-- nnoremap("<A-j>", ":m .+1<CR>==")

-- Disable hl with 2 esc
nnoremap("<silent><esc>", "<esc>:noh<CR><esc>")
vnoremap("<silent><esc>", "<esc>:noh<CR><esc>")
-- inoremap("<silent><esc>", "<esc>:noh<CR><esc>")

-- Trim white spaces
-- nnoremap ("<F2>", ":let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>")

-- Page up/down with recentering
-- nnoremap("<C-u>", "<C-u>zz")
-- nnoremap("<C-d>", "<C-d>zz")

-- Run omnifunc, mostly used for autocomplete
-- inoremap("<C-SPACE>", "<C-x><C-o>")

-- Save with Ctrl + S
nnoremap("<C-s>", ":w<CR>")

-- Switch buffers (needs nvim-bufferline)
-- nnoremap("<TAB>", ":BufferLineCycleNext<CR>")
-- nnoremap("<S-TAB>", ":BufferLineCyclePrev<CR>")

-- Splits
-- nnoremap("<leader>ws", ":split<CR>")
-- nnoremap("<leader>vs", ":vsplit<CR>")

-- Populate substitution
-- nnoremap("<leader>s", ":s//g<Left><Left>")
-- nnoremap("<leader>S", ":%s//g<Left><Left>")
-- nnoremap("<leader><C-s>", ":%s//gc<Left><Left><Left>")
-- vnoremap("<leader>s", ":s//g<Left><Left>")
-- vnoremap("<leader><A-s>", ":%s//g<Left><Left>")
-- vnoremap("<leader>S", ":%s//gc<Left><Left><Left>")

-- Delete buffer
-- nnoremap("<A-w>", ":bd<CR>")

-- Yank to end of line
nnoremap("Y", "y$")

-- Paste into selection without overwriting p register
xnoremap("<leader>p", '\"_dP')

-- Delete without overwriting register
-- nnoremap("<leader>d", '\"_d')
-- vnoremap("<leader>d", '\"_d')

-- Different register for delete and paste
nnoremap("d", '\"_d')
vnoremap("d", '\"_d')
vnoremap("p", '\"_dP')
nnoremap("x", '\"_x')
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
