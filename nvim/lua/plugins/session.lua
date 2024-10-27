return {
  {
    'rmagatti/auto-session',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    init = function()
      vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
    end,
    config = function()
      require('auto-session').setup({
        auto_create = function()
          local is_git_repo = vim.fn.system('git rev-parse --is-inside-work-tree') == 'true\n'
          local cwd = vim.loop.cwd()
          local is_top_level = vim.fn.system('git rev-parse --show-toplevel') == cwd .. '\n'

          return (is_git_repo and is_top_level)
        end,
        auto_save_enabled = true,
        auto_restore_enabled = true,
        log_level = 'error',
        auto_session_suppress_dirs = {
          '~/',
          '~/.temp/',
          '~/temp',
          '~/Downloads',
        },
      })
    end,
  },
}
