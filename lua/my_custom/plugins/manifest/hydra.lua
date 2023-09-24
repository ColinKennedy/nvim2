local Hydra = require("hydra")
local gitsigns = require("gitsigns")
local gitsigns_utility = require("my_custom.plugins.data.gitsigns")


local _get_window_by_type = function(type_name)
    for _, data in pairs(vim.fn.getwininfo())
    do
        if vim.api.nvim_buf_get_option(data.bufnr, "filetype") == type_name
        then
            return data
        end
    end

    return nil
end


local _zoom_by_type = function(type_name)
    local data = _get_window_by_type(type_name)

    if data == nil
    then
        print("No buffer could be found.")

        return
    end

    if vim.fn.exists("t:zoomwintab") == 1
    then
        -- The window is already zoomed in. Zoom out first
        vim.cmd[[ZoomWinTabOut]]

        if data.winnr == vim.fn.winnr()
        then
            -- Returning early effectively allows us to "toggle"
            -- the zoom mapping. e.g. Pressing ``<leader>dw`` zooms
            -- into the Watchers window. Pressing ``<leader>dw``
            -- again will "zoom out".
            --
            return
        end
    end

    vim.fn.win_gotoid(data.winid)

    vim.cmd[[ZoomWinTabToggle]]
end


local add_zoom_keymap = function(mapping, type_name)
    vim.keymap.set(
        "n",
        mapping,
        function()
            _zoom_by_type(type_name)
        end,
        {desc="Toggle-full-screen the " .. type_name .. " DAP window."}
    )
end


local git_hint = [[
 _J_: next hunk   _t_: s[t]age hunk        _d_: show [d]eleted   _b_: blame line
 ^ ^              _r_: [r]eset hunk        ^ ^                   ^ ^
 _K_: prev hunk   _c_: [c]heckout hunk     _p_: [p]review hunk   _B_: blame show full
 ^ ^              _T_: stage buffer        ^ ^                   _/_: show base file
 ^
 ^ ^              _<Enter>_: Neogit                _q_: exit
]]

local debugging_hint = [[
 Navigation
 _H_: Step out         _J_: Step over              _L_: Step in

 Control
 _g_: Continue         _b_: Toggle [b]reakpoint    _x_: Run to cursor

 Windows
 _c_: [c]onsole        _w_: [w]atches              _s_: [s]copes   _t_: s[t]acks  _r_: [r]epl
 _z_: Zoom window

 Logging
 _tl_: [t]race [l]vl   _te_: Open [t]race [e]dit

 Session
 _o_: Open GUI         _-_: Restart                _=_: Disconnect remote
 ^ ^                   _q_: exit
]]


Hydra(
    {
        name = "Git",
        hint = git_hint,
        config = {
            buffer = bufnr,
            color = "pink",
            invoke_on_body = true,
            hint = {
                border = "rounded"
            },
            on_enter = function()
                vim.cmd "silent! %foldopen!"
                gitsigns.toggle_signs(true)
                gitsigns.toggle_linehl(true)
            end,
            on_exit = function()
                local cursor_pos = vim.api.nvim_win_get_cursor(0)
                vim.api.nvim_win_set_cursor(0, cursor_pos)
                vim.cmd 'normal zv'  -- Unfold evrything at the current cursor
                gitsigns.toggle_signs(false)
                gitsigns.toggle_linehl(false)
                gitsigns.toggle_deleted(false)
            end,
        },
        mode = {"n","x"},
        body = "<Space>G",
        heads = {
            {
                "J",
                function()
                    if vim.wo.diff then return "]c" end
                    vim.schedule(function() gitsigns_utility.next_hunk() end)
                    return "<Ignore>"
                end,
                { expr = true, desc = "next hunk" } },
            {
                "K",
                function()
                    if vim.wo.diff then return "[c" end
                    vim.schedule(function() gitsigns_utility.previous_hunk() end)
                    return "<Ignore>"
                end,
                { expr = true, desc = "prev hunk" } },
            {
                "c",
                gitsigns.reset_hunk,
                { silent = true, desc = "[c]heckout hunk" },
            },
            { "t", ":Gitsigns stage_hunk<CR>", { silent = true, desc = "stage hunk" } },
            {
                "r",
                gitsigns.undo_stage_hunk,
                { desc = "[r]eset staged hunk" },
            },
            { "T", gitsigns.stage_buffer, { desc = "stage buffer" } },
            { "p", gitsigns.preview_hunk, { desc = "preview hunk" } },
            { "d", gitsigns.toggle_deleted, { nowait = true, desc = "toggle deleted" } },
            { "b", gitsigns.blame_line, { desc = "blame" } },
            { "B", function() gitsigns.blame_line{ full = true } end, { desc = "blame show full" } },
            { "/", gitsigns.show, { exit = true, desc = "show base file" } }, -- show the base of the file
            { "<Enter>", "<Cmd>Neogit<CR>", { exit = true, desc = "Neogit" } },
            { "q", nil, { exit = true, nowait = true, desc = "exit" } },
        }
    }
)


