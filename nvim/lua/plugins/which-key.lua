local opts = {
  mode = 'n',     -- NORMAL mode
  prefix = '<leader>',
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}

local mappings = {
  ['e'] = { '<cmd>NvimTreeFindFileToggle<cr>', 'Toggle Explorer' },
  ['h'] = { '<cmd>Telescope oldfiles theme=dropdown<cr>', 'Search Recents' },
  -- ['f'] = { '<cmd>Telescope find_files theme=dropdown<cr>', 'Search Files' },
  ['f'] = { function()
    local builtin = require('telescope.builtin')
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')
    local themes = require('telescope.themes')
    local api = require('nvim-tree.api')

    local function update_nvim_tree(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local filepath = selection.cwd .. '/' .. selection.value
        api.tree.find_file(filepath)
        -- Continue editing...
        vim.cmd('edit ' .. filepath)
      end)
      return true
    end

    if api.tree.is_visible() then
      builtin.find_files(themes.get_dropdown({ attach_mappings = update_nvim_tree }))
    else
      builtin.find_files(themes.get_dropdown({}))
    end
  end, 'Search Files test' },
  ['F'] = { '<cmd>Telescope live_grep theme=dropdown<cr>', 'Search Text' },
  ['x'] = { '<cmd>BufferClose<cr>', 'Tab close' },
  ['t'] = { '<cmd>Telescope treesitter<cr>', 'Treesitter' },
  ['d'] = { '<cmd>TroubleToggle<CR>', 'Diagnostics' },
  ['b'] = { '<cmd>Telescope buffers<CR>', 'Buffers' },
  ['c'] = { '<cmd>Telescope commands<CR>', 'Commands' },
  ['s'] = { '<cmd>Telescope session-lens' },
  l = {
    name = 'LSP',
    r = { '<cmd>Telescope lsp_references theme=cursor<cr>', 'References' },
    R = { '<cmd>lua vim.lsp.buf.rename()<CR>', 'Rename Symbol' },
    d = { '<cmd>lua vim.diagnostic.open_float()<CR>', 'Diagnostics' },
    D = { '<cmd>Telescope lsp_definitions theme=cursor<cr>', 'Definitions' },
    s = { '<cmd>Telescope lsp_document_symbols theme=ivy<cr>', 'Document Symbols' },
    S = { '<cmd>Telescope lsp_workspace_symbols theme=ivy<cr>', 'Workspace Symbols' },
    i = { '<cmd>Telescope lsp_implementations theme=cursor<cr>', 'Implementations' },
    I = { '<cmd>Telescope lsp_incoming_calls theme=cursor<cr>', 'Incoming calls' },
    t = { '<cmd>Telescope lsp_type_definitions theme=cursor<cr>', 'Type Definitions' },
    O = { '<cmd>Telescope lsp_outgoing_calls theme=cursor<cr>', 'Outgoing calls' },
  },
  g = {
    name = 'Git',
    b = { '<cmd>Telescope git_branches theme=ivy<cr>', 'Checkout branch' },
    c = { '<cmd>Telescope git_commits theme=ivy<cr>', 'Commits' },
    s = { '<cmd>Telescope git_status theme=ivy<cr>', 'Status' },
  },
}

return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    require('which-key').register(mappings, opts)
  end,
  opts = {
    icons = {
      breadcrumb = '»',
      separator = '➜',
      group = ' ', -- Folder icon
    },
    popup_mappings = {
      scroll_down = '<c-d>', -- binding to scroll down inside the popup
      scroll_up = '<c-u>',   -- binding to scroll up inside the popup
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
