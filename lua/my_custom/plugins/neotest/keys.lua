return {
    {
        "<leader>rtd",
        "<cmd>NeotestRunDirectory<CR>",
        desc = "[r]un [t]est [d]irectory in Neotest.",
    },
    {
        "<leader>rtf",
        "<cmd>NeotestRunFile<CR>",
        desc = "[r]un [t]est [f]ile in Neotest.",
    },
    {
        "<leader>rts",
        "<cmd>NeotestRunSuite<CR>",
        desc = "[r]un [t]est [s]uite (all tests) in Neotest.",
    },
    {
        "<leader>rtc",
        "<cmd>NeotestRunCurrent<CR>",
        function()
            require("neotest").run.run()
        end,
        desc = "[r]un [t]est under [c]ursor in Neotest.",
    },

    {
        "<leader>tno",
        "<cmd>Neotest output<CR>",
        function()
            require("neotest").run.run()
        end,
        desc = "[t]oggle [n]eotest [o]utput floating window.",
    },
    {
        "<leader>tns",
        "<cmd>Neotest summary<CR>",
        function()
            require("neotest").run.run()
        end,
        desc = "[t]oggle [n]eotest [s]ummary floating window.",
    },
}
