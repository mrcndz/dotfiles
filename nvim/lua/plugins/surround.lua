return {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
             keymaps = {
                -- insert = "",
                -- insert_line = "",
                normal = "sa",
                normal_cur = "saa",
                normal_line = "Sa",
                normal_cur_line = "Saa",
                visual = "sa",
                visual_line = "Sa",
                delete = "sd",
                change = "sr",
                change_line = "Sr",
            },
        })
    end
}
