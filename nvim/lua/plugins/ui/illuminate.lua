return {
    'RRethy/vim-illuminate',
    config = function()
        require('illuminate').configure({
            delay = 50,
        })
    end,
}
