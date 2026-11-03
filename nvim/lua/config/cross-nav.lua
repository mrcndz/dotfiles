-- Seamless <C-h/j/k/l> between Neovim splits and the panes around Neovim: at a split edge,
-- focus crosses into the neighbouring pane of whatever runs Neovim (herdr, tmux or Tern).
-- Loaded after plugins (navigation.lua), so it wins over other <C-h/j/k/l> mappings.

local function cross(dir)
  if vim.env.HERDR_PANE_ID and vim.env.HERDR_PANE_ID ~= "" then
    local herdr = vim.env.HERDR_BIN_PATH
    if herdr == nil or herdr == "" then
      herdr = "herdr"
    end
    vim.fn.system({ herdr, "pane", "focus", "--direction", dir, "--current" })
  elseif vim.env.TMUX and vim.env.TMUX ~= "" then
    local tmux = { left = "Left", down = "Down", up = "Up", right = "Right" }
    pcall(vim.cmd, "TmuxNavigate" .. tmux[dir])
  elseif vim.env.TERN_PANE and vim.env.TERN_PANE ~= "" then
    vim.fn.jobstart({ "/Applications/Tern.app/Contents/MacOS/tern", "ctl", "focus", dir }, { detach = true })
  end
end

local function nav(wincmd, dir)
  local prev = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. wincmd)
  if vim.api.nvim_get_current_win() == prev then
    cross(dir)
  end
end

for key, d in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
  vim.keymap.set("n", "<C-" .. key .. ">", function()
    nav(key, d)
  end, { silent = true, noremap = true, desc = "Navigate " .. d .. " (vim/herdr/tmux/tern)" })
end
