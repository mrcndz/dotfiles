-- Set up cmdwin with live update
local main_augroup = vim.api.nvim_create_augroup('CustomCmdwinSetup', { clear = true })

vim.api.nvim_create_autocmd('CmdwinEnter', {
  group = main_augroup,
  callback = function(args)
    -- q to quit cmdwin
    vim.keymap.set('n', 'q', '<C-c><C-c>', { silent = true, buffer = true, nowait = true })
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.signcolumn = 'no'
    vim.opt_local.cursorline = false

    local live_update_augroup = vim.api.nvim_create_augroup('CmdwinLiveUpdate', { clear = true })

    -- Live update highlight search
    vim.api.nvim_create_autocmd('TextChangedI', {
      group = live_update_augroup,
      buffer = args.buf,
      callback = function()
        local line_content = vim.api.nvim_get_current_line()
        local search_pattern = line_content:match 's/([^/]*)/'

        if search_pattern and args.file == ':' then
          vim.fn.setreg('/', search_pattern)
          print(search_pattern)
        end

        if args.file == '/' then
          vim.fn.setreg('/', line_content)
        end
      end,
    })
  end,
})
