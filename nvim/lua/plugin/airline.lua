local icons = require('nvim-web-devicons')

-- Options
vim.g.airline_extensions_tabline_enabled = 1
vim.g.airline_powerline_fonts = 1
vim.g.airline_left_sep = ''
vim.g.airline_left_alt_sep = ''
vim.g.airline_right_sep = ''
vim.g.airline_right_alt_sep = ''

vim.g.airline_section_y = '%3p%%'
vim.g.airline_section_z = '%3l:%c'

local get_icon_with_filename = function()
  local icon, iconhl = icons.get_icon(vim.fn.expand('%:t'), vim.fn.expand('%:e'))
  if icon == nil then
    return '' .. vim.fn.expand('%:~:.')
  end
  return '' .. icon .. ' ' .. vim.fn.expand('%:~:.')
end

local filename = get_icon_with_filename()
vim.g.airline_section_c = filename
