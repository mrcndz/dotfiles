return {
  {
    'rmagatti/auto-session',
    dependencies = {},
    init = function()
      vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
    end,
    config = function()
      local utils = require 'utils'

      require('auto-session').setup {
        auto_create = function()
          return (utils.is_git_top_level() and utils.is_git_repo())
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
            local utils = require 'utils'

            if utils.is_git_repo() then
              vim.api.nvim_cmd({ cmd = 'cd', args = { utils.git_top_level() } }, {})
            end
          end,
        },
        auto_session_suppress_dirs = {
          '~/.temp/',
          '~/temp',
          '~/Downloads',
        },
      }
    end,
  },
}
