vim.g.mapleader = ' '

function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
end

function _G.feed_esc(...)
  vim.schedule(function()
    vim.api.nvim_input '<Esc>'
  end)
end

require 'config.lazy'
require 'config.options'
require 'config.keymaps'
require 'config.autocmd'
