return {
  'goolord/alpha-nvim',
  config = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')
    dashboard.section.header.val = {
      '                                                     ',
      '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
      '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
      '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
      '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
      '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
      '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
      '                                                     ',
    }
    dashboard.section.buttons.val = {
      dashboard.button('e', ' New file', ':ene <BAR> startinsert <CR>'),
      dashboard.button('f', ' Find File', ':Telescope find_files<CR>'),
      dashboard.button('r', ' Find Recents', ':Telescope oldfiles<CR>'),
      dashboard.button('s', '  > Settings', ':cd $DOTFILES/nvim'),
      dashboard.button('q', '  > Quit NVIM', ':qa<CR>'),
    }

    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
    ]])
  end,
}
