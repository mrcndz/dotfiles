vim.cmd [[
" Better Navigation
nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
xnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
nnoremap <silent> <Space>c :call VSCodeNotify('editor.action.addCommentLine')<CR>
xnoremap <silent> <Space>c :call VSCodeNotify('editor.action.addCommentLine')<CR>
nnoremap <silent> <Space>b :call VSCodeNotify('editor.action.addBlockComment')<CR>
xnoremap <silent> <Space>b :call VSCodeNotify('editor.action.addBlockComment')<CR>

]]