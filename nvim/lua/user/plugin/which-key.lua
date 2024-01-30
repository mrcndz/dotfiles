local wk = require("which-key")

wk.register({
    f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
    t = { "<cmd>Telescope treesitter<cr>", "Treesitter" },
    ["1"] = "which_key_ignore",  -- special label to hide it in the popup
}, { prefix = "<space>" })
