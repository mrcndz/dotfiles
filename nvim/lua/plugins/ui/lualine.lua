return {
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local function fileiconpath()
        local filename = vim.fn.expand('%:t')
        local extension = vim.fn.expand('%:e')
        local filepath = vim.fn.expand('%:~:.')

        local icon = require('nvim-web-devicons').get_icon(filename, extension)

        if icon == nil then
          return '' .. filepath
        end

        return icon .. ' ' .. filepath
      end

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = { 'NvimTree' },
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = { 'branch', 'diagnostics'},
          lualine_c = { fileiconpath,},
          lualine_x = { 'diff' },
          lualine_y = { 'location' },
          lualine_z = { 'progress' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {'branch'},
          lualine_c = {fileiconpath},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
      }
    end,
  }
}
