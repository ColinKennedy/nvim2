return {
    -- Lightweight CMake command - limited project structure knowledge
    {
        "ColinKennedy/vim-cmake",
        cmd = { "CMake", "CMakeClean", "CMakeFindBuildDir" },
        config = function()
            -- Always generate a compile_commands.json file
            vim.g.cmake_export_compile_commands = 1
            vim.g.cmake_executable = "cmake3"
        end,
    },

    {
        -- Async Make + awesome quick-fix window error reporting
        "ColinKennedy/vim-dispatch",
        cmd = { "Dispatch", "Make" },
        config = function()
            vim.g.dispatch_no_maps = 1
        end,
        version = "1.*",
    },

    -- A cool plugin that makes it easier to search/replace variations of words
    -- Example: Subvert/child{,ren}/adult{,s}/g
    --
    -- Also, it has mappings for changing case like `crs` (change to snake-case)
    --
    {
        "tpope/vim-abolish",
        cmd = { "S", "Subvert" },
        version = "1.*",
    },

    -- Wrap and unwrap function arguments, lists, and dictionaries with one mapping
    -- Note: This has a bug something_long_and_the_like.more_things_here("[q", "another", {"asdfsfd": [1, 3, 5]})
    -- I think I'll just not use this for a while and see how it goes.
    --
    {
        "FooSoft/vim-argwrap",
        cmd = {"ArgWrap"},
        config = function()
            vim.g.argwrap_tail_comma = 1
        end,
    },
    -- A treesitter-based tool for splitting and joining lines. Pretty fast.
    {
        "Wansmer/treesj",
        keys = {"<leader>sa"},
        config = function()
            require("my_custom.plugins.data.treesj")

            local treesj = require("treesj")

            treesj.setup({ max_join_length = 150 })

            vim.keymap.set(
                "n",
                "<leader>sa",
                function()
                    treesj.toggle()
                end,
                {}
            )
        end,
    },

    -- A plugin that is able to load project-specific .vimrc files
    -- It's like [krisajenkins/vim-projectlocal](http://github.com/krisajenkins/vim-projectlocal) but it's not broken(!)
    --
    -- It can even differentiate between .vimrc files you've authored and others
    -- which may contain malicious code
    --
    {
        "MarcWeber/vim-addon-local-vimrc",
    },

    -- Press * or # in Visual mode to start a search
    {
        "bronson/vim-visual-star-search",
        keys = {"*", "#"},
        version = "0.*",
    },

    -- Auto-completion tags for Houdini SideFX VEX commands
    {
        "ColinKennedy/vim-vex-complete",
        ft = { "vex" },
        version = "1.*",
    },

    -- Auto-completion tags for Pixar USD keywords
    {
        "ColinKennedy/vim-usd-complete",
        ft = { "usda", "usd" },
        version = "1.*",
    },

    -- A plugin that makes Vim's "gf" command work with USD URIs
    {
        "ColinKennedy/vim-usd-goto",
        config = function()
            vim.g.usdresolve_command = 'rez-env USD -- usdresolve "{path}"'
        end,
        ft = { "usda", "usd" },
        version = "1.*",
    },

    -- Read and write USD crate files
    {
        "ColinKennedy/vim-usd-crate-auto-convert",
        config = function()
            vim.g.usdcat_command = 'rez_usdcat'
        end,
        ft = { "usda", "usd" },
        version = "1.*",
    },

    -- Always show the current USD Prim context. Useful when navigating nested files
    --
    -- TODO: Figure out a way to defer-eval this plug-in
    --
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            local context = require("treesitter-context")
            context.setup{
                on_attach = function(bufnr)
                    type_ = vim.bo[bufnr].filetype
                    return type_ == "usd" or type_ == "objdump"
                end,
            }

            -- Make the context background black
            vim.api.nvim_set_hl(0, "TreesitterContext", {ctermbg=16, bg="#101010"})
        end,
        dependencies = {"nvim-treesitter/nvim-treesitter"},
    },

    -- TODO: Add later
    -- A linter for USD files
    -- {
    --     "ColinKennedy/vim-usd-auto-formatter"
    -- },
    -- augroup filetype
    --     autocmd BufNewFile,BufRead usda,usd,usdc nmap <buffer> <leader>f <Plug>VimUsdAutoFormatterFormatCurrentBuffer<CR>
    -- augroup end

    -- This plugin makes `:cd` local to each tab. Very useful if you do
    -- "tab-per-project" workflows
    --
    {
        "kana/vim-tabpagecd",
        event = { "TabEnter", "TabLeave" },
        version = "0.*",
    },

    -- Swap windows using <C-h>, <C-j>, <C-k>, <C-l> keys and to/from tmux
    {
        "mrjones2014/smart-splits.nvim",
        config = function()
            require("my_custom.plugins.data.smart_splits")
        end,
        dependencies = { "kwkarlwang/bufresize.nvim" },
        keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>" },
        version = "1.*",
    },
    {
        "kwkarlwang/bufresize.nvim",
        config = function()
            require("bufresize").setup()
        end,
        event = { "VeryLazy" },
    },

    -- TODO: Consider adding this again
    -- -- Read a .egg (a Python zip file) as if it's a regular file
    -- {
    --     "ColinKennedy/vim-egg-read",
    -- }

    -- Press <C-w>o to full-screen the current buffer
    {
        -- Note: This plugin needs to load on-start-up I think. You can't defer-load it.
        "troydm/zoomwintab.vim",
        cmd = {"ZoomWinTabOut", "ZoomWinTabToggle"},
    },

    -- TODO: If I lazy-load this plug-in, it forces the cursor to the top of the file. No idea why. Check that out, later
    -- Auto-read external file changes
    {
        "ColinKennedy/vim-file-system-watcher",
        -- event = { "VeryLazy" },
    },

    -- Auto-generate docstrings, using ``<leader>id``
    {
        "ColinKennedy/neogen",
        branch = "combined_branch",
        config = function()
            require("my_custom.plugins.data.neogen")
        end,
        dependencies = {
            "L3MON4D3/LuaSnip",
            "nvim-treesitter/nvim-treesitter"
        },
        keys = { "<leader>id" },
        version = "*",  -- Only follow the latest stable release
    },

    {
        -- Useful from the documentation:
        --
        --     A parser can also be loaded manually using a full path: >
        --         vim.treesitter.require_language("python", "/path/to/python.so")
        --
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            -- I was getting a "not a Win32 application" error on Windows so I added this workaround.
            --
            -- Reference: https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support#troubleshooting
            --
            if vim.fn.has("win32") == 1
            then
                require('nvim-treesitter.install').compilers = { "clang" }
            end
        end,
        lazy = true,
        version = "0.*",
    },

    -- TODO: Possibly remove this submodule
    --
    -- -- Very unfortunately needed because indentation via treesitter has bugs
    -- --
    -- -- Reference: https://github.com/nvim-treesitter/nvim-treesitter/issues/1136
    -- --
    -- {
    --     "Vimjas/vim-python-pep8-indent",
    --     ft = "python",
    -- },

    -- -- Enables nvim-treesitter syntax highlighting groups for USD files.
    -- --
    -- -- Note: This does nothing unless you call
    -- --
    -- -- ```
    -- -- require("nvim-treesitter.configs").setup {
    -- --     parser_install_dir = installation_directory,
    -- --     highlight = { enable = true },
    -- -- }
    -- -- ```
    -- --
    -- {
    --     "ColinKennedy/nvim-treesitter-usd",
    --     ft = "usd",
    --     version = "0.*",
    -- },

    {
        "ColinKennedy/nvim-treesitter-textobjects",
        branch = "modified_include_surrounding_whitespace_behavior",
        config = function()
            require("my_custom.plugins.data.nvim_treesitter_textobjects_config")
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        -- TODO: It seems that lazy-loading this sometimes causes the plug-in
        -- to break. Though it would be nice if there was a way to consistently
        -- lazy-load it.
        --
        -- event = { "VeryLazy" },
        -- keys = {
        --     "[k", "]k",
        --     "[m", "]m",
        --     "[K", "]K",
        --     "[M", "]M",
        --
        --     "dab",
        --     "dac",
        --     "dad",
        --     "daf",
        --     "dic",
        --     "did",
        --     "dif",
        --
        --     "vab",
        --     "vac",
        --     "vad",
        --     "vaf",
        --     "vic",
        --     "vid",
        --     "vif",
        -- },
    },

    -- Kickass class / function viewer
    {
        "stevearc/aerial.nvim",
        config = function()
            require("aerial").setup(
                {
                    backends = { "lsp", "treesitter" },
                    highlight_on_jump = 100,  -- Shorten the blink time to be fast
                    nav = {
                        keymaps = {
                            ["<CR>"] = "actions.jump",
                            ["q"] = "actions.close",
                        },
                    },
                    layout = {
                        resize_to_content = false,
                    },
                }
            )

            vim.keymap.set(
                "n",
                "<space>SS",
                ":AerialToggle<CR>",
                {desc="[S]witch [S]idebar - Open a sidebar that shows the code file's classes, functions, etc."}
            )
            vim.keymap.set(
                "n",
                "<space>SN",
                ":AerialNavToggle<CR>",
                {desc="[S]witch [N]avigation inside / outside of classes and functions."}
            )
        end,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        cmd = { "AerialNavToggle", "AerialToggle"},
        keys = { "<space>SN", "<space>SS" }, -- S as in "Summary"
        version = "stable",
    },

    -- Quickfix auto previews and other fun features
    {
        "kevinhwang91/nvim-bqf",
        dependencies = {"junegunn/fzf", "nvim-treesitter/nvim-treesitter"},
        ft = "qf",
        version = "0.*",
    },

    -- Auto-insert pairs
    {
        -- Lazy-loading this causes the plug-in to break. So probably you can't do it.
        "KaraMCC/vim-gemini",
        enabled = function()
            return vim.v.version >= 800
        end,
        config = function()
            -- Force gemini to build its mappings
            vim.cmd[[:doautoall create_gemini_mappings BufEnter]]
        end,
        event = "VeryLazy",  -- Or maybe InsertEnter
    },

    -- Give vim some shell-like commands that it's missing
    {
        "tpope/vim-eunuch",
        cmd = { "Delete", "Mkdir", "Move", "Rename", "SudoEdit", "SudoWrite" },
        version = "1.*",
    },

    -- REPEAT LAST (USER) COMMAND and makes the '.' command even cooler
    {
        "tpope/vim-repeat",
        event = { "VeryLazy" },
        version = "1.*",
    },

    -- A tool which automatically backs up modified files to a git repository
    {
        "ColinKennedy/vim-git-backup",
        cmd = {
            "BackupCurrentFile",
            "GHistory",
            "OpenCurrentFileBackupHistory",
            "RestoreFileUsingGitBackup",
            "ToggleBackupFile",
        },
        event = { "BufWritePre", "FileWritePre" },
        version = "2.*",
    },

    -- Useful git commands. Such as :Gcd
    {
        "tpope/vim-fugitive",
        cmd = "Gcd",
        version = "3.*",
    },

    -- Auto-sets Vim ``tabstop`` and ``shiftwidth``, based on the existing file's context
    {
        "tpope/vim-sleuth",
        -- TODO: I think I can't eval-defer this. Otherwise, it won't be
        -- available when opening the first file. If so, remove this plug-in
        --
        -- event = { "VeryLazy" },
        version = "2.*",
    },

    -- Show all file edits as an tree
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
        -- Note: No explicit `version = ` here but there could be one
    },

    -- Removes whitespace only on the lines you've changed. Pretty cool!
    {
        "lewis6991/spaceless.nvim",
        config = function()
            require("spaceless").setup()
        end,
        event = { "InsertEnter" },
    },

    -- A tree file/directory viewer plug-in
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            local toggle_current_directory = function()
                local current_directory = vim.fn.getcwd()
                vim.cmd(":NvimTreeToggle " .. current_directory)
            end

            -- termguicolors was already set elsewhere. But I'll keep it commented here
            -- just so that we remember to do it in case that changes in the future.
            --
            -- set termguicolors to enable highlight groups
            --
            -- vim.opt.termguicolors = true

            -- Empty setup using defaults
            require("nvim-tree").setup()

            vim.api.nvim_create_user_command(
                "PwdNvimTreeToggle",
                toggle_current_directory,
                {nargs=0}
            )
            vim.keymap.set(
                "n",
                "<space>W",
                ":PwdNvimTreeToggle<CR>",
                {desc="Open NvimTree starting from the `:pwd`."}
            )
        end,
        cmd = { "PwdNvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen", "NvimTreeToggle" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = { "<space>W" } -- W as in "workspace view"
    },

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

            command = os.getenv("HOME") .. "/sources/cpptools-linux-1.13.9/extension/debugAdapters/bin/OpenDebugAD7"

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

            vim.keymap.set(
                "n",
                "<leader>d<space>",
                ":DapContinue<CR>",
                {desc="Continue through the debugger to the next breakpoint."}
            )
            vim.keymap.set(
                "n",
                "<leader>dl",
                ":DapStepInto<CR>",
                {desc="Move into a function call."}
            )
            vim.keymap.set(
                "n",
                "<leader>dj",
                ":DapStepOver<CR>",
                {desc="Skip over the current line."}
            )
            vim.keymap.set(
                "n",
                "<leader>dh",
                ":DapStepOut<CR>",
                {desc="Move out of the current function call."}
            )
            vim.keymap.set(
                "n",
                "<leader>dx",
                function()
                    require("dap").run_to_cursor()
                end,
                {desc="Run to [d]ebug cursor to [x] marks the spot."}
            )
            vim.keymap.set(
                "n",
                "<leader>dz",
                ":ZoomWinTabToggle<CR>",
                {desc="[d]ebugger [z]oom toggle (full-screen or minimize the window)."}
            )
            vim.keymap.set(
                "n",
                "<leader>dgt",
                ":lua require('dap').set_log_level('TRACE')<CR>",
                {desc="Set [d]ebu[g] to [t]race level logging."}
            )
            vim.keymap.set(
                "n",
                "<leader>dge",
                function()
                    vim.cmd(":edit " .. vim.fn.stdpath('cache') .. "/dap.log")
                end,
                {desc="Open the [d]ebu[g] [e]dit file."}
            )
            vim.keymap.set(
                "n",
                "<F1>",
                ":DapStepOut<CR>",
                {desc="Move out of the current function call."}
            )
            vim.keymap.set(
                "n",
                "<F2>",
                ":DapStepOver<CR>",
                {desc="Skip over the current line."}
            )
            vim.keymap.set(
                "n",
                "<F3>",
                ":DapStepInto<CR>",
                {desc="Move into a function call."}
            )
            vim.keymap.set(
                "n",
                "<leader>d-",
                function()
                    require("dap").restart({terminateDebugee=false})
                end,
                {desc="Restart the current debug session."}
            )
            vim.keymap.set(
                "n",
                "<leader>d=",
                function()
                    require("dap").disconnect({terminateDebugee=false})
                end,
                {desc="Disconnect from a remote DAP session."}
            )
            vim.keymap.set(
                "n",
                "<leader>d_",
                function()
                    require("dap").terminate()
                    require("dapui").close()
                end,
                {desc="Kill the current debug session."}
            )
            -- vim.keymap.set("n", "<leader>dv", ":call GoToWindow(g:vimspector_session_windows.variables)<CR>")
            -- vim.keymap.set("n", "<leader>ds", ":call GoToWindow(g:vimspector_session_windows.stack_trace)<CR>")
        end,
        cmd = "DapContinue",
        lazy = true,
        version = "0.*",
    },

    -- A default "GUI" front-end for nvim-dap
    {
        "ColinKennedy/nvim-dap-ui",
        config = function()
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
                {
                    desc="[d]o [d]ebugger. Start a debugging session.",
                }
            )
        end,
        dependencies = {
            "mfussenegger/nvim-dap",

            "theHamsta/nvim-dap-virtual-text",  -- Optional dependency for virtual text

            "mfussenegger/nvim-dap-python",  -- Optional adapter for Python
        },
        keys = { "<F5>", "<leader>dd" },
    },

    -- Adds the current value(s) of variables as you step through the code. Super handy!
    {
        "theHamsta/nvim-dap-virtual-text",
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

            vim.keymap.set(
                "n",
                "<leader>db",
                ":PBToggleBreakpoint<CR>",
                {desc="Set a breakpoint (and remember it even when we re-open the file)."}
            )

            require('persistent-breakpoints.api').load_breakpoints()
        end,
        dependencies = {"mfussenegger/nvim-dap"},
        keys = { "<leader>db" },
    },

    -- Seamlessly switch between a binary file view and a hexdump-ish view and back
    -- It's a fancy plug-in that replaces ``:h hex-editing``
    --
    -- Reference: https://vi.stackexchange.com/a/2237/16073
    --
    {
        "RaafatTurki/hex.nvim",
        config = function()
            require("hex").setup()

            vim.api.nvim_create_user_command(
                "ToggleHexView",
                function()
                    -- Requires https://github.com/RaafatTurki/hex.nvim
                    require("hex").toggle()
                end,
                {
                    desc = "Switch a binary file to a hexdump-ish view and back."
                }
            )
        end,
        cmd = "ToggleHexView"
    },

    -- A pop-up that shows you available Neovim keymaps. Only pops up if you're slow
    {
        "folke/which-key.nvim",
        config = function()
            local which_key = require("which-key")

            which_key.setup {
                ignore_missing = true,
                triggers_blacklist = {
                    c = {"%", ">"},  -- Prevent mappings like %s/ from popping up
                },
                plugins = {
                    presets = {
                        motions = false,
                        text_objects = false,
                        operators = false,
                    }
                }
            }

            which_key.register(
                {
                    ["<leader>"] = {
                        c = "+file-ish prefix",
                        d = {
                            name = "+debug prefix",
                            ["<Space>"] = "Continue through the debugger to the next breakpoint.",
                            ["-"] = "Restart the current debug session.",
                            ["="] = "Disconnect from a remote DAP session.",
                            ["_"] = "Kill the current debug session.",
                            b = "Set a breakpoint (and remember it even when we re-open the file).",
                            d = "[d]o [d]ebugger.",
                            g = {
                                name = "+debu[g] lo[g] prefix",
                                e = "Open the [d]ebu[g] [e]dit file.",
                                t = "Set [d]ebu[g] to [t]race level logging.",
                            },
                            h = "Move out of the current function call.",
                            j = "Skip over the current line.",
                            l = "Move into a function call.",
                            z = "[d]ebugger [z]oom toggle (full-screen or minimize the window).",
                        },
                        f = "[f]ind text using hop-mode",
                        i = {
                            name = "+insert prefix",
                            d = "[i]nsert auto-[d]ocstring.",
                        },
                        r = "+run prefix",
                        s = {
                            name = "+misc prefix",
                            a = { "[s]plit [a]rgument list" },
                        },
                    },
                    ["<space>"] = {
                        name = "Space Switching Mappings",
                        A = "Show [A]rgs list",
                        B = "Show [B]uffers list",
                        D = "[D]ebugging interactive mode",
                        E = "[E]dit a new project root file",
                        G = "[G]it interactive mode",
                        L = "[L]ines searcher (current file)",
                        S = {
                            name = "[S]witcher aerial.nvim windows",
                            A = "[S]witch [N]avigation",
                            S = "[S]witch [S]idebar",
                            O = "[S]ymbols [O]utliner (LSP)",
                        },
                        T = "Create a [T]erminal on the bottom of the current window.",
                        W = "Open [W]orkspace (NvimTree)",
                        Z = "[Z]oxide's interative pwd switcher",
                        c = {
                            name = "+LSP [c]ode prefix",
                            a = "Run [c]ode [a]ction",
                        },
                        e = "[e]dit a `:pwd` file",
                        q = "Switch to [q]uickfix window, if open",
                        w = {
                            name = "+workspace LSP prefix",
                            a = "LSP [w]orkspace [a]dd",
                            l = "LSP [w]orkspace [l]ist",
                            r = "LSP [w]orkspace [r]remove",
                        },
                    },
                }
            )
        end,
        keys = {"<Space>", "<leader>"},
        version = "stable",
    },

    -- An async "parameter highlights" plugin that uses tree-sitter.
    -- It works without LSP on any of its supported languages.
    --
    {
        "m-demare/hlargs.nvim",
        config = function()
            require('hlargs').setup()

            -- Reference: https://github.com/m-demare/hlargs.nvim/blob/07e33afafd9d32b304a8557bfc1772516c005d75/doc/hlargs.txt#L306
            vim.api.nvim_create_augroup("LspAttach_hlargs", {clear = true})
            vim.api.nvim_create_autocmd("LspAttach", {
                group = "LspAttach_hlargs",
                callback = function(args)
                    if not (args.data and args.data.client_id) then
                        return
                    end

                    for _, client in ipairs(vim.lsp.get_active_clients())
                    do
                        local caps = client.server_capabilities

                        if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
                            require("hlargs").disable_buf(args.buf)

                            break
                        end
                    end
                end,
            })
        end,
        event = { "VeryLazy" },
    },

    -- A plugin that quickly makes and deletes Terminal buffers.
    {
        "akinsho/toggleterm.nvim",
        config = function()
            vim.keymap.set(
                "n",
                "<space>T",
                ":ToggleTerm direction=horizontal<CR>",
                {
                    desc="Create a [T]erminal on the bottom of the current window.",
                    silent=true,
                }
            )

            require("toggleterm").setup()

            -- Important: This allows terminals to stay in terminal mode even
            -- as you move in and out of them
            --
            function _G.set_terminal_keymaps()
                local opts = {buffer = 0}
                vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
                vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
                vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
                vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
                vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
                vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
            end
            -- Note: If you only want these mappings for toggle term use term://*toggleterm#* instead
            vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
        end,
        version = "v2.*",
        keys = "<Space>T",
    },

    -- -- Allow terminal buffers to be edited
    -- --
    -- -- TODO: Re-add after this is fixed - https://github.com/chomosuke/term-edit.nvim/issues/56
    -- --
    -- {
    --     "chomosuke/term-edit.nvim",
    --     config = function()
    --         if vim.fn.has("win32") == 1
    --         then
    --             prompt = ">"
    --         else
    --             prompt = "%$ "
    --         end
    --
    --         require('term-edit').setup {
    --             -- Mandatory option:
    --             --
    --             -- Set this to a lua pattern that would match the end of your prompt.
    --             -- Or a table of multiple lua patterns where at least one would match the
    --             -- end of your prompt at any given time.
    --             --
    --             -- How to write lua patterns: https://www.lua.org/pil/20.2.html
    --             --
    --             -- For most bash/zsh user this is '%$ '.
    --             -- For most powershell/fish user this is '> '.
    --             -- For most windows cmd user this is '>'.
    --             --
    --             prompt_end = prompt,
    --             -- mapping = {
    --             --     t = {
    --             --         kk = k
    --             --     }
    --             -- },
    --         }
    --     end,
    --     ft = "toggleterm",
    --     version = "v1.*",
    -- },

    -- Allow quick and easy navigation to common project files
    -- Files are saved in `:lua print(vim.fn.stdpath("data") .. "/grapple")`
    --
    {
        "cbochs/grapple.nvim",
        config = function()
            vim.keymap.set(
                "n",
                "<M-S-j>",
                function()
                    require("grapple").cycle_forward()
                end,
                {desc = "Move to the next saved project path."}
            )

            vim.keymap.set(
                "n",
                "<M-S-k>",
                function()
                    require("grapple").cycle_backward()
                end,
                {desc = "Move to the previous saved project path."}
            )

            vim.keymap.set(
                "n",
                "<M-S-l>",
                function()
                    require("grapple").popup_tags("git")
                end,
                {desc = "Show all saved project paths."}
            )

            vim.keymap.set(
                "n",
                "<M-S-h>",
                function()
                    require("grapple").toggle({scope="git"})
                end,
                {desc = "Add / Remove the current file as a project path."}
            )
        end,
        dependencies = {"ColinKennedy/plenary.nvim"},
        keys = { "<M-S-h>", "<M-S-j>", "<M-S-k>", "<M-S-l>" },
        version = "v0.*",
    },

    -- Allow the quickfix buffer to be directly editted. Finally!
    -- I hear this plug-in might be a bit buggy. Keep an eye out for it.
    --
    -- Possible alternative - https://github.com/stefandtw/quickfix-reflector.vim
    --
    -- Reference: https://www.reddit.com/r/neovim/comments/16k6spq/best_quickfixlist_plugin/
    --
    {
        "itchyny/vim-qfedit",
        ft = "qf",
    },

    -- Use `jk` to exit -- INSERT -- mode. AND there's j/k input delay. Pretty useful.
    {
        "max397574/better-escape.nvim",
        config = function()
          require("better_escape").setup()
        end,
        event = "InsertEnter",
    },

    -- Add "submodes" to Neovim. e.g. <Space>G for "git mode"
    {
        "anuvyklack/hydra.nvim",
        config = function()
            require("my_custom.plugins.manifest.hydra")
        end,
        keys = { "<Space>G" },
    },

    -- Use the s/S key to hop quickly from one place to another.
    --
    -- Usage:
    --     - Press s
    --     - Type a letter
    --     - Type another letter
    --     - If your text that you want to jump to **doesn't** light up then press <Enter>
    --         - You're done
    --     - If it has a lit-up letter next to it, press it
    --         - You're done
    {
        "ggandor/leap.nvim",
        config = function()
            vim.keymap.set(
                "n",
                "s",
                "<Plug>(leap-forward-to)",
                {
                    desc = "Leap forward to",
                    silent = true,
                }
            )
            vim.keymap.set(
                "n",
                "S",
                "<Plug>(leap-backward-to)",
                {
                    desc = "Leap backward to",
                    silent = true,
                }
            )

            require("leap").init_highlight()

            require('leap').opts.safe_labels = {
                "a", "s", "d", "f", "j", "k", "l", ";",
                "g", "h",
                "A", "S", "D", "F", "J", "K", "L",
            }
        end,
    },

    -- Show classes / functions / variables in an outliner
    {
        "simrat39/symbols-outline.nvim",
        config = function()
            -- Note:
            --     The SymbolsOutline assumes that the current file has been
            --     processed by the user's LSP. If the LSP is missing, broken, or
            --     hasn't run on the file yet, the outliner may not show. So we add
            --     a small disclaimer to let people know to try again, if needed.
            --
            print("Note: If symbol outliner doesn't open, wait for LSPs and try again.")

            require("symbols-outline").setup()

            vim.keymap.set(
                "n",
                "<Space>SO",
                ":SymbolsOutline<CR>",
                {
                    desc = "Open [S]ymbols [O]utliner",
                    silent = true,
                }
            )
        end,
        dependencies = { "neovim/nvim-lspconfig" },
        cmd = "SymbolsOutline",
        keys = {"<Space>SO"}
    },
}
