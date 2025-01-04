return {
    {
        "<F5>",
        function()
            require("dapui").open()  -- Requires nvim-dap-ui

            vim.cmd[[DapContinue]]  -- Important: This will lazy-load nvim-dap
        end,
        desc="Start a debugging session.",
    },
    {
        "<leader>dd",
        function()
            require("dapui").open()  -- Requires nvim-dap-ui

            -- IMPORTANT: This does two things at once
            --
            -- 1. Calling DapContinue will lazy-load nvim-dap
            -- 2. We vim.schedule because DapContinue may spawn a GUI but we
            --    need that GUI to spawn after dapui.open() is 100% finished.
            --    vim.schedule will make sure of this.
            --
            vim.schedule(function() vim.cmd[[DapContinue]] end)
        end,
        desc="[d]o [d]ebugger. Start a debugging session.",
    },
}
