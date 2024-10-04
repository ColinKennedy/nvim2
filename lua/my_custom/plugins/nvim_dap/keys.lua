return {
    {
        "<leader>d<space>",
        "<cmd>DapContinue<CR>",
        desc="Continue through the debugger to the next breakpoint.",
    },
    {
        "<leader>dl",
        "<cmd>DapStepInto<CR>",
        desc="Move into a function call.",
    },
    {
        "<leader>dj",
        "<cmd>DapStepOver<CR>",
        desc="Skip over the current line.",
    },
    {
        "<leader>dh",
        "<cmd>DapStepOut<CR>",
        desc="Move out of the current function call.",
    },
    {
        "<leader>dx",
        function() require("dap").run_to_cursor() end,
        desc="Run to [d]ebug cursor to [x] marks the spot.",
    },
    {
        "<leader>dz",
        "<cmd>ZoomWinTabToggle<CR>",
        desc="[d]ebugger [z]oom toggle (full-screen or minimize the window).",
    },
    {
        "<leader>dgt",
        "<cmd>lua require('dap').set_log_level('TRACE')<CR>",
        desc="Set [d]ebu[g] to [t]race level logging.",
    },
    {
        "<leader>dge",
        function() vim.cmd(":edit " .. vim.fn.stdpath('cache') .. "/dap.log") end,
        desc="Open the [d]ebu[g] [e]dit file.",
    },
    {
        "<F1>",
        "<cmd>DapStepOut<CR>",
        desc="Move out of the current function call.",
    },
    {
        "<F2>",
        "<cmd>DapStepOver<CR>",
        desc="Skip over the current line.",
    },
    {
        "<F3>",
        "<cmd>DapStepInto<CR>",
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
    -- vim.keymap.set("n", "<leader>dv", "<cmd>call GoToWindow(g:vimspector_session_windows.variables)<CR>")
    -- vim.keymap.set("n", "<leader>ds", "<cmd>call GoToWindow(g:vimspector_session_windows.stack_trace)<CR>")
    {
        "<leader>db",
        "<cmd>DapToggleBreakpoint<CR>",
        desc="Set a breakpoint in the current file + cursor.",
    },
}
