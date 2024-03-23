return {
    {
        "<leader>rtd",
        ":NeotestRunDirectory<CR>",
        desc = "[r]un [t]est [d]irectory in Neotest.",
    },
    {
        "<leader>rtf",
        ":NeotestRunFile<CR>",
        desc = "[r]un [t]est [f]ile in Neotest.",
    },
    {
        "<leader>rts",
        ":NeotestRunSuite<CR>",
        desc = "[r]un [t]est [s]uite (all tests) in Neotest.",
    },
    {
        "<leader>rtc",
        ":NeotestRunCurrent<CR>",
        function() require("neotest").run.run() end,
        desc = "[r]un [t]est under [c]ursor in Neotest.",
    },

    {
        "<leader>tno",
        ":Neotest output<CR>",
        function() require("neotest").run.run() end,
        desc = "[t]oggle [n]eotest [o]utput floating window.",
    },
    {
        "<leader>tns",
        ":Neotest summary<CR>",
        function() require("neotest").run.run() end,
        desc = "[t]oggle [n]eotest [s]ummary floating window.",
    },
}
