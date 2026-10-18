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
        pre_save_cmds = {},
        save_extra_cmds = {},
        post_save_cmds = {},
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

      -- auto-session skips restore when started with a file or headless (herdr-nvim sidebar):
      -- restore the repo session anyway, then show the file on top
      local function restore_keeping_file()
        local file = vim.api.nvim_buf_get_name(0)
        require('auto-session').restore_session(nil, { show_message = false })
        if file ~= '' then vim.cmd.edit(vim.fn.fnameescape(file)) end
      end

      if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 0 then
        local file = vim.fn.fnamemodify(vim.fn.argv(0), ':p')
        -- repo files only: skips commit messages and temp files ($EDITOR prompts)
        if root and vim.startswith(file, root .. '/') and not file:find('/.git/', 1, true) then
          vim.api.nvim_create_autocmd('VimEnter', { once = true, nested = true, callback = restore_keeping_file })
        end
      elseif vim.tbl_contains(vim.v.argv, '--headless') then
        vim.api.nvim_create_autocmd('UIEnter', { once = true, nested = true, callback = restore_keeping_file })
      end
    end,
  },
}
