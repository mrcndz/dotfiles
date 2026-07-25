return {
  {
    'rmagatti/auto-session',
    lazy = false,
    dependencies = {},
    init = function()
      -- no 'localoptions': it pins plugin window state into sessions
      vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'
    end,
    config = function()
      local tree_session = require 'tree-session' -- defined in plugins/nvim-tree.lua

      local function git_root()
        local root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
        if vim.v.shell_error ~= 0 then return nil end
        return root
      end

      -- cd to git root early so auto-session keys sessions by repo root
      local root = git_root()
      if root then vim.cmd.cd(root) end

      require('auto-session').setup {
        auto_create = function()
          return git_root() ~= nil
        end,
        auto_save = true,
        auto_restore = true,
        -- off: it would prune tree-session's placeholder window
        close_unsupported_windows = false,
        pre_save_cmds = { tree_session.stash_if_open },
        save_extra_cmds = { tree_session.extra_cmd },
        post_save_cmds = { tree_session.after_save },
        bypass_save_filetypes = {
          'alpha',
          'NvimTree',
        },
        log_level = 'error',
        post_restore_cmds = {},
        suppressed_dirs = {
          '~/.temp/',
          '~/temp',
          '~/Downloads',
        },
      }
    end,
  },
}
