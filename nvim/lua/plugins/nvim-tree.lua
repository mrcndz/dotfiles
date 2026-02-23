return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    {
      '<leader>e',
      '<cmd>NvimTreeToggle<cr>',
      desc = 'Toggle file explorer',
    },
  },
  config = function()
    local function my_on_attach(bufnr)
      local api = require('nvim-tree.api')

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- Usar keymaps padrão primeiro
      api.config.mappings.default_on_attach(bufnr)

      -- Keymaps customizados
      vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
      vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
      vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
      vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: Horizontal Split'))
      vim.keymap.set('n', 't', api.node.open.tab, opts('Open: New Tab'))
      vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
      vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
      vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
      vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
      vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
      vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
      vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
      vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
      vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
      vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
      vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
      vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
      vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
      vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
      vim.keymap.set('n', '<leader>g', function()
        api.tree.collapse_all()
        api.tree.toggle_git_clean_filter()
        api.tree.expand_all()
      end, opts('Toggle git changes view'))
    end

    local function open_nvim_tree(data)
      local directory = vim.fn.isdirectory(data.file) == 1
      local no_name = data.file == '' and vim.bo[data.buf].buftype == ''
      if not directory and not no_name then return end
      if directory then vim.cmd.cd(data.file) end
      require('nvim-tree.api').tree.open()
    end
    vim.api.nvim_create_autocmd('VimEnter', { callback = open_nvim_tree })

    require('nvim-tree').setup {
      on_attach = my_on_attach,
      disable_netrw = true,
      hijack_netrw = true,
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      view = {
        width = 30,
        side = 'left',
      },
      filters = {
        dotfiles = false,
        custom = { '.git', 'node_modules', '.cache' },
      },
      git = {
        enable = true,
        ignore = false,
      },
      actions = {
        open_file = {
          quit_on_open = false,
          resize_window = true,
        },
      },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
    }
  end,
}

