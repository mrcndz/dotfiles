vim.g.mapleader = ' '
vim.g.do_file_type_lua = 1

local opt = vim.opt

opt.cmdheight = 0
opt.shortmess:append 'sIF'
-- keep intermediate session-restore states off screen: with cmdheight=0 the
-- cmdline claims the statusline row while the session's commands run
opt.lazyredraw = true
vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    vim.defer_fn(function()
      vim.o.lazyredraw = false
      require('config.statusline').fade_in()
    end, 500)
  end,
})
opt.autowrite = true
opt.autoread = true
opt.swapfile = false
vim.schedule(function()
  opt.clipboard = vim.env.SSH_TTY and '' or 'unnamedplus'
end)
opt.completeopt = 'menu,menuone,noselect'
opt.cursorline = true
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
opt.ignorecase = true
opt.inccommand = 'nosplit'
opt.hlsearch = true
opt.incsearch = true
opt.jumpoptions = 'view'
opt.laststatus = 3
opt.linebreak = true
opt.list = true
opt.mouse = 'a'
opt.ruler = false
opt.scrolloff = 4
opt.pumblend = 10
opt.conceallevel = 2
opt.confirm = true
opt.expandtab = true
opt.pumheight = 10
opt.relativenumber = true
opt.number = true
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }
opt.shiftround = true
opt.shiftwidth = 2
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = 'yes'
opt.smartcase = true
opt.smartindent = true
opt.spelllang = { 'en' }
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 1000 or 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 1000
opt.splitbelow = true
opt.splitkeep = 'screen'
opt.splitright = true
opt.virtualedit = 'block'
opt.wildmode = 'longest:full,full'
opt.winminwidth = 5
opt.wrap = true
opt.smoothscroll = true

-- load and set synchronously so the custom bar (and its highlights) are
-- there from the first frame
require 'config.statusline'
vim.o.laststatus = 3
vim.o.statusline = "%!v:lua.require'config.statusline'.render()"
