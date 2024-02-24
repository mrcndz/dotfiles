vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
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
end

require("nvim-tree").setup {
    on_attach = my_on_attach,
    sort = {
      sorter = "case_sensitive",
     },
     view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
}
