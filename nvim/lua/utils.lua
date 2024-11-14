function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
end

local M = {}

function M.get_bufnr(name)
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_name(bufnr) == name then
      return bufnr
    end
  end
  return nil
end

function M.is_git_repo()
  return vim.fn.system 'git rev-parse --is-inside-work-tree' == 'true\n'
end

function M.git_top_level()
  return vim.fn.trim(vim.fn.system 'git rev-parse --show-toplevel')
end

function M.is_git_top_level()
  return M.git_top_level() == vim.loop.cwd()
end

function M.map(mode, lhs, rhs)
  vim.api.nvim_set_keymap(mode, lhs, rhs, { silent = true })
end

function M.noremap(mode, lhs, rhs)
  vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true })
end

function M.exprnoremap(mode, lhs, rhs)
  vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true, expr = true })
end

-- Useful mode-specific shortcuts
-- nomenclature: "<expr?><mode><nore?>map(lhs, rhs)" where:
--      "expr?" optional expr option
--      "nore?" optional no-remap option
--      modes -> 'n' = NORMAL, 'i' = INSERT, 'x' = 'VISUAL', 'v' = VISUAL + SELECT, 't' = TERMINAL

function M.imap(lhs, rhs)
  M.map('i', lhs, rhs)
end

function M.nmap(lhs, rhs)
  M.map('n', lhs, rhs)
end

function M.vmap(lhs, rhs)
  M.map('n', lhs, rhs)
end

function M.xmap(lhs, rhs)
  M.map('x', lhs, rhs)
end

function M.nnoremap(lhs, rhs)
  M.noremap('n', lhs, rhs)
end

function M.vnoremap(lhs, rhs)
  M.noremap('v', lhs, rhs)
end

function M.xnoremap(lhs, rhs)
  M.noremap('x', lhs, rhs)
end

function M.inoremap(lhs, rhs)
  M.noremap('i', lhs, rhs)
end

function M.tnoremap(lhs, rhs)
  M.noremap('t', lhs, rhs)
end

function M.exprnnoremap(lhs, rhs)
  M.exprnoremap('n', lhs, rhs)
end

function M.exprinoremap(lhs, rhs)
  M.exprnoremap('i', lhs, rhs)
end

return M
