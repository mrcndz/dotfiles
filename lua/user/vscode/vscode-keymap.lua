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
nnoremap <silent> <leader>t :call VSCodeNotify('workbench.action.togglePanel')<CR>
nnoremap <silent> <leader>: :call VSCodeNotify('workbench.action.quickOpenView')<CR>
xnoremap <silent> <leader>: :call VSCodeNotify('workbench.action.quickOpenView')<CR>
nnoremap <silent> <leader>; :call VSCodeNotify('workbench.action.quickOpenView')<CR>
xnoremap <silent> <leader>; :call VSCodeNotify('workbench.action.quickOpenView')<CR>
nnoremap <silent> <leader>z :call VSCodeNotify('workbench.action.toggleZenMode')<CR>
]]

-- Vscode keybindings
--   // Neovim
--   { "key": "shift shift", "command": "workbench.action.showCommands"},
--   // Close find widget NVIM PURPOSE
--   { "key": "enter", "command": "closeFindWidget", "when": "findWidgetVisible && !isComposing" },
--   // Return to normal
--   { "command": "vscode-neovim.compositeEscape1", "key": "j", "when": "neovim.mode == insert && editorTextFocus", "args": "j"
--   }, // Disable crtl + movement commands  
--   { "command": "-vscode-neovim.send", "key": "ctrl+h", "when": "editorTextFocus", "args": "" },
--   { "command": "-vscode-neovim.send", "key": "ctrl+j", "when": "editortextfocus", "args": "" },
--   { "command": "-vscode-neovim.send", "key": "ctrl+k", "when": "editortextfocus", "args": "" },
--   { "command": "-vscode-neovim.send", "key": "ctrl+l", "when": "editorTextFocus", "args": "" },
--   /// Movement
--   {"key": "cmd+l", "command": "workbench.action.nextEditor" }, 
--   {"key": "cmd+h", "command": "workbench.action.previousEditor"},
--   {"key": "cmd+j", "command": "workbench.action.navigateDown"},
--   {"key": "cmd+d", "command": "vscode-neovim.ctrl-d"},
--   {"key": "cmd+u", "command": "vscode-neovim.ctrl-u"},
--   {"key": "cmd+i", "command": "workbench.action.focusActiveEditorGroup", "when": "!editorTextFocus" }