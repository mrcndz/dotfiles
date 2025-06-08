return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    {
      '<leader>c',
      function() end,
      desc = 'Commands',
    },
    {
      'gj',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Buffer Lines',
    },
    -- Git
    {
      '<leader>go',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Open Git in Browser',
    },
    {
      '<leader>gl',
      function()
        Snacks.lazygit.open()
      end,
      desc = 'Lazygit',
    },
    -- LSP
    {
      '<leader>ls',
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = 'LSP Symbols',
    },
    {
      '<leader>lS',
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = 'LSP Workspace Symbols',
    },
    {
      '<leader>lf',
      function()
        Snacks.picker.diagnostics_buffer()
        feed_esc()
      end,
      desc = 'Buffer Diagnostics',
    },
    {
      '<leader>lF',
      function()
        Snacks.picker.diagnostics()
        feed_esc()
      end,
      desc = 'Diagnostics',
    },
    {
      '<leader>lD',
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = 'Goto Definition',
    },
    {
      '<leader>le',
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = 'Goto Declaration',
    },
    {
      '<leader>lr',
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = 'References',
    },
    {
      '<leader>li',
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = 'Goto Implementation',
    },
    {
      '<leader>u',
      function()
        Snacks.picker.undo()
        feed_esc()
      end,
      desc = 'Undo History',
    },
    {
      '<leader>F',
      function()
        -- If we're in a grep, resume it
        -- Otherwise, start a new one
        local last = require('snacks.picker.core.picker').last

        if last == nil or next(last) == nil then
          Snacks.picker.grep()
          return
        end

        if last.opts.source == 'grep' then
          Snacks.picker.resume()
          feed_esc()
        else
          Snacks.picker.grep()
        end
      end,
      desc = 'Grep',
    },
    {
      '<leader>e',
      function()
        Snacks.explorer {
          win = {
            list = {
              keys = {
                ['i'] = '',
                ['<c-c>'] = '',
                ['<c-t>'] = 'terminal',
              },
            },
          },
        }
      end,
      desc = 'File Explorer',
    },
    {
      '<leader><leader>',
      function()
        Snacks.picker.buffers()
        feed_esc()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>f',
      function()
        Snacks.picker.files()
        feed_esc()
      end,
      desc = 'Buffers',
    },
  },
  opts = {
    bigfile = { enabled = true },
    picker = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = false },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  config = function()
    Snacks.indent.enable()
    Snacks.scroll.enable()
  end,
}
