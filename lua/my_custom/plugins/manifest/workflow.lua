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
    },

    -- A cool plugin that makes it easier to search/replace variations of words
    -- Example: Subvert/child{,ren}/adult{,s}/g
    --
    -- Also, it has mappings for changing case like `crs` (change to snake-case)
    --
    {
        "tpope/vim-abolish",
        cmd = { "S", "Subvert" },
    },

    -- Wrap and unwrap function arguments, lists, and dictionaries with one mapping
    {
        "FooSoft/vim-argwrap",
        cmd = { "ArgWrap" },
        config = function()
            vim.g.argwrap_tail_comma = 1
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
    },

    -- Auto-completion tags for Houdini SideFX VEX commands
    {
        "ColinKennedy/vim-vex-complete",
        ft = { "vex" },
    },

    -- Auto-completion tags for Pixar USD keywords
    {
        "ColinKennedy/vim-usd-complete",
        ft = { "usda", "usd" },
    },

    -- A plugin that makes Vim's "gf" command work with USD URIs
    {
        "ColinKennedy/vim-usd-goto",
        config = function()
            vim.g.usdresolve_command = 'rez-env USD -- usdresolve "{path}"'
        end,
        ft = { "usda", "usd" },
    },

    -- Read and write USD crate files
    {
        "ColinKennedy/vim-usd-crate-auto-convert",
        config = function()
            vim.g.usdcat_command = 'rez_usdcat'
        end,
        ft = { "usda", "usd" },
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
    },

    -- Swap windows using <C-h>, <C-j>, <C-k>, <C-l> keys and to/from tmux
    {
        "mrjones2014/smart-splits.nvim",
        config = function()
            require("my_custom.plugins.data.smart_splits")
        end,
        dependencies = { "kwkarlwang/bufresize.nvim" },
        keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>" },
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

    -- Auto-generate docstrings, using ``<space>d``
    {
        "ColinKennedy/neogen",
        branch = "issues/137-add_google_docstring_raises",
        config = function()
            require("neogen").setup(
                {
                    languages = {
                        python = {
                            template = {
                                annotation_convention = "google_docstrings"
                            }
                        },
                    },
                    placeholders_hl = "String",
                    snippet_engine = "luasnip",
                }
            )
            -- TODO: Not sure how useful Neogen is, in practice. Seems to break too easily.
            vim.keymap.set(
                "n",
                "<leader><leader>d",
                ":Neogen<CR>",
                {desc="Generate a [d]ocstring for the function under the cursor."}
            )
        end,
        dependencies = {
            "L3MON4D3/LuaSnip",
            "nvim-treesitter/nvim-treesitter"
        },
        keys = { "<space>d" },
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
        lazy = true,
    },

    -- Very unfortunately needed because indentation via treesitter has bugs
    --
    -- Reference: https://github.com/nvim-treesitter/nvim-treesitter/issues/1136
    --
    {
        "Vimjas/vim-python-pep8-indent",
        ft = "python",
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
            require("my_custom.plugins.data.nvim_treesitter_textobjects_config")
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        -- TODO: It's technically not correct to have this plug-in run
        -- on-insert or key-press. Try to find a better way to lazy-load this
        -- plug-in so it is available on start-up but doesn't impact
        -- start-time.
        --
        -- event = {"InsertEnter"},
        event = { "VeryLazy" },
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
        "ColinKennedy/aerial.nvim",
        branch = "fix_buffer_id",
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
                }
            )

            -- TODO: Try to figure out a better way to remove this
            -- Note: Disable trailing whitespace highlighting in the aerial window
            vim.api.nvim_create_autocmd(
                {"BufRead", "BufNew", "FileType", "TermOpen"},
                {
                    pattern = "*",
                    callback = function()
                        if vim.bo.buftype == "nofile"
                        then
                            vim.cmd[[match ExtraWhitespace /^^/]]

                            return
                        end
                    end
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
        keys = { "<space>SN", "<space>SS" } -- S as in "Summary"
    },

    {
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        }
    },

    -- Create simple templates for Vim projects using a '.projections.json' sidecar file
    {
        "tpope/vim-projectionist",
        config = function()
            -- TODO: Double check if this works
            require("my_custom.utilities.utility").lazy_load("vim-projectionist")
        end,
        ft = "cpp",
    },

    -- Quickfix helper functions
    -- TODO: Check if this works well with location lists, still
    {
        "romainl/vim-qf",
        ft = "qf",
    },

    -- Quickfix auto-resize. Keeps the quickfix window small
    {
        "blueyed/vim-qf_resize",
        ft = "qf",
    },

    -- TODO: Use a better lazy-load than this
    -- Use <leader>pd to get the Python dot-separated import path at the current cursor
    {
        "ColinKennedy/vim-python-dot-path",
        keys = "<leader>pd",
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
        cmd = { "Delete", "Mkdir", "Move", "Rename", "SudoEdit", "SudoWrite" }
    },

    -- REPEAT LAST (USER) COMMAND and makes the '.' command even cooler
    {
        "tpope/vim-repeat",
        event = { "VeryLazy" },
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
    },

    -- Useful git commands. Such as :Gcd
    {
        "tpope/vim-fugitive",
        cmd = "Gcd",
    },

    -- Auto-sets Vim ``tabstop`` and ``shiftwidth``, based on the existing file's context
    {
        "tpope/vim-sleuth",
        -- TODO: I think I can't eval-defer this. Otherwise, it won't be
        -- available when opening the first file. If so, remove this plug-in
        --
        -- event = { "VeryLazy" },
    },

    -- Show all file edits as an tree
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
    },

    -- Removes whitespace only on the lines you've changed. Pretty cool!
    {
        "lewis6991/spaceless.nvim",
        config = function()
            require("spaceless").setup()
        end,
        event = { "VeryLazy" },
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

    -- TODO: Consider adding this in the future
    -- {
    --     "Exafunction/codeium.vim",
    --     config = function ()
    --       -- Change "<C-g>" here to any keycode you like.
    --       vim.keymap.set(
    --           "i",
    --           "<C-g>",
    --           function()
    --               return vim.fn["codeium#Accept"]()
    --           end,
    --           { expr = true }
    --       )
    --       vim.keymap.set(
    --           "i",
    --           "<c-;>",
    --           function()
    --               return vim.fn["codeium#CycleCompletions"](1)
    --           end,
    --           { expr = true }
    --       )
    --       vim.keymap.set(
    --           "i",
    --           "<c-,>",
    --           function()
    --               return vim.fn["codeium#CycleCompletions"](-1)
    --           end,
    --           { expr = true }
    --       )
    --       vim.keymap.set(
    --           "i",
    --           "<c-x>",
    --           function()
    --               return vim.fn["codeium#Clear"]()
    --           end,
    --           { expr = true }
    --       )
    --     end
    -- }

    -- Use any 2-3 key combo to jump anywhere in a file.
    -- Basically Firefox's Vimium, but in Vim.
    --
    {
        "phaazon/hop.nvim",
        cmd = "HopWord",
        config = function()
            local hop = require('hop')
            local directions = require('hop.hint').HintDirection

            vim.keymap.set(
                "n",
                "<leader>f",
                function()
                    vim.cmd("HopWord")
                end,
                {desc="[f]ind text using hop-mode."}
            )

            require("hop").setup({keys= "asdfghjkl"})
        end,
        keys = "<leader>f",
    },

    -- Debug adapter plug-in. Debug anything in Neovim
    {
        "mfussenegger/nvim-dap",
        config = function()
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
                    require("dap").restart()
                end,
                {desc="Restart the current debug session."}
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
        lazy = true,
    },

    -- A default "GUI" front-end for nvim-dap
    {
        "rcarriga/nvim-dap-ui",
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
        end,
        keys = "<F5>",
        dependencies = {
            "mfussenegger/nvim-dap",

            "mfussenegger/nvim-dap-python",  -- Optional adapter for Python
        },
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
        end,
    }

    -- -- A tool for looking up stuff. That said, it's not that useful
    -- {
    --     "nvim-telescope/telescope.nvim",
    --     cmd = "Telescope",
    --     config = function()
    --         -- vim.api.nvim_create_autocmd(
    --         --     "FileType",
    --         --     {
    --         --         callback = function()
    --         --             vim.keymap.set(
    --         --                 "i",
    --         --                 "<ESC>",
    --         --                 "<ESC><ESC>",
    --         --                 {noremap=true}
    --         --             )
    --         --         end,
    --         --         pattern = "TelescopePrompt",
    --         --     }
    --         -- )
    --
    --         require('telescope').setup {
    --           extensions = {
    --             fzf = {
    --               fuzzy = true,                    -- false will only do exact matching
    --               override_generic_sorter = true,  -- override the generic sorter
    --               override_file_sorter = true,     -- override the file sorter
    --               case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    --                                                -- the default case_mode is "smart_case"
    --             }
    --           }
    --         }
    --         -- Reference: https://github.com/nvim-telescope/telescope-fzf-native.nvim#telescope-setup-and-configuration
    --         require("telescope").load_extension("fzf")
    --     end,
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "nvim-tree/nvim-web-devicons",
    --         -- "nvim-telescope/telescope-fzf-writer.nvim",
    --     },
    --     release = "0.1.*",
    -- },
    -- {
    --     "nvim-telescope/telescope-fzf-native.nvim",
    --     build = "make",
    --     lazy = true,
    -- },
}
