local M = {}

M.fancy_lsp_status = function()
  local is_attached = vim.lsp.buf_is_attached()
  local icon = { on = ' ⚡', off = ' 💤' }

  if is_attached then
    return 'lsp' .. icon.on
  else
    return 'lsp' .. icon.off
  end
end

return M
