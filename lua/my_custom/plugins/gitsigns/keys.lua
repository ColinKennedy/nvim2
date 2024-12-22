return {
    {
        "<leader>gah",
        function()
            local selector = require("my_custom.utilities.selector")

            require("gitsigns").stage_hunk(selector.get_current_mode_visual_lines())
        end,
        desc="[g]it [a]dd [h]unk.",
        mode = {"n", "v"},
    },
    {
        "<leader>gch",
        function()
            local selector = require("my_custom.utilities.selector")

            require("gitsigns").reset_hunk(selector.get_current_mode_visual_lines())
        end,
        desc="[g]it [c]heckout [h]unk.",
        mode = {"n", "v"},
    },
    {
        "<leader>grh",
        function()
            require("gitsigns").undo_stage_hunk()
        end,
        desc="[g]it [r]eset [h]unk.",
        mode = {"n", "v"},
    },
    {
        "<leader>gtd",
        function() require("gitsigns").toggle_deleted() end,
        desc="[g]it [t]oggle [d]elete display.",
        mode = {"o", "x"},
    },
    {
        "ih",
        "<cmd><C-U>Gitsigns select_hunk<CR>",
        desc="Select [i]nside git [h]unk.",
        mode = {"o", "x"},
    },
    {
        "[g",
        function()
            if vim.wo.diff then return "[g" end

            vim.schedule(function() require("gitsigns").prev_hunk() end)

            return "<Ignore>"
        end,
        desc="Go to the previous [g]it hunk in the current file.",
        expr=true,
    },
    {
        "]g",
        function()
            if vim.wo.diff then return "]g" end

            vim.schedule(function() require("gitsigns").next_hunk() end)

            return "<Ignore>"
        end,
        desc="Go to the next [g]it hunk in the current file.",
        expr=true,
    },
}
