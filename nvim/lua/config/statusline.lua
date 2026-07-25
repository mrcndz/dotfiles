local M = {}

local modes = {
  n = 'NORMAL',
  i = 'INSERT',
  v = 'VISUAL',
  V = 'V-LINE',
  ['\22'] = 'V-BLOCK',
  c = 'COMMAND',
  R = 'REPLACE',
  s = 'SELECT',
  t = 'TERMINAL',
}

local icons = {
  nvim = '\u{e6ae}', --
  branch = '\u{e0a0}', --
  gear = '\u{f013}', --
}

local function set_hl()
  local red = vim.api.nvim_get_hl(0, { name = 'Error', link = false }).fg or 0xe06c75
  vim.api.nvim_set_hl(0, 'StatusLineBranch', { fg = red })
  vim.api.nvim_set_hl(0, 'StatusLine', { reverse = false })
  vim.api.nvim_set_hl(0, 'StatusLineNC', { reverse = false })
  vim.api.nvim_set_hl(0, 'StatusLineRec', { fg = '#ff0000', bold = true })
end
set_hl()
vim.api.nvim_create_autocmd('ColorScheme', { callback = set_hl })

function M.render()
  local parts = { icons.nvim .. ' ' .. (modes[vim.fn.mode():sub(1, 1)] or vim.fn.mode()) }

  local branch = vim.b.gitsigns_head
  if branch then
    parts[#parts + 1] = '%#StatusLineBranch#' .. icons.branch .. ' ' .. branch .. '%*'
  end

  local reg = vim.fn.reg_recording()
  if reg ~= '' then
    parts[#parts + 1] = '%#StatusLineRec#REC @' .. reg .. '%*'
  end

  parts[#parts + 1] = '%='
  if next(vim.lsp.get_clients { bufnr = 0 }) then
    parts[#parts + 1] = icons.gear .. ' LSP'
  end
  parts[#parts + 1] = '%l:%c '

  return ' ' .. table.concat(parts, '  ')
end

vim.api.nvim_create_autocmd({ 'RecordingEnter', 'RecordingLeave' }, {
  callback = function()
    vim.schedule(function()
      vim.cmd.redrawstatus()
    end)
  end,
})

local function channel(c, div)
  return math.floor(c / div) % 256
end

local function blend(from, to, t)
  local r = channel(from, 65536) + (channel(to, 65536) - channel(from, 65536)) * t
  local g = channel(from, 256) + (channel(to, 256) - channel(from, 256)) * t
  local b = channel(from, 1) + (channel(to, 1) - channel(from, 1)) * t
  return ('#%02x%02x%02x'):format(r, g, b)
end

-- Fade the bar in from the background color at startup.
function M.fade_in()
  local normal = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })
  if not normal.bg then return end

  local targets = {}
  for _, name in ipairs { 'StatusLine', 'StatusLineBranch', 'StatusLineRec' } do
    local def = vim.api.nvim_get_hl(0, { name = name, link = false })
    if def.fg then targets[name] = def end
  end

  local steps, step = 8, 0
  local function tick()
    step = step + 1
    local t = step / steps
    for name, def in pairs(targets) do
      vim.api.nvim_set_hl(0, name, vim.tbl_extend('force', def, { fg = blend(normal.bg, def.fg, t) }))
    end
    vim.cmd.redrawstatus()
    if step < steps then vim.defer_fn(tick, 25) end
  end
  tick()
end

return M
