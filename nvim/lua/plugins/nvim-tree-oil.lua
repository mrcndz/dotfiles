return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
      -- Gitsigns
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

      -- Autocmds
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

      -- Find directory using telescope
      local function find_directory_and_focus()
        local actions = require('telescope.actions')
        local action_state = require('telescope.actions.state')
        local themes = require('telescope.themes')

        local function open_nvim_tree(prompt_bufnr, _)
          actions.select_default:replace(function()
            local api = require('nvim-tree.api')

            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            local filepath = selection.cwd .. '/' .. selection.value
            api.tree.open()
            api.tree.find_file(filepath)
            vim.cmd('edit ' .. filepath)
          end)

          return true
        end

        require('telescope.builtin').find_files(themes.get_dropdown({ attach_mappings = open_nvim_tree }))
      end

      local function my_on_attach(bufnr)
        local api = require('nvim-tree.api')
        local oil = require('oil')

        local function get_node_dirname()
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
        vim.keymap.set('n', 'y', api.fs.copy.node, opts('Copy'))
        vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
        vim.keymap.set('n', 'V', api.fs.copy.filename, opts('Copy filename'))
        vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
        vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
        vim.keymap.set('n', '|', api.node.open.vertical, opts('Open: Vertical Split'))
        vim.keymap.set('n', '-', api.node.open.horizontal, opts('Open: Horizontal Split'))
        vim.keymap.set('n', '>', api.tree.change_root_to_node, opts('CD'))
        vim.keymap.set('n', '<', api.tree.change_root_to_parent, opts('CD'))
        vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', 'h', api.tree.toggle_hidden_filter, opts('Toggle hidden'))
        vim.keymap.set('n', 'i', get_node_dirname, opts('Edit'))
        vim.keymap.set('n', 'f', find_directory_and_focus, opts('Find directory'))
        vim.keymap.set('n', '/', find_directory_and_focus, opts('Find directory'))
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
          enable = true,
          show_on_dirs = false,
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
          ['<CR>'] = 'actions.select',
          ['?'] = 'actions.show_help',
          ['q'] = quit_and_save,
          ['<'] = 'actions.parent',
          ['gs'] = 'actions.change_sort',
          ['gx'] = 'actions.open_external',
          ['h'] = 'actions.toggle_hidden',
          ['H'] = 'actions.toggle_trash',
          ['<C-p>'] = 'actions.preview',
        },
        use_default_keymaps = false,
      })
    end,
  },
}
