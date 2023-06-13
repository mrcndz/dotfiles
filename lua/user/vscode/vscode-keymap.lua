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

" Find
nnoremap <silent> / :call VSCodeNotify('actions.find')<CR>
xnoremap <silent> / :call VSCodeNotify('actions.find')<CR>
nnoremap <silent> n :call VSCodeNotify('editor.action.nextMatchFindAction')<CR>
nnoremap <silent> N :call VSCodeNotify('editor.action.previousMatchFindAction')<CR>
xnoremap <silent> N :call VSCodeNotify('editor.action.previousMatchFindAction')<CR>
xnoremap <silent> n :call VSCodeNotify('editor.action.nextMatchFindAction')<CR>
]]