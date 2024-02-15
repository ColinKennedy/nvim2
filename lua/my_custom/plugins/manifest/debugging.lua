return {
    -- Debug adapter plug-in. Debug anything in Neovim
    {
        "mfussenegger/nvim-dap",
        config = function()
            -- Important: We must define ``require("dap")`` at least once.
            -- Otherwise the ``DapBreakpoint`` sign won't be available for
            -- another plug-in, ``Weissle/persistent-breakpoints.nvim``, to
            -- refer to + use.
            --
            local dap = require("dap")

            local command = os.getenv("HOME") .. "/sources/cpptools-linux-1.13.9/extension/debugAdapters/bin/OpenDebugAD7"

            -- Reference: https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(gdb-via--vscode-cpptools)#ccrust-gdb-via--vscode-cpptools
            if vim.fn.has("win32") == 1
            then
                -- Note: Not tested. Just copied from the guide above
                dap.adapters.cppdbg = {
                    id = "cppdbg",
                    type = "executable",
                    command = command,
                    options = {
                        detached = false,
                    },
                }
            else
                dap.adapters.cppdbg = {
                    id = "cppdbg",
                    type = "executable",
                    command = command,
                }
            end
        end,
        cmd = "DapContinue",
        keys = {
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
        },
        version = "0.*",
    },

    -- A default "GUI" front-end for nvim-dap
    {
        "ColinKennedy/nvim-dap-ui",
        config = function()
            -- Note: These colors look good with https://github.com/ColinKennedy/hybrid2.nvim
            vim.api.nvim_set_hl(0, "SearchFG", {fg="#f0c674", ctermfg=222})
            vim.api.nvim_set_hl(0, "DapUIDisassemblyHighlightLine", {link="SearchFG"})

            require("dapui").setup()

            vim.keymap.set(
                "n",
                "<F6>",
                function()
                    require("dap").terminate()
                    require("dapui").close()
                end,
                {desc="Close the DAP and the GUI."}
            )

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

            add_zoom_keymap("<leader>dc", "dapui_console")
            add_zoom_keymap("<leader>dw", "dapui_watches")
            add_zoom_keymap("<leader>ds", "dapui_scopes")
            add_zoom_keymap("<leader>dt", "dapui_stacks")  -- dt as in s[t]acks
            add_zoom_keymap("<leader>dr", "dap-repl")
        end,
        dependencies = {
            "mfussenegger/nvim-dap",

            "ColinKennedy/nvim-dap-virtual-text",  -- Optional dependency for virtual text

            "mfussenegger/nvim-dap-python",  -- Optional adapter for Python
        },
        keys = {
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
        },
    },

    -- Adds the current value(s) of variables as you step through the code. Super handy!
    {
        "ColinKennedy/nvim-dap-virtual-text",
        branch = "fix_missing_asm_parser",
        config = function()
            require("nvim-dap-virtual-text").setup()
        end,
        dependencies = {"mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter"},
        lazy = true,
    },

    -- TODO: Defer-load this plug-in
    -- TODO: Make sure that debugpy is installed. Otherwise, disable
    -- Reference: https://github.com/mfussenegger/nvim-dap-python#installation
    --
    {
        "mfussenegger/nvim-dap-python",
        config = function()
            require("dap-python").setup(
                vim.g.vim_home
                .. "/mason_packages/"
                .. vim.loop.os_uname().sysname
                .. "/packages/debugpy/venv/bin/python"
            )
            -- An example configuration to launch any Python file, via Houdini
            -- table.insert(
            --     require("dap").configurations.python,
            --     {
            --         type = "python",
            --         request = "launch",
            --         name = "Launch Via hython",
            --         program = "${file}",
            --         python = "/opt/hfs19.5.569/bin/hython"
            --         -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
            --     }
            -- )
        end,
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter",
        },
        lazy = true,
    },

    -- Remember nvim-dap breakpoints between sessions, using ``:PBToggleBreakpoint``
    {
        "Weissle/persistent-breakpoints.nvim",
        config = function()
            require("persistent-breakpoints").setup{
                load_breakpoints_event = { "BufReadPost" }
            }

            require('persistent-breakpoints.api').load_breakpoints()
        end,
        dependencies = {"mfussenegger/nvim-dap"},
        ft = {"c", "cpp"},  -- These are the file types that I'd usually have breakpoints
        keys = {
            {
                "<leader>db",
                ":PBToggleBreakpoint<CR>",
                desc="Set a breakpoint (and remember it even when we re-open the file).",
            },
        },
    },
}
