return {
    'alexghergh/nvim-tmux-navigation',
    config = function() 
        require'nvim-tmux-navigation'.setup{}
        local nnoremap = require('utils').nnoremap
        nnoremap("<C-h>", ":NvimTmuxNavigateLeft<CR>")
        nnoremap("<C-l>", ":NvimTmuxNavigateRight<CR>")
        nnoremap("<C-j>", ":NvimTmuxNavigateDown<CR>")
        nnoremap("<C-k>", ":NvimTmuxNavigateUp<CR>")
    end,
}
