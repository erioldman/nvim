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
        opts = {
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_hidden = false,
                },
            },
            window = {
                mappings = {
                    ["<space>"] = { function(state)
                        local node = state.tree:get_node()
                        if node and node.type == "directory" then
                            require("neo-tree.sources.filesystem.commands").toggle_node(state)
                        else
                            require("neo-tree.sources.filesystem.commands").open(state)
                        end
                    end, nowait = true },
                },
            },
        },
        init = function()
            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function(args)
                    local has_file = args.file ~= ""
                    local dir = has_file and vim.fn.fnamemodify(args.file, ":p:h") or vim.uv.cwd()
                    require("neo-tree.command").execute({ action = "show", dir = dir, reveal = has_file })
                end,
            })
        end,
    },
}

