return {
    packages = {
        -- Lightweight CMake command - limited project structure knowledge
        {
            "ColinKennedy/vim-cmake",
            cmd = {
                "CMake",
                "CMakeClean",
                "CMakeFindBuildDir",
            },
            config = function()
                -- Always generate a compile_commands.json file
                vim.g.cmake_export_compile_commands = 1
                vim.g.cmake_executable = "cmake3"
            end,
        },

        {
            -- Async Make + awesome quick-fix window error reporting
            "ColinKennedy/vim-dispatch",
            cmd = {
                "Dispatch",
                "Make",
            },
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
            cmd = {
                "SourceLocalVimrc",
                "SourceLocalVimrcOnce",
            },
        },

        -- Press * or # in Visual mode to start a search
        {
            "bronson/vim-visual-star-search",
            event = { "CursorMoved", "CursorMovedI" },
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

        {
            "mrjones2014/smart-splits.nvim",
            config = function()
                require('smart-splits').setup(
                    {
                        resize_mode = {
                            hooks = {
                                on_leave = require('bufresize').register,
                            },
                        },
                    }
                )
            end,
            dependencies = { "kwkarlwang/bufresize.nvim" },
            event = { "CursorMoved", "CursorMovedI" },
        },
        {
            "kwkarlwang/bufresize.nvim",
            config = function()
                require("bufresize").setup()
            end,
            event = { "CursorMoved", "CursorMovedI" },
        },

        -- TODO: Consider adding this again
        -- -- Read a .egg (a Python zip file) as if it's a regular file
        -- {
        --     "ColinKennedy/vim-egg-read",
        -- }

        -- Press <C-w>o to full-screen the current buffer
        {
            "troydm/zoomwintab.vim",
            cmd = {
                "ZoomWinTabIn",
                "ZoomWinTabOut",
                "ZoomWinTabToggle",
            },
        },

        -- TODO: Not sure if this is still needed
        -- -- Auto-read external file changes
        -- {
        --     "ColinKennedy/vim-file-system-watcher",
        -- },
        --

        {
            "kkoomen/vim-doge",
            build = function()
                vim.cmd[[call doge#install()]]
            end,
            config = function()
                vim.g.doge_doc_standard_python = "google"
            end,
            tag = 'v2.2.9',
        },

        -- Debug basically any language
        --
        -- Reference: https://www.youtube.com/watch?v=AnTX2mtOl9Q
        --
        {
            "puremourning/vimspector",
            enabled = false,
            -- enabled = function()
            --     return vim.fn.has("python3") == 1
            -- end,
        },

        -- Create simple templates for Vim projects using a '.projections.json' sidecar file
        {
            "tpope/vim-projectionist",
            event = { "CursorMoved", "CursorMovedI" },
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
            config = function()
                vim.cmd("let g:gemini#match_list = {'.*': [['(', ')'], ['{', '}'], ['[', ']'], ['`', '`']], '.usda': [['@', '@']]}")
            end,
        },

        -- Give vim some shell-like commands that it's missing
        {
            "tpope/vim-eunuch",
            cmd = {
                "Delete",
                "Mkdir",
                "Move",
                "Rename",
                "SudoEdit",
                "SudoWrite",
            }
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
            event = { "CursorMoved", "CursorMovedI" },
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
        },
    }
}
