-- Session persistence for the tree (open/closed, unfolded dirs, scroll,
-- width) plus its fade-in. Lives here with the plugin; this top-level code
-- runs at startup when lazy collects specs, and registers itself as the
-- requirable module 'tree-session' for auto-session's hooks and the
-- session extra-cmds file.
local ts = { tree_open = nil }

local function state_file()
  return vim.fn.stdpath('state') .. '/tree-state-' .. vim.fn.getcwd():gsub('[^%w]', '_') .. '.json'
end

local function read_state()
  local ok, lines = pcall(vim.fn.readfile, state_file())
  if not ok or not lines[1] then return nil end
  local ok2, data = pcall(vim.json.decode, lines[1])
  return ok2 and data or nil
end

local function tree_win()
  for _, w in ipairs(vim.api.nvim_list_wins()) do
    if vim.bo[vim.api.nvim_win_get_buf(w)].filetype == 'NvimTree' then
      return w
    end
  end
end

local function save_state(win)
  local dirs = {}
  local function collect_open(node)
    for _, n in ipairs(node and node.nodes or {}) do
      if n.nodes then
        if n.open then dirs[#dirs + 1] = n.absolute_path end
        collect_open(n)
      end
    end
  end
  pcall(function() collect_open(require('nvim-tree.api').tree.get_nodes()) end)
  local view = vim.api.nvim_win_call(win, vim.fn.winsaveview)
  local data = { dirs = dirs, topline = view.topline, lnum = view.lnum, width = vim.api.nvim_win_get_width(win) }
  vim.fn.writefile({ vim.json.encode(data) }, state_file())
end

-- node.expand needs live node objects, so unfold by revealing a child instead
local function unfold(dirs)
  for _, dir in ipairs(dirs or {}) do
    local child
    for name in vim.fs.dir(dir) do
      child = dir .. '/' .. name
      break
    end
    if child then
      pcall(require('nvim-tree.api').tree.find_file, { buf = child, open = false, focus = false })
    end
  end
end

local function slide_open(win, width)
  local step, total = 0, 10
  local function tick()
    if not vim.api.nvim_win_is_valid(win) then return end
    step = step + 1
    local t = step / total
    local eased = 1 - (1 - t) * (1 - t)
    vim.api.nvim_win_set_width(win, math.max(1, math.floor(width * eased)))
    if step < total then
      vim.defer_fn(tick, 12)
    end
  end
  tick()
end

-- Runs from the session's extra cmds file after restore. Deferred past the
-- startup lazyredraw hold (500ms, see options.lua) so the slide is visible.
function ts.restore()
  vim.defer_fn(function()
    local api = require('nvim-tree.api')
    local data = read_state() or {}

    local ready = false
    api.events.subscribe(api.events.Event.TreeOpen, function()
      if ready then return end
      ready = true
      vim.schedule(function()
        local win = tree_win()
        if not win then return end
        vim.api.nvim_win_set_width(win, 1)
        unfold(data.dirs)
        if data.topline then
          vim.api.nvim_win_call(win, function()
            vim.fn.winrestview { topline = data.topline, lnum = data.lnum or 1, col = 0 }
          end)
        end
        slide_open(win, data.width or 30)
      end)
    end)

    api.tree.toggle { focus = false }
  end, 520)
end

-- auto-session hooks
function ts.stash_if_open()
  if not package.loaded['nvim-tree'] then return end
  local api = require('nvim-tree.api')
  if ts.tree_open == nil then -- manual save: ExitPre hasn't fired
    ts.tree_open = api.tree.is_visible()
  end
  if not ts.tree_open then return end
  local win = tree_win()
  if win then save_state(win) end
  api.tree.close()
end

function ts.extra_cmd()
  if ts.tree_open then
    return [[lua require('tree-session').restore()]]
  end
  return ''
end

function ts.after_save()
  if ts.tree_open and vim.v.exiting == vim.NIL then
    require('nvim-tree.api').tree.toggle { focus = false }
  end
  ts.tree_open = nil
end

-- ExitPre: the last moment the window layout is still intact on quit
vim.api.nvim_create_autocmd('ExitPre', {
  callback = function()
    local ok, api = pcall(require, 'nvim-tree.api')
    ts.tree_open = (ok and package.loaded['nvim-tree'] and api.tree.is_visible()) or false
  end,
})

package.loaded['tree-session'] = ts
package.loaded['config.tree-session'] = ts -- old session files reference this name

return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = true,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    {
      '<leader>e',
      '<cmd>NvimTreeToggle<cr>',
      desc = 'Toggle file explorer',
    },
  },
  config = function()
    local function my_on_attach(bufnr)
      local api = require('nvim-tree.api')

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- Usar keymaps padrão primeiro
      api.config.mappings.default_on_attach(bufnr)

      -- Keymaps customizados
      vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
      vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
      vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
      vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: Horizontal Split'))
      vim.keymap.set('n', 't', api.node.open.tab, opts('Open: New Tab'))
      vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
      vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
      vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
      vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
      vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
      vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
      vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
      vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
      vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
      vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
      vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
      vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
      vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
      vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
      vim.keymap.set('n', '<leader>g', function()
        api.tree.collapse_all()
        api.tree.toggle_git_clean_filter()
        api.tree.expand_all()
      end, opts('Toggle git changes view'))
    end

    local function open_nvim_tree(data)
      local directory = vim.fn.isdirectory(data.file) == 1
      local buf_valid = vim.api.nvim_buf_is_valid(data.buf)
      local no_name = data.file == '' and buf_valid and vim.bo[data.buf].buftype == ''
      if not directory and not no_name then return end
      if directory then vim.cmd.cd(data.file) end
      require('nvim-tree.api').tree.open()
    end
    vim.api.nvim_create_autocmd('VimEnter', { callback = open_nvim_tree })

    require('nvim-tree').setup {
      on_attach = my_on_attach,
      disable_netrw = true,
      hijack_netrw = true,
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      view = {
        width = 30,
        side = 'left',
      },
      filters = {
        dotfiles = false,
        custom = { '.git', 'node_modules', '.cache' },
      },
      git = {
        enable = true,
        ignore = false,
      },
      actions = {
        open_file = {
          quit_on_open = false,
          resize_window = true,
        },
      },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
    }
  end,
}

