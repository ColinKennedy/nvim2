return {
    {
        "<leader>d<space>",
        ":DapContinue<CR>",
        desc="Continue through the debugger to the next breakpoint.",
    },
    {
        "<leader>dl",
        ":DapStepInto<CR>",
        desc="Move into a function call.",
    },
    {
        "<leader>dj",
        ":DapStepOver<CR>",
        desc="Skip over the current line.",
    },
    {
        "<leader>dh",
        ":DapStepOut<CR>",
        desc="Move out of the current function call.",
    },
    {
        "<leader>dx",
        function() require("dap").run_to_cursor() end,
        desc="Run to [d]ebug cursor to [x] marks the spot.",
    },
    {
        "<leader>dz",
        ":ZoomWinTabToggle<CR>",
        desc="[d]ebugger [z]oom toggle (full-screen or minimize the window).",
    },
    {
        "<leader>dgt",
        ":lua require('dap').set_log_level('TRACE')<CR>",
        desc="Set [d]ebu[g] to [t]race level logging.",
    },
    {
        "<leader>dge",
        function() vim.cmd(":edit " .. vim.fn.stdpath('cache') .. "/dap.log") end,
        desc="Open the [d]ebu[g] [e]dit file.",
    },
    {
        "<F1>",
        ":DapStepOut<CR>",
        desc="Move out of the current function call.",
    },
    {
        "<F2>",
        ":DapStepOver<CR>",
        desc="Skip over the current line.",
    },
    {
        "<F3>",
        ":DapStepInto<CR>",
        desc="Move into a function call."
    },
    {
        "<leader>d-",
        function() require("dap").restart({ terminateDebugee=false }) end,
        desc="Restart the current debug session.",
    },
    {
        "<leader>d=",
        function() require("dap").disconnect({ terminateDebugee=false }) end,
        desc="Disconnect from a remote DAP session.",
    },
    {
        "<leader>d_",
        function()
            require("dap").terminate()
            require("dapui").close()
        end,
        desc="Kill the current debug session.",
    },
    -- vim.keymap.set("n", "<leader>dv", ":call GoToWindow(g:vimspector_session_windows.variables)<CR>")
    -- vim.keymap.set("n", "<leader>ds", ":call GoToWindow(g:vimspector_session_windows.stack_trace)<CR>")
}
