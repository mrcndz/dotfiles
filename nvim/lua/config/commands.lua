local autocmd = vim.api.nvim_create_autocmd

-- Autopin Barbar plugin and close close
if package.loaded['barbar'] then
  autocmd({ 'BufRead' }, {
    pattern = { '*' },
    callback = function()
      vim.api.nvim_create_autocmd({ 'BufModifiedSet' }, {
        buffer = 0,
        once = true,
        callback = function()
          vim.cmd('BufferPin')
        end,
      })
    end,
  })

  autocmd({ 'BufAdd' }, {
    pattern = { '*' },
    callback = function()
      vim.cmd('BufferCloseAllButCurrentOrPinned')
    end,
  })
end

-- Autoclose nvim tree when its the only window
if package.loaded['nvim-tree.lua'] then
  autocmd({ 'BufEnter' }, {
    pattern = { 'NvimTree' },
    callback = function()
      if vim.api.nvim_list_wins():len() == 1 then
        vim.cmd('NvimTreeClose')
      end
    end,
  })
end
