local autocmd = vim.api.nvim_create_autocmd

if package.loaded['nvim-tree'] then
  autocmd({ 'BufEnter' }, {
    callback = function()
      local filepath = vim.fn.expand '%:p'
      local ntree_api = require 'nvim-tree.api'
      ntree_api.tree.find_file(filepath)
    end,
  })
end
