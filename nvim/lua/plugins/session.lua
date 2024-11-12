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
      require('auto-session').setup {
        auto_create = function()
          local cwd = vim.loop.cwd()
          local is_git_repo = vim.fn.system 'git rev-parse --is-inside-work-tree' == 'true\n'
          local is_top_level = vim.fn.system 'git rev-parse --show-toplevel' == cwd .. '\n'

          return (is_git_repo and is_top_level)
        end,
        auto_save_enabled = true,
        bypass_save_filetypes = {
          'alpha',
        },
        auto_restore_enabled = true,
        log_level = 'error',
        post_restore_cmd = {
          'DisableHLChunk',
          'DisableHLIdent',
          'DisableHLLineNum',
          'EnableHLChunk',
          'EnableHLIdent',
          'EnableHLLineNum',
          function()
            local filepath = vim.fn.expand '%'

            if not vim.fn.filereadable(filepath) then
              vim.cmd 'Alpha'
            end

            local git_root = vim.fn.system 'git rev-parse --show-toplevel'
            if git_root ~= '' or git_root:match '^fatal:' then
              vim.api.nvim_cmd({ cmd = 'cd', args = { git_root } }, {})
            end
          end,
        },
        auto_session_suppress_dirs = {
          '~/',
          '~/.temp/',
          '~/temp',
          '~/Downloads',
        },
      }
    end,
  },
}
