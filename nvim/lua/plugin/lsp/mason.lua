local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

mason_lspconfig.setup({
    ensure_installed = {
        "bashls",
        "marksman",
        "lua_ls",
        "cmake",
        "dockerls",
        "cssls",
        "dockerls",
        "ltex",
        "html",
        "jsonls",
        "pyright",
        "rust_analyzer",
        "tsserver",
        "vimls",
        "sqlls",
        "yamlls",
    },
    automatic_install = true,
})
