return {
  'folke/which-key.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  event = 'VeryLazy',
  init = function()
    local wk = require('which-key')
    local wkicon = require('which-key.icons')
    local find_file_and_update_nvim_tree = function()
      local builtin = require('telescope.builtin')
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')
      local themes = require('telescope.themes')
      local nvimtree_api = require('nvim-tree.api')

      local function update_nvim_tree(prompt_bufnr, _)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          local filepath = selection.cwd .. '/' .. selection.value
          nvimtree_api.tree.find_file(filepath)
          -- Continue editing...
          vim.cmd('edit ' .. filepath)
        end)
        return true
      end

      if nvimtree_api.tree.is_visible() then
        builtin.find_files(themes.get_dropdown({ attach_mappings = update_nvim_tree }))
      else
        builtin.find_files(themes.get_dropdown({}))
      end
    end

    -- Telescope
    wk.add({
      icon = wkicon.get({ pattern = 'search', icon = ' ', color = 'green' }),
      { '<leader>f', find_file_and_update_nvim_tree, desc = 'Files', mode = 'n', icon = '' },
      { '<leader>F', '<cmd>Telescope live_grep theme=dropdown<cr>', desc = 'Grep', mode = 'n', icon = '' },
      { '<leader><leader>', '<cmd>Telescope buffers<CR>', desc = 'Buffers', mode = 'n', icon = '' },
      { '<leader>c', '<cmd>Telescope commands<CR>', desc = 'Commands', mode = 'n', icon = '' },
      { '<leader>s', '<cmd>Telescope session-lens<CR>', desc = 'Session Lens', mode = 'n', icon = '' },
      { '<leader>h', '<cmd>Telescope oldfiles theme=dropdown<cr>', desc = 'Recents', mode = 'n', icon = '' },
    })

    -- Terminal
    wk.add({ { '<leader>t', '<cmd>ToggleTerm direction=horizontal name=terminal<cr>', desc = 'Terminal', mode = 'n' } })
    -- NvimTree
    wk.add({ icon = wkicon.get({ pattern = 'toggle', icon = ' ', color = 'yellow' }), { '<leader>e', '<cmd>NvimTreeFindFileToggle<cr>', desc = 'Explorer', mode = 'n' } })

    -- LSP
    wk.add({
      { '<leader>l', group = 'LSP', icon = '󰀏 ' },
      { '<leader>lr', '<cmd>Telescope lsp_references theme=cursor<cr>', desc = 'References', mode = 'n', icon = '󰁨 ' },
      { '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<CR>', desc = 'Rename Symbol', mode = 'n', icon = '󰀘 ' },
      { '<leader>ld', '<cmd>lua vim.diagnostic.open_float()<CR>', desc = 'Diagnostics', mode = 'n', icon = '󰒭 ' },
      { '<leader>lD', '<cmd>Telescope lsp_definitions theme=cursor<cr>', desc = 'Definitions', mode = 'n', icon = '󰋗 ' },
      { '<leader>ls', '<cmd>Telescope lsp_document_symbols theme=ivy<cr>', desc = 'Document Symbols', mode = 'n', icon = '󰮗 ' },
      { '<leader>lS', '<cmd>Telescope lsp_workspace_symbols theme=ivy<cr>', desc = 'Workspace Symbols', mode = 'n', icon = '󰙅 ' },
      { '<leader>li', '<cmd>Telescope lsp_implementations theme=cursor<cr>', desc = 'Implementations', mode = 'n', icon = '󰏫 ' },
      { '<leader>lI', '<cmd>Telescope lsp_incoming_calls theme=cursor<cr>', desc = 'Incoming calls', mode = 'n', icon = '󰛿 ' },
      { '<leader>lt', '<cmd>Telescope lsp_type_definitions theme=cursor<cr>', desc = 'Type Definitions', mode = 'n', icon = '󰋫 ' },
      { '<leader>lO', '<cmd>Telescope lsp_outgoing_calls theme=cursor<cr>', desc = 'Outgoing calls', mode = 'n', icon = '󰚉 ' },
    })
    -- LazyGit
    wk.add({
      { '<leader>g', group = 'Git' },
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'Lazygit', mode = 'n', icon = ' ' },
      { '<leader>gp', '<cmd>LazyGitFilter<cr>', desc = 'Project Commits', mode = 'n', icon = ' ' },
      { '<leader>gf', '<cmd>LazyGitFilterCurrentFile<cr>', desc = 'Current File Commits', mode = 'n', icon = ' ' },
    })
  end,
  opts = {
    preset = 'helix',
    sort = { 'group', 'manual', 'order', 'alphanum', 'mod', 'lower', 'icase' },
  },
}
