-- General keymaps that are not pluggin dependant
local Utils = require "user.vscode.utils"

-- local exprnnoremap = Utils.exprnnoremap
local nnoremap = Utils.nnoremap
local vnoremap = Utils.vnoremap
local xnoremap = Utils.xnoremap
local inoremap = Utils.inoremap
local tnoremap = Utils.tnoremap
local nmap = Utils.nmap
local xmap = Utils.xmap


vim.cmd[[
" Better Navigation
nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
xnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>

nnoremap <silent> <S-d> :call VSCodeNotify('workbench.action.openLink')<CR>"
xnoremap <silent> <S-d> :call VSCodeNotify('workbench.action.openLink')<CR>"

nnoremap <silent> <Space>c :call VSCodeNotify('editor.action.addCommentLine')<CR>"
xnoremap <silent> <Space>c :call VSCodeNotify('editor.action.addCommentLine')<CR>"
nnoremap <silent> <Space>b :call VSCodeNotify('editor.action.addBlockComment')<CR>"
xnoremap <silent> <Space>b :call VSCodeNotify('editor.action.addBlockComment')<CR>"

-- Move lines
nnoremap <A-k> :m .-2<CR>==)
nnoremap <A-j> :m .+1<CR>==)
]]

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
