local function name_matches(node, pattern)
    local name = node.name
    if not name or node:get_parent_id() == nil then
        return false
    end
    return name:lower():find(pattern:lower(), 1, true) ~= nil
end

local function focus_match(state, direction, scroll_padding)
    if not state.tree or not state.search_pattern then
        return
    end
    local renderer = require("neo-tree.ui.renderer")
    local matches = renderer.select_nodes(state.tree, function(node)
        return name_matches(node, state.search_pattern)
    end)
    if #matches == 0 then
        return
    end
    local current = state.tree:get_node()
    local current_id = current and current:get_id()
    local target = nil
    if current_id then
        for i, node in ipairs(matches) do
            if node:get_id() == current_id then
                if direction > 0 then
                    target = matches[i % #matches + 1]
                else
                    target = matches[(i - 2) % #matches + 1]
                end
                break
            end
        end
    end
    target = target or (direction > 0 and matches[1] or matches[#matches])
    local half = math.floor(vim.api.nvim_win_get_height(state.winid) / 2)
    renderer.focus_node(state, target:get_id(), true, 0, math.max(scroll_padding or 0, half))
end

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
        config = function(_, opts)
            require("neo-tree").setup(opts)
            local fs = require("neo-tree.sources.filesystem")
            local utils = require("neo-tree.utils")
            local renderer = require("neo-tree.ui.renderer")
            local original_reset_search = fs.reset_search
            fs.reset_search = function(state, refresh, open_current_node)
                if not open_current_node then
                    return original_reset_search(state, refresh, open_current_node)
                end
                -- a pending debounced filter navigate would re-render after the
                -- reset and steal the tree cursor; replace it with a no-op
                utils.debounce("filesystem_filter", function() end, 1, utils.debounce_strategy.CALL_LAST_ONLY)
                local node = state.tree and state.tree:get_node()
                local path = node and node:get_id()
                original_reset_search(state, false, false)
                if not node or not path then
                    return
                end
                if node.type == "directory" then
                    fs.navigate(state, nil, path, function()
                        local half = math.floor(vim.api.nvim_win_get_height(state.winid) / 2)
                        pcall(renderer.focus_node, state, path, false, 0, half)
                        local folder = state.tree:get_node(path)
                        if folder and not folder:is_expanded() then
                            require("neo-tree.sources.filesystem.commands").toggle_node(state)
                        end
                    end)
                else
                    utils.open_file(state, path)
                    fs.navigate(state, nil, path, function()
                        local half = math.floor(vim.api.nvim_win_get_height(state.winid) / 2)
                        pcall(renderer.focus_node, state, path, true, 0, half)
                    end)
                end
            end
        end,
        opts = {
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_hidden = false,
                    hide_gitignored = false,
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
                fuzzy_finder_mappings = {
                    ["<c-n>"] = function(state, scroll_padding)
                        focus_match(state, 1, scroll_padding)
                        vim.cmd("redraw!")
                    end,
                    ["<c-p>"] = function(state, scroll_padding)
                        focus_match(state, -1, scroll_padding)
                        vim.cmd("redraw!")
                    end,
                },
            },
            event_handlers = {
                {
                    event = "after_render",
                    handler = function(state)
                        if state.fuzzy_finder_mode == "directory" then
                            return
                        end
                        local pattern = state.search_pattern
                        if not pattern or pattern == "" then
                            state.last_search_pattern = nil
                            return
                        end
                        if state.last_search_pattern == pattern then
                            return
                        end
                        state.last_search_pattern = pattern
                        vim.schedule(function()
                            if state.search_pattern == pattern then
                                focus_match(state, 1)
                            end
                        end)
                    end,
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
