return {
  {
    'Bekaboo/dropbar.nvim',
    event = 'BufReadPost',
    config = function()
      require('dropbar').setup { enable = true }
    end,
  },
  {
    'nmac427/guess-indent.nvim',
    event = 'BufReadPost',
    config = function()
      require('guess-indent').setup {}
    end,
  },
  -- Dark theme
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      require('rose-pine').setup {}
    end,
  },
  -- Light theme
  {
    'yorik1984/newpaper.nvim',
    lazy = false,
    priority = 1000,
  },
  -- Auto theme switcher based on macOS appearance
  {
    'f-person/auto-dark-mode.nvim',
    lazy = false,
    priority = 999,
    config = function()
      local cache = vim.fn.stdpath('state') .. '/appearance'

      local function apply(appearance)
        if appearance == 'light' then
          vim.o.background = 'light'
          vim.cmd.colorscheme 'newpaper'
        else
          vim.o.background = 'dark'
          vim.cmd.colorscheme 'rose-pine-moon'
        end
      end

      apply(vim.fn.filereadable(cache) == 1 and vim.fn.readfile(cache)[1] or 'dark')

      require('auto-dark-mode').setup {
        update_interval = 1000,
        set_dark_mode = function()
          vim.fn.writefile({ 'dark' }, cache)
          apply 'dark'
        end,
        set_light_mode = function()
          vim.fn.writefile({ 'light' }, cache)
          apply 'light'
        end,
      }
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPost',
    config = function()
      require('gitsigns').setup {}
    end,
  },
}
