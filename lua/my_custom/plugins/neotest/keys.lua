return {
    {
        "<leader>rtd",
        "NeotestRunDirectory",
        desc = "[r]un [t]est [d]irectory in Neotest.",
    },
    {
        "<leader>rtf",
        "NeotestRunFile",
        desc = "[r]un [t]est [f]ile in Neotest.",
    },
    {
        "<leader>rts",
        "NeotestRunSuite",
        desc = "[r]un [t]est [s]uite (all tests) in Neotest.",
    },
    {
        "<leader>rtc",
        "NeotestRunCurrent",
        function() require("neotest").run.run() end,
        desc = "[r]un [t]est under [c]ursor in Neotest.",
    },

    {
        "<leader>tno",
        "Neotest output",
        function() require("neotest").run.run() end,
        desc = "[t]oggle [n]eotest [o]utput floating window.",
    },
    {
        "<leader>tns",
        "Neotest summary",
        function() require("neotest").run.run() end,
        desc = "[t]oggle [n]eotest [o]utput floating window.",
    },
}
