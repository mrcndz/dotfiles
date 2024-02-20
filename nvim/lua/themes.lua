-- Themes
vim.cmd[[
  syntax enable
  if has('termguicolors')
    set termguicolors
  endif

  " Available values: 'light', 'dark'
  set background=dark
  " Available values: 'hard', 'medium'(default), 'soft'
  let g:everforest_background = 'hard'
  let g:everforest_better_performance = 1
  colorscheme everforest
]]
