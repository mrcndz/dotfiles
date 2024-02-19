local wk = require("which-key")

wk.register({
  ["<space>"] = {
    name = "+file",
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    n = { "<cmd>enew<cr>", "New File" },
  },
})
