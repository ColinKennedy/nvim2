vim.keymap.set(
    "n",
    "<F5>",
    function()
        require("dapui").open()

        vim.cmd[[DapContinue]]  -- Important: This will lazy-load nvim-dap
    end,
    {desc="Start a debugging session."}
)

-- Note: Added this <leader>dd duplicate of <F5> because somehow the <F5>
-- mapping keeps getting reset each time I restart nvim-dap. Annoying but whatever.
--
vim.keymap.set(
    "n",
    "<leader>dd",
    function()
        require("dapui").open()  -- Requires nvim-dap-ui

        vim.cmd[[DapContinue]]  -- Important: This will lazy-load nvim-dap
    end,
    {desc="Start a debugging session."}
)
