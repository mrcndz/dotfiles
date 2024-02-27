local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set('n', 'i', api.fs.create, opts('Create'))
    vim.keymap.set('n', 'y', api.fs.copy.node, opts('Copy'))
    vim.keymap.set('n', 'V', api.fs.copy.filename, opts('Copy filename'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    vim.keymap.set('n', '|', api.node.open.vertical, opts('Open: Vertical Split'))
    vim.keymap.set('n', '-', api.node.open.horizontal, opts('Open: Horizontal Split'))
    vim.keymap.set('n', '>', api.tree.change_root_to_node, opts('CD'))
    vim.keymap.set('n', '<', api.tree.change_root_to_parent, opts('CD'))
    vim.keymap.set('n', 't', api.node.open.tab, opts('Open: Tab'))
end

local function tab_win_closed(winnr)
  local api = require"nvim-tree.api"
  local tabnr = vim.api.nvim_win_get_tabpage(winnr)
  local bufnr = vim.api.nvim_win_get_buf(winnr)
  local buf_info = vim.fn.getbufinfo(bufnr)[1]
  local tab_wins = vim.tbl_filter(function(w) return w~=winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
  local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
  if buf_info.name:match(".*NvimTree_%d*$") then            -- close buffer was nvim tree
    -- Close all nvim tree on :q
    if not vim.tbl_isempty(tab_bufs) then                      -- and was not the last window (not closed automatically by code below)
      api.tree.close()
    end
  else                                                      -- else closed buffer was normal buffer
    if #tab_bufs == 1 then                                    -- if there is only 1 buffer left in the tab
      local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
      if last_buf_info.name:match(".*NvimTree_%d*$") then       -- and that buffer is nvim tree
        vim.schedule(function ()
          if #vim.api.nvim_list_wins() == 1 then                -- if its the last buffer in vim
            vim.cmd "quit"                                        -- then close all of vim
          else                                                  -- else there are more tabs open
            vim.api.nvim_win_close(tab_wins[1], true)             -- then close only the tab
          end
        end)
      end
    end
  end
end

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true

    require("nvim-tree").setup {
      on_attach = my_on_attach,
      sort = {
        sorter = "case_sensitive",
       },
       view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    }

    vim.api.nvim_create_autocmd("WinClosed", {
      callback = function ()
        local winnr = tonumber(vim.fn.expand("<amatch>"))
        vim.schedule_wrap(tab_win_closed(winnr))
      end,
      nested = true
    })
  end,
}