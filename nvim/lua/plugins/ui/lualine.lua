return {
  {
    'linrongbin16/lsp-progress.nvim',
    config = function()
      require('lsp-progress').setup()
    end,
  },
  {
    'nvim-lualine/lualine.nvim',

    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local bg = '#' .. vim.api.nvim_get_hl_by_name('Normal', true).background
      local utils = require 'lualine.utils.utils'
      local colors = {
        insert = utils.extract_color_from_hllist('fg', { 'MiniIconsGreen' }, '#000000'),
        normal = utils.extract_color_from_hllist('fg', { 'MiniIconsGrey' }, '#000000'),
        replace = utils.extract_color_from_hllist('fg', { 'MiniIconsBlue' }, '#000000'),
        visual = utils.extract_color_from_hllist('fg', { 'MiniIconsRed' }, '#000000'),
        command = utils.extract_color_from_hllist('fg', { 'MiniIconsBlue' }, '#000000'),
        icon = utils.extract_color_from_hllist('fg', { 'MiniIconsGreen' }, '#000000'),
        git = utils.extract_color_from_hllist('fg', { 'MiniIconsRed' }, '#000000'),
        line = utils.extract_color_from_hllist('fg', { 'MiniIconsRed' }, '#000000'),
        lsp_progress = utils.extract_color_from_hllist('fg', { 'MiniIconsPurple' }, '#000000'),
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
        callback = require('lualine').refresh,
      })
    end,
  },
}
