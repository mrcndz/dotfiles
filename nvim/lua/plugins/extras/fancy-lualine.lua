local M = {}

M.fancy_lsp_status = function()
  local is_attached = vim.lsp.buf_is_attached()
  local icon = { on = ' ⚡', off = ' 💤' }
end

return M
