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

            vim.cmd[[DapContinue]]  -- Important: This will lazy-load nvim-dap
        end,
        desc="[d]o [d]ebugger. Start a debugging session.",
    },
}
