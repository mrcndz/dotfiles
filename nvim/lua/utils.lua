local M = {}

function M.get_bufnr(name)
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_name(bufnr) == name then
      return bufnr
    end
  end
  return nil
end

-- Open a file only if it's exists in the :pwd directory
-- Even if its a absolute path
function M.open_file(file)
  if vim.fn.filereadable(file) == 1 then
    local abs_file_path = vim.fn.fnamemodify(file, ':p')
    local cwd = vim.fn.getcwd()

    if abs_file_path:find(cwd, 1, true) == 1 then
      vim.cmd('e ' .. file)
    end
  end
end

return M
