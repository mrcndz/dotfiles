local opts = {
  mode = 'n', -- NORMAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

return {
  'folke/which-key.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  event = 'VeryLazy',
  init = function()
    local wk = require('which-key')
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

    -- LSP
    wk.add({
      { '<leader>l', group = 'LSP' },
      { '<leader>lr>', '<cmd>Telescope lsp_references theme=cursor<cr>', desc = 'References', mode = 'n' },
      { '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<CR>', desc = 'Rename Symbol', mode = 'n' },
      { '<leader>ld', '<cmd>lua vim.diagnostic.open_float()<CR>', desc = 'Diagnostics', mode = 'n' },
      { '<leader>lD', '<cmd>Telescope lsp_definitions theme=cursor<cr>', desc = 'Definitions', mode = 'n' },
      { '<leader>ls', '<cmd>Telescope lsp_document_symbols theme=ivy<cr>', desc = 'Document Symbols', mode = 'n' },
      { '<leader>lS', '<cmd>Telescope lsp_workspace_symbols theme=ivy<cr>', desc = 'Workspace Symbols', mode = 'n' },
      { '<leader>li', '<cmd>Telescope lsp_implementations theme=cursor<cr>', desc = 'Implementations', mode = 'n' },
      { '<leader>lI', '<cmd>Telescope lsp_incoming_calls theme=cursor<cr>', desc = 'Incoming calls', mode = 'n' },
      { '<leader>lt', '<cmd>Telescope lsp_type_definitions theme=cursor<cr>', desc = 'Type Definitions', mode = 'n' },
      { '<leader>lO', '<cmd>Telescope lsp_outgoing_calls theme=cursor<cr>', desc = 'Outgoing calls', mode = 'n' },
    })
    -- Telescope
    wk.add({
      { '<leader>f', find_file_and_update_nvim_tree, desc = 'Search Files', mode = 'n' },
      { '<leader>F', '<cmd>Telescope live_grep theme=dropdown<cr>', desc = 'Search Text', mode = 'n' },
      { '<leader>b', '<cmd>Telescope buffers<CR>', desc = 'Buffers', mode = 'n' },
      { '<leader>c', '<cmd>Telescope commands<CR>', desc = 'Commands', mode = 'n' },
      { '<leader>s', '<cmd>Telescope session-lens<CR>', desc = 'Session Lens', mode = 'n' },
      { '<leader>h', '<cmd>Telescope oldfiles theme=dropdown<cr>', desc = 'Search Recents', mode = 'n' },
    })
    -- NvimTree
    wk.add({
      { '<leader>e', '<cmd>NvimTreeFindFileToggle<cr>', desc = 'Toggle Explorer', mode = 'n' },
    })
    -- LazyGit
    wk.add({
      { '<leader>g', group = 'Git' },
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'Lazygit', mode = 'n' },
      { '<leader>gp', '<cmd>LazyGitFilter<cr>', desc = 'Project Commits', mode = 'n' },
      { '<leader>gf', '<cmd>LazyGitFilterCurrentFile<cr>', desc = 'Current File Commits', mode = 'n' },
    })
    -- Terminal
    wk.add({
      { '<leader>t', '<cmd>ToggleTerm direction=horizontal name=terminal<cr>', desc = 'Terminal', mode = 'n' },
    })
  end,
  opts = {
    icons = {
      breadcrumb = '»',
      separator = '➜',
      group = ' ', -- Folder icon
    },
    popup_mappings = {
      scroll_down = '<c-d>', -- binding to scroll down inside the popup
      scroll_up = '<c-u>', -- binding to scroll up inside the popup
    },
    window = {
      border = 'rounded',
      position = 'bottom',
      margin = { 1, 0, 1, 0 },
      padding = { 2, 2, 2, 2 },
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 },
      width = { min = 20, max = 50 },
      spacing = 3,
      align = 'left',
    },
    ignore_missing = true,
    hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' },
    show_help = true,
    triggers = 'auto',
    triggers_nowait = {
      '`',
      "'",
      'g`',
      "g'",
      '"',
      '<c-r>',
      '<leader>',
    },
    triggers_blacklist = {
      i = { 'j', 'k' },
      v = { 'j', 'k' },
    },
  },
}
