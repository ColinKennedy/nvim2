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
        function() require("grapple").popup_tags("git") end,
        desc = "Show all saved project paths.",
    },
    {
        "<M-S-h>",
        function() require("grapple").toggle({ scope="git" }) end,
        desc = "Add / Remove the current file as a project path.",
    },
}
