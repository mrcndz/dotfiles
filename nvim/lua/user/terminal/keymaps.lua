-- Windows keymaps
--
-- Move Through windows
vim.cmd[[
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" -- NerdTree mapping
nnoremap <silent> <C-n> :NERDTree<CR>
nnoremap <silent> <C-t> :NERDTreeToggle<CR>
nnoremap <silent> <C-f> :NERDTreeFind<CR>

" -- Tmux navigator
"nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
"nnoremap <silent> <C-l> :TmuxNavigateRight<CR>
"nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
"nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
]]
