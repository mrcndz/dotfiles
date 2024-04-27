return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
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
    function find_directory_and_focus()
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')

      local function open_nvim_tree(prompt_bufnr, _)
        actions.select_default:replace(function()
          local api = require('nvim-tree.api')

          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          api.tree.open()
          api.tree.find_file(selection.cwd .. '/' .. selection.value)
        end)
        return true
      end

      require('telescope.builtin').find_files({
        find_command = { 'fd', '--type', 'directory', '--hidden', '--exclude', '.git/*' },
        attach_mappings = open_nvim_tree,
      })
    end

    local function my_on_attach(bufnr)
      local api = require('nvim-tree.api')

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      api.config.mappings.default_on_attach(bufnr)
      vim.keymap.set('n', 'i', api.fs.create, opts('Create'))
      vim.keymap.set('n', 'y', api.fs.copy.node, opts('Copy'))
      vim.keymap.set('n', 'V', api.fs.copy.filename, opts('Copy filename'))
      vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
      vim.keymap.set('n', '|', api.node.open.vertical, opts('Open: Vertical Split'))
      vim.keymap.set('n', '-', api.node.open.horizontal, opts('Open: Horizontal Split'))
      vim.keymap.set('n', '>', api.tree.change_root_to_node, opts('CD'))
      vim.keymap.set('n', '<', api.tree.change_root_to_parent, opts('CD'))
      vim.keymap.set('n', 't', api.node.open.tab, opts('Open: Tab'))
      vim.keymap.set('n', '/', find_directory_and_focus)
    end

    ntree.setup({
      on_attach = my_on_attach,
      sort = {
        sorter = 'case_sensitive',
      },

      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
        indent_markers = {
          enable = true,
        },
      },
      filters = {
        dotfiles = true,
      },
      diagnostics = {
        enable = true,
      },
    })
  end,
}
