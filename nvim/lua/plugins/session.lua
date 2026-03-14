return {
  {
    'rmagatti/auto-session',
    lazy = false,
    dependencies = {},
    init = function()
      vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
    end,
    config = function()
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
        close_unsupported_windows = true,
        pre_save_cmds = { 'NvimTreeClose' },
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
