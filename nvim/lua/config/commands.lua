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
