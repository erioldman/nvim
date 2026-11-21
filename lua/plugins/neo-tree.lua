return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        lazy = false,
        opts = {},
        init = function()
            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    require("neo-tree.command").execute({ action = "show" })
                end,
            })
        end,
    },
}

