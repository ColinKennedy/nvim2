return {
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
        config = function()
            require("my_custom.plugins.treesj.configuration")
        end,
        cmd = { "TSJToggle" },
        keys = {
            {
                "<leader>sa",
                "TSJToggle",
                desc = "Toggle (Join or split) [s]plit [a]rguments at the cursor."
            },
        },
    },

    -- A plugin that is able to load project-specific .vimrc files
    -- It's like [krisajenkins/vim-projectlocal](http://github.com/krisajenkins/vim-projectlocal) but it's not broken(!)
    --
    -- It can even differentiate between .vimrc files you've authored and others
    -- which may contain malicious code
    --
    {
        "ColinKennedy/vim-addon-local-vimrc",
        branch = "my_edits",
        config = function()
            vim.g.local_vimrc = {
                cache_file = vim.fn.expand("~/.vim_local_rc_cache"),
                hash_fun = "LVRHashOfFile",
                implementations = {"sha512sum", "sha256sum", "sha1sum", "md5sum", "viml"},
                names = {".vimrc",'.vimrc.lua'},
                resource_on_cwd_change = true,
            }
        end,
    },

    -- Swap windows using <C-h>, <C-j>, <C-k>, <C-l> keys and to/from tmux
    {
        "mrjones2014/smart-splits.nvim",
        config = function() require("my_custom.plugins.smart_splits.configuration") end,
        dependencies = { "kwkarlwang/bufresize.nvim" },
        keys = {
            { "<C-h>", desc = "Move cursor to the left window (or tmux)." },
            { "<C-j>", desc = "Move cursor to the below window (or tmux)." },
            { "<C-k>", desc = "Move cursor to the above window (or tmux)." },
            { "<C-l>", desc = "Move cursor to the right window (or tmux)." },
        },
        version = "1.*",
    },

    -- When resizing your terminal, this plug-in keeps all buffer width/height
    -- proportionally the same.
    --
    {
        "kwkarlwang/bufresize.nvim",
        config = true,
        event = { "VeryLazy" },
    },

    -- TODO: If I lazy-load this plug-in, it forces the cursor to the top of
    -- the file. No idea why. Check that out, later Auto-read external file
    -- changes.
    --
    {
        "ColinKennedy/vim-file-system-watcher",
        -- event = { "VeryLazy" },
    },

    -- Auto-generate docstrings, using ``<leader>id``
    {
        "ColinKennedy/neogen",
        branch = "combined_branch",
        config = function() require("my_custom.plugins.neogen.configuration") end,
        cmd = { "Neogen" },
        dependencies = {
            "L3MON4D3/LuaSnip",
            "nvim-treesitter/nvim-treesitter"
        },
        keys = {
            { "<leader>id", desc = "[i]nsert [d]ocstring at the current cursor." }
        },
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
        config = function() require("my_custom.plugins.nvim_treesitter.configuration") end,
        lazy = true,
        -- TODO: Re-add this once tree-sitter-disassembly is incorporated
        -- version = "0.*",
    },

    -- TODO: Possibly remove this submodule
    --
    -- Very unfortunately needed because indentation via treesitter has bugs.
    --
    -- Reference: https://github.com/nvim-treesitter/nvim-treesitter/issues/1136
    --
    {
        "Vimjas/vim-python-pep8-indent",
        ft = "python",
    },

    {
        "ColinKennedy/nvim-treesitter-textobjects",
        branch = "modified_include_surrounding_whitespace_behavior",
        config = function()
            require("my_custom.plugins.nvim_treesitter_textobjects.configuration")
        end,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        keys = {
            "[k", "]k",
            "[m", "]m",
            "[K", "]K",
            "[M", "]M",

            "daC",
            "dad",
            "daf",
            "diC",
            "did",

            "vaC",
            "vad",
            "vaf",
            "viC",
            "vid",
            "vif",
        },
    },

    -- Kickass class / function viewer
    {
        "stevearc/aerial.nvim",
        config = function() require("my_custom.plugins.aerial.configuration") end,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        cmd = { "AerialNavToggle", "AerialToggle"},
        keys = require("my_custom.plugins.aerial.keys"),
        -- version = "stable",  -- Note: The latest is probably safe. The maintainer's good
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

    -- Auto-saves changes to a git repository. Use `:Telescope file_history
    -- history2` to show the commit history of the current file.
    --
    {
        "ColinKennedy/telescope-file-history.nvim",
        branch = "add_multi_commit_support",
        config = function()
            require("file_history").setup { backup_dir = "~/.vim_custom_backups" }
            require("telescope").load_extension("file_history")
        end,
        dependencies = { "nvim-telescope/telescope.nvim" },
        keys = {
            {
                "<space>GF",
                ":Telescope file_history log<CR>",
                desc="Show [G]it [F]ile History.",
            },
        },
    },

    -- Useful git commands. Such as :Gcd
    {
        "tpope/vim-fugitive",
        cmd = { "G", "Gcd", "Gdiffsplit", "Git", "Gvdiffsplit" },
        keys = require("my_custom.plugins.vim_fugitive.keys"),
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
        config = true,
        event = { "InsertEnter" },
    },

    -- A tree file/directory viewer plug-in
    {
        "nvim-tree/nvim-tree.lua",
        config = function() require("my_custom.plugins.nvim_tree.configuration") end,
        -- cmd = { "PwdNvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen", "NvimTreeToggle" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            {
                "<space>W",
                ":PwdNvimTreeToggle<CR>",
                desc="Open NvimTree starting from the `:pwd`.",
            },
        },
    },

    -- Seamlessly switch between a binary file view and a hexdump-ish view and back
    -- It's a fancy plug-in that replaces ``:h hex-editing``
    --
    -- Reference: https://vi.stackexchange.com/a/2237/16073
    --
    {
        "RaafatTurki/hex.nvim",
        config = true,
        cmd = "HexToggle",
    },

    -- A pop-up that shows you available Neovim keymaps. Only pops up if you're slow
    {
        "folke/which-key.nvim",
        config = function() require("my_custom.plugins.which_key.configuration") end,
        keys = {
            { "<Space>", desc = "The space switcher key." },
            { "<leader>", desc = "The custom mapping location." }
        },
        version = "stable",
    },

    -- -- An async "parameter highlights" plugin that uses tree-sitter.
    -- -- It works without LSP on any of its supported languages.
    -- --
    -- {
    --     "m-demare/hlargs.nvim",
    --     config = function()
    --         require('hlargs').setup()
    --
    --         -- Reference: https://github.com/m-demare/hlargs.nvim/blob/07e33afafd9d32b304a8557bfc1772516c005d75/doc/hlargs.txt#L306
    --         vim.api.nvim_create_augroup("LspAttach_hlargs", {clear = true})
    --         vim.api.nvim_create_autocmd("LspAttach", {
    --             group = "LspAttach_hlargs",
    --             callback = function(args)
    --                 if not (args.data and args.data.client_id) then
    --                     return
    --                 end
    --
    --                 for _, client in ipairs(vim.lsp.get_active_clients())
    --                 do
    --                     local caps = client.server_capabilities
    --
    --                     if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
    --                         require("hlargs").disable_buf(args.buf)
    --
    --                         break
    --                     end
    --                 end
    --             end,
    --         })
    --     end,
    --     event = { "VeryLazy" },
    -- },


    -- A plugin that quickly makes and deletes Terminal buffers.
    {
        "ColinKennedy/toggleterminal.nvim",
        branch = "first_pass",  -- TODO: Remove later
        cmd = "ToggleTerm",
        config = true,
        keys = {
            {
                "<Space>T",
                ":ToggleTerminl direction=horizontal<CR>",
                desc="Create a [T]erminal on the bottom of the current window.",
                silent=true,
            },
        },
    },

    -- Add "submodes" to Neovim. e.g. <Space>G for "git mode"
    {
        "nvimtools/hydra.nvim",
        config = function() require("my_custom.plugins.hydra.configuration") end,
        keys = {
            { "<Space>D", desc = "[D]ebugging mode" },
            { "<Space>GD", desc = "[G]it [D]iff mode (basically a sort of git add -p mode)" },
            { "<Space>GG", desc = "[G]it [G]eneral mode" },
        },
        -- TODO: Re-add this once there's a version that contains LICENSE
        -- version = "v1.*",
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
        end,
        dependencies = { "neovim/nvim-lspconfig" },
        cmd = "SymbolsOutline",
        keys = {
            {
                "<Space>SO",
                ":SymbolsOutline<CR>",
                desc = "Open [S]ymbols [O]utliner",
                silent = true,
            },
        },
    },

    -- Search with :Rg
    -- :Rg -t vim foo (searches "foo" for vim files)
    -- :Rg -t vim foo /somewhere (searches "foo" for vim files in the /somewhere directory)
    -- :Rg (triggers an interactive prompt for a search)
    --
    {
        "duane9/nvim-rg",
        cmd = "Rg",
        keys = {
            { "<leader>rg", ":Rg", desc = "Search :pwd with [rg] - ripgrep." },
        }
    },

    -- Cool Neovim mark displays and mappings. e.g. `dmx` deletes mark x. m[ / m] to move
    -- Reference: https://github.com/chentoast/marks.nvim#mappings
    --
    {
        "chentoast/marks.nvim",
        config = true,
        event = "VeryLazy",
    },

    -- Use `:GH` or `:GB` to open the lines in your webbrowser
    -- (GH = lines, GB = git blame)
    --
    {
        "ruanyl/vim-gh-line",
        cmd = { "GB", "GBInteractive", "GH", "GHInteractive" },
    },

    -- Insert debug print statements easily.
    {
        "andrewferrier/debugprint.nvim",
        config = function()
            require("debugprint").setup(
                { create_keymaps = false, create_commands = false }
            )
        end,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        keys = {
            {
                "<leader>iV",
                function()
                    -- Note: setting `expr=true` and returning the value are essential
                    return require("debugprint").debugprint({ above = true, variable = true })
                end,
                desc = "[i]nsert [V]ariable debug-print above the current line",
                expr = true,
                mode = {"n", "v"},
            },
            {
                "<leader>iv",
                function()
                    -- Note: setting `expr=true` and returning the value are essential
                    return require("debugprint").debugprint({ above = false, variable = true })
                end,
                desc = "[i]nsert [v]ariable debug-print below the current line",
                expr = true,
                mode = {"n", "v"},
            },
        },
        version = "1.*",
    },

    -- Generic tool for picking stuff.
    --
    -- Favorites:
    -- :Telescope git_stash -- browse and apply past git stashes
    -- :Telescope marks -- browse and apply past git stashes
    --
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.*",
        cmd = "Telescope",
        config = function() require("my_custom.plugins.telescope.configuration") end,
        dependencies = {"ColinKennedy/plenary.nvim"},
    },

    -- Use <leader>cii to increment semver / dates
    -- Use <leader>cid to decrement semver / dates
    --
    {
        "monaqa/dial.nvim",
        config = function() require("my_custom.plugins.dial.configuration") end,
        keys = require("my_custom.plugins.dial.keys"),
        version = "0.*",
    },

    -- Use :DiffviewOpen to resolve git merge conflicts
    {
        "ColinKennedy/diffview.nvim",
        cmd = {"DiffviewOpen"},
    },

    -- Extend Vim's :mksession. Auto-save and restore those sessions
    --
    -- I primarily use this along with
    -- https://github.com/tmux-plugins/tmux-resurrect so that I don't lose
    -- work.
    --
    { "tpope/vim-obsession" },

    -- Allow `gf` to work in unifided diff (.diff) files.
    {
        "ColinKennedy/vim-gf-diff",
        branch = "add_absolute_path_buffer_option",
        dependencies = { "kana/vim-gf-user" },
        keys = {
            {
                "gf",
                "<Plug>(gf-user-gf)",
                desc = "[g]o-to [f]ile.",
            }
        }
    },
    {
        "kana/vim-gf-user",
        version = "1.*",
    },

    -- Add extra queries for RST to make it better suited for Python / Sphinx
    {
        "stsewd/sphinx.nvim",
        ft = {
            "python",  -- I have RST injected into Python files to include it here
            "rst",
        },
    },

    -- Show / Hide a location list or quickfix
    {
        "ColinKennedy/ListToggle",
        branch = "make_height_optional",
        config = function() vim.g.lt_height = 0 end,
        cmd = { "LToggle", "QToggle" },
        keys = {
            { "<leader>l", desc = "Toggle the [l]ocation list display." },
            { "<leader>q", desc = "Toggle the [q]uickfix display." },
        },
    },

    -- Run unittests in a simple GUI. It has auto-watch capabilities and more!
    {
        "ColinKennedy/neotest",
        branch = "fixed_deprecation_notice",
        config = require("my_custom.plugins.neotest.configuration"),
        cmd = {
            "Neotest",
            "NeotestRunCurrent",
            "NeotestRunDirectory",
            "NeotestRunFile",
            "NeotestRunSuite",
            "NeotestRunSuite",
        },
        dependencies = {
            -- Required
            "ColinKennedy/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/nvim-nio",
            "nvim-treesitter/nvim-treesitter",

            -- Optional
            "nvim-neotest/neotest-plenary",
            "nvim-neotest/neotest-python",
        },
        keys = require("my_custom.plugins.neotest.keys"),
    },

    -- View / Switch-to previously saved Vim Session.vim files
    {
        "ColinKennedy/telescope-session-viewer",
        config = function()
            require("telescope-session-viewer").setup()
            require("telescope").load_extension("session_viewer")
        end,
        dependencies = { "nvim-telescope/telescope.nvim"},
        event = {"SessionWritePost"},
        keys = {
            {
                "<Space>SV",
                ":Telescope session_viewer view<CR>",
                desc = "Open the Vim [S]ession [V]iewer GUI.",
            }
        },
    }
}