Hydra(
    {
        name = "Debug",
        hint = debugging_hint,
        config = {
            buffer = bufnr,
            color = "red",
            invoke_on_body = true,
            hint = {
                border = "rounded"
            },
            on_enter = function()
                vim.cmd "silent! %foldopen!"
            end,
            on_exit = function()
                local cursor_pos = vim.api.nvim_win_get_cursor(0)
                vim.api.nvim_win_set_cursor(0, cursor_pos)
                vim.cmd 'normal zv'  -- Unfold evrything at the current cursor
            end,
        },
        mode = {"n", "x"},
        body = "<Space>D",
        heads = {
            -- Navigation mappings
            {
                "H",
                ":DapStepOut<CR>",
                { desc="Move out of the current function call." },
            },
            {
                "J",
                ":DapStepOver<CR>",
                { desc="Skip over the current line." },
            },
            {
                "L",
                ":DapStepInto<CR>",
                { desc="Move into a function call." },
            },

            -- Control mappings
            {
                "g",
                ":DapContinue<CR>",
                { desc="Continue through the debugger to the next breakpoint." }
            },
            {
                "b",
                ":PBToggleBreakpoint<CR>",
                { desc = "Toggle [b]reakpoint." },
            },
            {
                "x",
                function()
                    require("dap").run_to_cursor()
                end,
                { desc="Run to [d]ebug cursor to [x] marks the spot." },
            },

            -- Window mappings
            {
                "c",
                function() _zoom_by_type("dapui_console") end,
                { desc="Toggle-full-screen the dapui_console DAP window." },
            },
            {
                "w",
                function() _zoom_by_type("dapui_watches") end,
                { desc="Toggle-full-screen the dapui_watches DAP window." },
            },
            {
                "s",
                function() _zoom_by_type("dapui_scopes") end,
                { desc="Toggle-full-screen the dapui_scopes DAP window." },
            },
            {
                "t",
                function() _zoom_by_type("dapui_stacks") end,
                { desc="Toggle-full-screen the dapui_stacks DAP window." },
            },
            {
                "r",
                function() _zoom_by_type("dapui_repl") end,
                { desc="Toggle-full-screen the dapui_repl DAP window." },
            },

            -- Logging
            {
                "tl",
                function()
                    require("dap").set_log_level("TRACE")
                end,
                { desc="Set to [t]race [l]evel logging." }
            },
            {
                "te",
                function()
                    vim.cmd(":edit " .. vim.fn.stdpath('cache') .. "/dap.log")
                end,
                { desc="Open [t]race [e]dit." }
            },

            {
                "z",
                ":ZoomWinTabToggle<CR>",
                { desc="[z]oom window toggle (full-screen or minimize the window)." },
            },

            -- Session mappings
            {
                "o",
                function()
                    require("dapui").open()  -- Requires nvim-dap-ui

                    vim.cmd[[DapContinue]]  -- Important: This will lazy-load nvim-dap
                end,
                { desc="[o]pen debugger." },
            },
            {
                "-",
                function()
                    require("dap").restart({terminateDebugee=false})
                end,
                { desc = "Restart the current debug session." },
            },
            {
                "=",
                function()
                    require("dap").disconnect({terminateDebugee=false})
                end,
                { desc="Disconnect from a remote DAP session." },
            },
            -- {
            --     "_",
            --     function()
            --         require("dap").terminate()
            --         require("dapui").close()
            --     end,
            --     {desc="Kill the current debug session."},
            -- },

            { "q", nil, { exit = true, nowait = true, desc = "exit" } },
        }
    }
)
