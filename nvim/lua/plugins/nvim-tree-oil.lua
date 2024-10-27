return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,

    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
      'lewis6991/gitsigns.nvim',
      'nvim-telescope/telescope.nvim',
    },
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true
    end,

    config = function()
      local ntree = require('nvim-tree')
      local api = require('nvim-tree.api')

      -- Autocmds
      -- Auto focus file in nvim tree when buffer entered
      vim.api.nvim_create_autocmd({ 'BufEnter' }, {
        callback = function()
          local filepath = vim.fn.expand('%:p')
          api.tree.find_file(filepath)
        end,
      })

      -- Autoclose
      vim.api.nvim_create_autocmd('QuitPre', {
        callback = function()
          local tree_wins = {}
          local floating_wins = {}
          local wins = vim.api.nvim_list_wins()
          for _, w in ipairs(wins) do
            local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
            if bufname:match('NvimTree_') ~= nil then
              table.insert(tree_wins, w)
            end
            if vim.api.nvim_win_get_config(w).relative ~= '' then
              table.insert(floating_wins, w)
            end
          end
          if 1 == #wins - #floating_wins - #tree_wins then
            -- Should quit, so we close all invalid windows.
            for _, w in ipairs(tree_wins) do
              vim.api.nvim_win_close(w, true)
            end
          end
        end,
      })

      local function my_on_attach(bufnr)
        local oil = require('oil')

        local function edit_with_oil()
          local node = api.tree.get_node_under_cursor()
          local dirname = ''

          if node then
            dirname = vim.fs.dirname(node.absolute_path)
          end

          oil.open_float(dirname)
        end

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy filename'))
        vim.keymap.set('n', 'Y', api.fs.copy.node, opts('Copy'))
        vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
        vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
        vim.keymap.set('n', '>', api.tree.change_root_to_node, opts('CD'))
        vim.keymap.set('n', '<', api.tree.change_root_to_parent, opts('CD'))
        vim.keymap.set('n', '|', api.node.open.vertical, opts('Open: Vertical Split'))
        vim.keymap.set('n', '-', api.node.open.horizontal, opts('Open: Horizontal Split'))
        vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', '<C-p>', api.node.open.preview, opts('Preview'))
        vim.keymap.set('n', 'i', edit_with_oil, opts('Edit'))
        vim.keymap.set('n', 'f', require('telescope.builtin').find_files, opts('Find directory'))
      end

      ntree.setup({
        on_attach = my_on_attach,
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
        sort = {
          sorter = 'case_sensitive',
        },
        view = {
          width = 30,
        },
        renderer = {
          highlight_git = true,
          group_empty = true,
          indent_markers = {
            enable = true,
          },
        },
        filters = {
          enable = false,
        },
        diagnostics = {
          enable = false,
          show_on_dirs = false,
        },
        git = {
          enable = true,
        },
      })
    end,
  },
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local oil = require('oil')

      local quit_and_save = function()
        oil.save({
          confirm = true,
        })

        oil.close()
      end

      require('oil').setup({
        default_file_explorer = false,
        columns = {
          'icon',
        },
        keymaps = {
          ['?'] = 'actions.show_help',
          ['q'] = quit_and_save,
          ['<CR>'] = quit_and_save,
          ['<'] = 'actions.parent',
          ['gs'] = 'actions.change_sort',
          ['gx'] = 'actions.open_external',
          ['t'] = 'actions.toggle_hidden',
          ['T'] = 'actions.toggle_trash',
          ['<C-p>'] = 'actions.preview',
        },
        use_default_keymaps = false,
      })
    end,
  },
}
