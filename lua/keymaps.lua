-- General keymaps that are not pluggin dependant
local Utils = require('utils')

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
nnoremap("<A-k>", ":m .-2<CR>==")
nnoremap("<A-j>", ":m .+1<CR>==")

if vim.g.vscode then
  nnoremap ("<C-j>", ':call VSCodeNotify("workbench.action.navigateDown")<CR>')
  xnoremap ("<C-j>", ':call VSCodeNotify("workbench.action.navigateDown")<CR>')
  nnoremap ("<C-k>", ':call VSCodeNotify("workbench.action.navigateUp")<CR>')
  xnoremap ("<C-k>", ':call VSCodeNotify("workbench.action.navigateUp")<CR>')
  nnoremap ("<C-h>", ':call VSCodeNotify("workbench.action.navigateLeft")<CR>')
  xnoremap ("<C-h>", ':call VSCodeNotify("workbench.action.navigateLeft")<CR>')
  nnoremap ("<silent><C-l>", ':call VSCodeNotify("workbench.action.navigateRight")<CR>')
  xnoremap ("<silent><C-l>", ':call VSCodeNotify("workbench.action.navigateRight")<CR>')
else
  -- Move Through windows
  nnoremap("<C-h>", "<C-w>h")
  nnoremap("<C-j>", "<C-w>j")
  nnoremap("<C-k>", "<C-w>k")
  nnoremap("<C-l>", "<C-w>l")

  -- NerdTree mapping
  nnoremap("<silent>", "<C-n> :NERDTree<CR>")
  nnoremap("<silent>", "<C-t> :NERDTreeToggle<CR>")
  nnoremap("<silent>", "<C-f> :NERDTreeFind<CR>")

  -- Tmux navigator
  nnoremap("<silent>", "<C-h> :TmuxNavigateLeft<cr>")
  nnoremap("<silent>", "<C-l> :TmuxNavigateRight<cr>")
  nnoremap("<silent>", "<C-j> :TmuxNavigateDown<cr>")
  nnoremap("<silent>", "<C-k> :TmuxNavigateUp<cr>")
-- Else

end


-- Disable hl with 2 esc
nnoremap("<silent><esc>", "<esc>:noh<CR><esc>")
vnoremap("<silent><esc>", "<esc>:noh<CR><esc>")
inoremap("<silent><esc>", "<esc>:noh<CR><esc>")

-- Trim white spaces
-- nnoremap ("<F2>", ":let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>")

-- page up/down with recentering
nnoremap("<C-u>", "<C-u>zz")
nnoremap("<C-d>", "<C-d>zz")

-- Run omnifunc, mostly used for autocomplete
inoremap("<C-SPACE>", "<C-x><C-o>")

-- Save with Ctrl + S
nnoremap("<C-s>", ":w<CR>")

-- Switch buffers (needs nvim-bufferline)
-- nnoremap("<TAB>", ":BufferLineCycleNext<CR>")
-- nnoremap("<S-TAB>", ":BufferLineCyclePrev<CR>")

-- Splits
-- nnoremap("<leader>ws", ":split<CR>")
-- nnoremap("<leader>vs", ":vsplit<CR>")

-- Populate substitution
nnoremap("<leader>s", ":s//g<Left><Left>")
nnoremap("<leader>S", ":%s//g<Left><Left>")
nnoremap("<leader><C-s>", ":%s//gc<Left><Left><Left>")

vnoremap("<leader>s", ":s//g<Left><Left>")
vnoremap("<leader><A-s>", ":%s//g<Left><Left>")
vnoremap("<leader>S", ":%s//gc<Left><Left><Left>")

-- Delete buffer
-- nnoremap("<A-w>", ":bd<CR>")

-- Yank to end of line
nnoremap("Y", "y$")

-- Paste into selection without overwriting p register
xnoremap("<leader>p", '\"_dP')

-- Delete without overwriting register
nnoremap("<leader>d", '\"_d')
vnoremap("<leader>d", '\"_d')

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
