return {
    {
        "<M-S-j>",
        function() require("grapple").cycle_forward() end,
        desc = "Move to the next saved project path.",
    },
    {
        "<M-S-k>",
        function() require("grapple").cycle_backward() end,
        desc = "Move to the previous saved project path.",
    },
    {
        "<M-S-l>",
        function() require("grapple").open_tags() end,
        desc = "Show all saved project paths.",
    },
    {
        "<M-S-h>",
        function() require("grapple").toggle() end,
        desc = "Add / Remove the current file as a project path.",
    },
    {
        "<leader>1",
        "<CMD>Grapple select index=1<CR>",
        desc = "Switch to grapple [1] position.",
    },
    {
        "<leader>2",
        "<CMD>Grapple select index=2<CR>",
        desc = "Switch to grapple [2] position.",
    },
    {
        "<leader>3",
        "<CMD>Grapple select index=3<CR>",
        desc = "Switch to grapple [3] position.",
    },
    {
        "<leader>4",
        "<CMD>Grapple select index=4<CR>",
        desc = "Switch to grapple [4] position.",
    },
}
