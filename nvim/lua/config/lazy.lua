local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require('lazy').setup({
  spec = {
    -- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    { import = 'plugins' },
    { import = 'plugins.ui' },
    { import = 'plugins.lsp' },
  },
  defaults = {
    lazy = true,
    version = false,
  },
  checker = { enabled = true, notify = false, frequency = 86400 },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
        'rplugin',
      },
    },
  },
})
