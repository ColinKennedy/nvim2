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
        cmd = { "SourceLocalVimrc", "SourceLocalVimrcOnce" },
    },

    -- Press * or # in Visual mode to start a search
    {
        "bronson/vim-visual-star-search",
        init = function()
            require("my_custom.utilities.utility").lazy_load("vim-visual-star-search")
        end,
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
    },
    {
        "kwkarlwang/bufresize.nvim",
        config = function()
            require("bufresize").setup()
        end,
        event = { "BufWinEnter", "VimResized", "WinEnter" },
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
    },

    -- Auto-read external file changes
    {
        "ColinKennedy/vim-file-system-watcher",
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
            vim.keymap.set("n", "<space>d", ":Neogen<CR>")
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
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
            local installation_directory = vim.g.vim_home .. "/parsers/" .. vim.loop.os_uname().sysname

            -- If you need to change the installation directory of the parsers (see
            -- "Advanced Setup" in the nvim-treesitter documentation).
            --
            vim.opt.runtimepath:append(installation_directory)


            local value = "V"

            require("nvim-treesitter.configs").setup {
                parser_install_dir = installation_directory,
                highlight = { enable = true },

                textobjects = {
                    -- TODO: Not working, fix
                    move = {
                      enable = true,
                      set_jumps = true, -- whether to set jumps in the jumplist
                      goto_next_start = {
                        ["]k"] = "@class.outer",
                        ["]m"] = "@function.outer",
                      },
                      goto_next_end = {
                        ["]K"] = "@class.outer",
                        ["]M"] = "@function.outer",
                      },
                      goto_previous_start = {
                        ["[k"] = "@class.outer",
                        ["[m"] = "@function.outer",
                      },
                      goto_previous_end = {
                        ["[K"] = "@class.outer",
                        ["[M"] = "@function.outer",
                      },
                    },

                    select = {
                        enable = true,

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                            ["ab"] = {
                                desc = "Delete the current if / for / try / while block.",
                                query = "@block.outer",
                            },

                            ["ad"] = {
                                desc = "Select around an entire docstring",
                                query = "@documentation.outer",
                            },
                            ["id"] = {
                                desc = "Select the inside of a docstring",
                                query = "@documentation.inner",
                            },

                            ["af"] = {
                                desc = "Select function + whitespace to the next function / class",
                                query = "@function.outer",
                            },
                            ["if"] = {
                                desc = "Select function up to last source code line (no trailing whitespace)",
                                query = "@function.inner",
                            },

                            ["ac"] = {
                                desc = "Select class + whitespace to the next class / class",
                                query = "@class.outer",
                            },
                            ["ic"] = {
                                desc = "Select class up to last source code line (no trailing whitespace)",
                                query = "@class.inner",
                            },
                          },
                        -- You can choose the select mode (default is charwise 'v')
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * method: eg 'v' or 'o'
                        -- and should return the mode ('v', 'V', or '<c-v>') or a table
                        -- mapping query_strings to modes.
                        selection_modes = {
                            ["@class.inner"] = value,
                            ["@class.outer"] = value,
                            ["@function.inner"] = value,
                            ["@function.outer"] = value,
                        },
                        -- If you set this to `true` (default is `false`) then any textobject is
                        -- extended to include preceding or succeeding whitespace. Succeeding
                        -- whitespace has priority in order to act similarly to eg the built-in
                        -- `ap`.
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * selection_mode: eg 'v'
                        -- and should return true of false
                        include_surrounding_whitespace = function(data)
                            local query = data["query_string"]
                            local mode = data["selection_mode"]

                            if query == "@function.outer" or query == "@class.outer" or query == "@documentation.outer"
                            then
                                return true
                            end

                            return false
                        end
                  },
                },
              }
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        }
    },
    -- Kickass class / function viewer
    {
        "stevearc/aerial.nvim",
        config = function()
            require("aerial").setup(
                {
                    highlight_on_jump = 100,  -- Shorten the blink time to be fast
                    nav = {
                        keymaps = {
                            ["q"] = "actions.close",
                        },
                    },
                }
            )

            vim.keymap.set("n", "<space>SS", ":AerialToggle<CR>")
            vim.keymap.set("n", "<space>SN", ":AerialNavToggle<CR>")
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

    -- TODO: Consider removing, later
    -- -- Debug basically any language
    -- --
    -- -- Reference: https://www.youtube.com/watch?v=AnTX2mtOl9Q
    -- --
    -- {
    --     "puremourning/vimspector",
    --     enabled = false,
    --     -- enabled = function()
    --     --     return vim.fn.has("python3") == 1
    --     -- end,
    --     config = function()
    --         vim.cmd[[
    --         function! GoToWindow(buffer_id)
    --             call win_gotoid(a:buffer_id)
    --
    --             ZoomWinTabToggle
    --         endfunction
    --         ]]
    --
    --         vim.keymap.set("n", "<leader>dd", ":call vimspector#Launch()<CR>")
    --         vim.keymap.set("n", "<leader>dc", ":call GoToWindow(g:vimspector_session_windows.code)<CR>")
    --         vim.keymap.set("n", "<leader>dt", ":call GoToWindow(g:vimspector_session_windows.tagpage)<CR>")
    --         -- nnoremap <leader>dtg :call GoToWindow(g:vimspector_session_windows.tagpage)<CR>
    --         -- nnoremap <leader>dtr :call GoToWindow(g:vimspector_session_windows.terminal)<CR>
    --         vim.keymap.set("n", "<leader>dv", ":call GoToWindow(g:vimspector_session_windows.variables)<CR>")
    --         vim.keymap.set("n", "<leader>dw", ":call GoToWindow(g:vimspector_session_windows.watches)<CR>")
    --         vim.keymap.set("n", "<leader>ds", ":call GoToWindow(g:vimspector_session_windows.stack_trace)<CR>")
    --         vim.keymap.set("n", "<leader>do", ":call GoToWindow(g:vimspector_session_windows.output)<CR>")
    --         vim.keymap.set("n", "<leader>de", ":call vimspector#Reset()<CR>")
    --         vim.keymap.set("n", "<leader>dtcb", ":call vimspector#CleanLineBreakpoint()<CR>")
    --
    --         vim.keymap.set("n", "<leader>dl", "<Plug>VimspectorStepInto")
    --         vim.keymap.set("n", "<leader>dj", "<Plug>VimspectorStepOver")
    --         vim.keymap.set("n", "<leader>dk", "<Plug>VimspectorStepOut")
    --         vim.keymap.set("n", "<leader>d_", "<Plug>VimspectorRestart")
    --
    --         vim.keymap.set("n", "<leader>d<space>", ":call vimspector#Continue()<CR>")
    --
    --         vim.keymap.set("n", "<leader>drc", "<Plug>VimspectorRunToCursor")
    --         vim.keymap.set("n", "<leader>dbp", "<Plug>VimspectorToggleBreakpoint")
    --         vim.keymap.set("n", "<leader>dcbp", "<Plug>VimspectorToggleConditionalBreakpoint")
    --     end
    -- },

    -- Create simple templates for Vim projects using a '.projections.json' sidecar file
    {
        "tpope/vim-projectionist",
        init = function()
            require("my_custom.utilities.utility").lazy_load("vim-projectionist")
        end,
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
        "KaraMCC/vim-gemini",
        enabled = function()
            return vim.v.version >= 800
        end,
    },

    -- Give vim some shell-like commands that it's missing
    {
        "tpope/vim-eunuch",
        cmd = { "Delete", "Mkdir", "Move", "Rename", "SudoEdit", "SudoWrite" }
    },

    -- REPEAT LAST (USER) COMMAND and makes the '.' command even cooler
    {
        "tpope/vim-repeat",
        keys = {"."},
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
        init = function()
            require("my_custom.utilities.utility").lazy_load("vim-sleuth")
        end,
    },

    -- Show all file edits as an tree
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
    },

    -- Removes whitespace only on the lines you've changed. Pretty cool!
    {
        "ColinKennedy/vim-strip-trailing-whitespace",
        cmd = "StripTrailingWhitespace",
        event = {"BufEnter", "BufWritePre"},  -- Don't remove these or the plugin won't work
    },

    -- Add a tree plug-in
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
            vim.keymap.set("n", "<space>W", ":PwdNvimTreeToggle<CR>")
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
}
