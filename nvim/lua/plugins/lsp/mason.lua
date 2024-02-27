return {
    "williamboman/mason.nvim",

    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },

    config = function()
        require("mason").setup()

        require("mason-lspconfig").setup({
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
            }
        })
    end
}
