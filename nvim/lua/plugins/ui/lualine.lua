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
      local utils = require('lualine.utils.utils')
      local colors = {
        insert = utils.extract_color_from_hllist('bg', { 'PmenuSel', 'PmenuThumb', 'TabLineSel' }, '#000000'),
        normal = utils.extract_color_from_hllist('fg', { 'DevIconDefault' }, '#000000'),
        replace = utils.extract_color_from_hllist('fg', { 'Number', 'Type' }, '#000000'),
        visual = utils.extract_color_from_hllist('fg', { 'Special', 'Boolean', 'Constant' }, '#000000'),
        command = utils.extract_color_from_hllist('fg', { 'Identifier' }, '#000000'),
        icon = utils.extract_color_from_hllist('fg', { '@string' }, '#000000'),
      }

      local theme = {
        normal = {
          a = { bg = bg },
          b = { bg = bg, fg = colors.normal },
          c = { bg = bg },
        },
        insert = {
          a = { bg = bg },
          b = { bg = bg, fg = 'orange' },
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

      require('lualine').setup({
        options = {
          icons_enabled = true,
          globalstatus = true,
          theme = theme,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = { 'NvimTree', 'DiffviewPanel' },
        },
        sections = {
          lualine_a = {
            { nvim_icon, color = { fg = colors.icon } },
          },
          lualine_b = {
            { 'mode' },
          },
          lualine_c = {
            { 'branch', icon = '', color = { fg = 'cyan' } },
            { 'diagnostics', color = { bg = bg } },
            { 'filename', icon = { '', color = { fg = 'white' } }, filestatus = true, symbols = { modified = '', readonly = '', unnamed = '󰡯', newfile = '' }, path = 1, color = { fg = 'gray' } },
            { 'filetype', icon_only = true, color = { bg = bg }, padding = { left = 1, right = 1 } },
          },
          lualine_x = { color = { bg = bg } },
          lualine_y = { { 'location', icon = '', color = { fg = 'orange' } }, { 'progress', icon = '󰉸', color = { fg = 'orange' } } },
          lualine_z = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
}
