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
    config = function()
      require('guess-indent').setup {}
    end,
  },
  {
    'linrongbin16/lsp-progress.nvim',
    config = function()
      require('lsp-progress').setup {}
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local utils = require 'lualine.utils.utils'
      local bg = utils.extract_color_from_hllist('bg', { 'Normal' }, '')
      local colors = {
        insert = utils.extract_color_from_hllist('fg', { 'MiniIconsGreen' }, ''),
        normal = utils.extract_color_from_hllist('fg', { 'MiniIconsGrey' }, ''),
        replace = utils.extract_color_from_hllist('fg', { 'MiniIconsBlue' }, ''),
        visual = utils.extract_color_from_hllist('fg', { 'MiniIconsRed' }, ''),
        command = utils.extract_color_from_hllist('fg', { 'MiniIconsBlue' }, ''),
        icon = utils.extract_color_from_hllist('fg', { 'MiniIconsGreen' }, ''),
        git = utils.extract_color_from_hllist('fg', { 'MiniIconsRed' }, ''),
        line = utils.extract_color_from_hllist('fg', { 'MiniIconsRed' }, ''),
        lsp_progress = utils.extract_color_from_hllist('fg', { 'MiniIconsPurple' }, ''),
      }

      local theme = {
        normal = {
          a = { bg = bg },
          b = { bg = bg, fg = colors.normal },
          c = { bg = bg },
        },
        insert = {
          a = { bg = bg },
          b = { bg = bg, fg = colors.insert },
          c = { bg = bg },
        },
        replace = {
          a = { bg = bg },
          b = { bg = bg, fg = colors.replace },
          c = { bg = bg },
        },
        visual = {
          a = { bg = bg },
          b = { bg = bg, fg = colors.visual },
          c = { bg = bg },
        },
        command = {
          a = { bg = bg },
          b = { bg = bg, fg = colors.command },
          c = { bg = bg },
        },
      }

      local nvim_icon = function()
        return ''
      end

      require('lualine').setup {
        options = {
          icons_enabled = true,
          globalstatus = true,
          theme = theme,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = { 'NvimTree', 'oil' },
        },
        sections = {
          lualine_a = {
            { nvim_icon, color = { fg = colors.icon } },
          },
          lualine_b = {
            { 'mode' },
          },
          lualine_c = {
            {
              'filename',
              icon = { '', color = { fg = 'grey' } },
              filestatus = true,
              symbols = { modified = '', readonly = '', unnamed = '󰡯', newfile = '' },
              path = 1,
              color = { fg = colors.normal },
            },
            { 'filetype', icon_only = true, color = { bg = bg }, padding = { left = 1, right = 1 } },
            { 'branch', icon = '', color = { fg = colors.git } },
            {
              function()
                local reg = vim.fn.reg_recording()
                return reg ~= '' and 'REC @' .. reg or ''
              end,
              color = { fg = '#ff0000' },
            },
          },
          lualine_x = {
            { 'diagnostics', color = { bg = bg } },
            {
              function()
                return require('lsp-progress').progress()
              end,
              color = { fg = 'gray' },
            },
          },
          lualine_y = {},
          lualine_z = { { 'location', icon = { '', align = 'right' }, color = { fg = colors.line } } },
        },
        inactive_sections = {
          lualine_a = {
            { nvim_icon, color = { fg = colors.icon } },
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      }

      vim.api.nvim_create_augroup('lualine_augroup', { clear = true })
      vim.api.nvim_create_autocmd('User', {
        group = 'lualine_augroup',
        pattern = 'LspProgressStatusUpdated',
        callback = function()
          require('lualine').refresh {}
        end,
      })
      -- NVIM -.11
      vim.api.nvim_set_hl(0, 'StatusLine', { reverse = false })
      vim.api.nvim_set_hl(0, 'StatusLineNC', { reverse = false })
    end,
  },
  {
    'zenbones-theme/zenbones.nvim',
    dependencies = 'rktjmp/lush.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.zenbones_darken_comments = 45
      vim.cmd [[set background=dark]]
      vim.cmd.colorscheme 'kanagawabones'
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {}
    end,
  },
}
