local last_picker = {}

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    {
      '<leader>c',
      function()
        Snacks.picker.commands {
          layout = 'vscode',
          on_show = feed_esc,
        }
      end,
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
        Snacks.picker.lsp_symbols {
          layout = 'right',
          jump = {
            close = false,
          },
          on_show = feed_esc,
        }
      end,
      desc = 'Symbols',
    },
    {
      '<leader>lS',
      function()
        Snacks.picker.lsp_workspace_symbols {
          on_show = feed_esc,
        }
      end,
      desc = 'Workspace Symbols',
    },
    {
      '<leader>d',
      function()
        Snacks.picker.diagnostics_buffer {
          layout = 'ivy_split',
          on_show = feed_esc,
        }
      end,
      desc = 'Buffer Diagnostics',
    },
    {
      '<leader>D',
      function()
        Snacks.picker.diagnostics {
          layout = 'ivy_split',
          on_show = feed_esc,
        }
      end,
      desc = 'Workspace Diagnostics',
    },
    {
      '<leader>lD',
      function()
        Snacks.picker.lsp_definitions {
          on_show = feed_esc,
        }
      end,
      desc = 'Definitions',
    },
    {
      '<leader>le',
      function()
        Snacks.picker.lsp_declarations {
          on_show = feed_esc,
        }
      end,
      desc = 'Declarations',
    },
    {
      '<leader>lr',
      function()
        Snacks.picker.lsp_references {
          on_show = feed_esc,
        }
      end,
      nowait = true,
      desc = 'References',
    },
    {
      '<leader>li',
      function()
        Snacks.picker.lsp_implementations {
          on_show = feed_esc,
        }
      end,
      desc = 'Implementations',
    },
    {
      '<leader>u',
      function()
        Snacks.picker.undo {
          on_show = feed_esc,
        }
      end,
      desc = 'Undo History',
    },
    {
      '<leader>F',
      function()
        Snacks.picker.grep {}
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
              },
            },
          },
        }
      end,
      desc = 'Explorer',
    },
    {
      '<leader><leader>',
      function()
        Snacks.picker.buffers {
          layout = 'select',
          on_show = feed_esc,
          win = {
            input = {
              keys = {
                ['dd'] = { 'bufdelete', mode = { 'n' }, nowait = true, noremap = true },
              },
            },
          },
        }
      end,
      desc = 'Buffers',
    },
    {
      '<leader>f',
      function()
        Snacks.picker.files {}
      end,
      desc = 'Files',
    },
  },
  config = function()
    Snacks.setup {
      picker = {
        layouts = vim.tbl_deep_extend('force', require 'snacks.picker.config.layouts', {
          ['bottom_no_preview'] = {
            layout = 'bottom',
          },
        }),

        win = {
          input = {
            keys = {
              ['qqq'] = { { 'cancel', 'cancel' }, mode = 'i', noremap = true, nowait = true },
              ['['] = { 'history_back', mode = { 'n' }, nowait = true },
              [']'] = { 'history_forward', mode = { 'n' }, nowait = true },
              ['[['] = { 'history_back', mode = { 'i' }, nowait = true, noremap = true },
              [']]'] = { 'history_forward', mode = { 'i' }, nowait = true, noremap = true },
            },
          },
        },
      },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = false },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    }
  end,
}
