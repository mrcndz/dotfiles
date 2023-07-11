vim.cmd [[
" Better Navigation
nnoremap <silent> <leader>j :call VSCodeNotify('workbench.action.navigateDown')<CR>
xnoremap <silent> <leader>j :call VSCodeNotify('workbench.action.navigateDown')<CR>
nnoremap <silent> <leader>k :call VSCodeNotify('workbench.action.navigateUp')<CR>
xnoremap <silent> <leader>k :call VSCodeNotify('workbench.action.navigateUp')<CR>
nnoremap <silent> <leader>l :call VSCodeNotify('workbench.action.nextEditor')<CR>
xnoremap <silent> <leader>l :call VSCodeNotify('workbench.action.nextEditor')<CR>
nnoremap <silent> <leader>h :call VSCodeNotify('workbench.action.previousEditor')<CR>
xnoremap <silent> <leader>h :call VSCodeNotify('workbench.action.previousEditor')<CR>

" Find
nnoremap <silent> / :call VSCodeNotify('actions.find')<CR>
xnoremap <silent> / :call VSCodeNotify('actions.find')<CR>
nnoremap <silent> n :call VSCodeNotify('editor.action.nextMatchFindAction')<CR>
nnoremap <silent> N :call VSCodeNotify('editor.action.previousMatchFindAction')<CR>
xnoremap <silent> N :call VSCodeNotify('editor.action.previousMatchFindAction')<CR>
xnoremap <silent> n :call VSCodeNotify('editor.action.nextMatchFindAction')<CR>
nnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>
xnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>

" Jupyter
nnoremap <silent> <leader>jr :call VSCodeNotify('jupyter.runcurrentcell')<CR>
nnoremap <silent> <leader>jk :call VSCodeNotify('jupyter.restartkernel')<CR>
nnoremap <silent> <leader>js :call VSCodeNotify('jupyter.debugstop')<CR>
nnoremap <silent> <leader>jy :call VSCodeNotify('jupyter.interactive.copyCell')<CR>
nnoremap <silent> <leader>jy :call VSCodeNotify('notebook.cell.cut')<CR>
]]


