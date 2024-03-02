return function()
    local neotest = require("neotest")

    neotest.setup{
        adapters = { require("neotest-plenary"), require("neotest-python") },
    }

    -- Reference: https://github.com/nvim-neotest/neotest/discussions/204#discussioncomment-4916056
    --
    -- command! NeotestAttach lua require("neotest").run.attach()
    -- command! NeotestDebug lua require("neotest").run.run({ strategy = "dap" })
    --
    vim.api.nvim_create_user_command(
        "NeotestRunCurrent",
        function() neotest.run.run() end,
        { desc = "[r]un [t]est under [c]ursor in Neotest." }
    )
    vim.api.nvim_create_user_command(
        "NeotestRunDirectory",
        function() neotest.run.run(vim.fn.getcwd()) end,
        { desc = "[r]un [t]est [d]irectory in Neotest." }
    )
    vim.api.nvim_create_user_command(
        "NeotestRunFile",
        function() neotest.run.run(vim.fn.expand("%")) end,
        { desc = "[r]un [t]est [f]ile in Neotest." }
    )
    vim.api.nvim_create_user_command(
        "NeotestRunSuite",
        function() neotest.run.run({suite=true}) end,
        { desc = "[r]un [t]est [f]ile in Neotest." }
    )
end
