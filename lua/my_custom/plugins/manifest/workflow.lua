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
        cmd = { "ArgWrap" },
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
                desc = "Toggle (Join or split) [s]plit [a]rguments at the cursor.",
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
                implementations = { "sha512sum", "sha256sum", "sha1sum", "md5sum", "viml" },
                names = { ".vimrc", ".vimrc.lua" },
                resource_on_cwd_change = true,
            }
        end,
    },

    -- Swap windows using <C-h>, <C-j>, <C-k>, <C-l> keys and to/from tmux
    {
        "mrjones2014/smart-splits.nvim",
        config = function()
            require("my_custom.plugins.smart_splits.configuration")
        end,
        dependencies = { "kwkarlwang/bufresize.nvim" },
        keys = {
            { "<A-h>", desc = "Enlarge (left) the current window." },
            { "<A-j>", desc = "Enlarge (down) the current window." },
            { "<A-k>", desc = "Enlarge (up) the current window." },
            { "<A-l>", desc = "Enlarge (right) the current window." },
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
        branch = "combined_branch_003",
        config = function()
            require("my_custom.plugins.neogen.configuration")
        end,
        cmd = { "Neogen" },
        dependencies = {
            "L3MON4D3/LuaSnip",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            { "<leader>id", desc = "[i]nsert [d]ocstring at the current cursor." },
        },
        version = "*", -- Only follow the latest stable release
    },

    {
        -- Useful from the documentation:
        --
        --     A parser can also be loaded manually using a full path: >
        --         vim.treesitter.require_language("python", "/path/to/python.so")
        --
        -- NOTE: Don't lazy-load nvim-treesitter or docstring folds in Python will break
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("my_custom.plugins.nvim_treesitter.configuration")
        end,
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
            -- Next class
            "[k",
            "]k",
            -- Next function / method
            "[m",
            "]m",
            -- Next class
            "[K",
            "]K",
            -- Next function / method
            "[M",
            "]M",

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
        config = function()
            require("my_custom.plugins.aerial.configuration")
        end,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        cmd = { "AerialNavToggle", "AerialToggle" },
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
            vim.cmd [[:doautoall create_gemini_mappings BufEnter]]
        end,
        event = "VeryLazy", -- Or maybe InsertEnter
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
                "<cmd>Telescope file_history log<CR>",
                desc = "Show [G]it [F]ile History.",
            },
        },
    },

    -- Useful git commands. Such as :Gcd
    {
        "tpope/vim-fugitive",
        cmd = { "G", "Gcd", "Gdiffsplit", "Git", "Gvdiffsplit" },
        config = function()
            vim.api.nvim_create_autocmd("User", {
                callback = function()
                    local function _is_diff_related()
                        local line = 1 -- Vim buffer line
                        local text = vim.fn.getline(line)

                        return text:find("^diff ")
                    end

                    if _is_diff_related() then
                        vim.schedule(function()
                            vim.treesitter.start(0, "diff")
                        end)
                    end
                end,
                pattern = "FugitivePager",
            })
        end,
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
        config = function()
            require("my_custom.plugins.nvim_tree.configuration")
        end,
        -- cmd = { "PwdNvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen", "NvimTreeToggle" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            {
                "<space>W",
                "<cmd>PwdNvimTreeToggle<CR>",
                desc = "Open NvimTree starting from the `:pwd`.",
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
        config = function()
            require("my_custom.plugins.which_key.configuration")
        end,
        version = "v3.*",
    },

    -- -- An async "parameter highlights" plugin that uses tree-sitter.
    -- -- It works without LSP on any of its supported languages.
    -- --
    -- {
    --     "m-demare/hlargs.nvim",
    --     config = function()
    --         require('hlargs').setup()
    --
    --         luacheck: ignore 631
    --         -- Reference: https://github.com/m-demare/hlargs.nvim/blob/07e33afafd9d32b304a8557bfc1772516c005d75/doc/hlargs.txt#L306
    --         vim.api.nvim_create_augroup("LspAttach_hlargs", {clear = true})
    --         vim.api.nvim_create_autocmd("LspAttach", {
    --             group = "LspAttach_hlargs",
    --             callback = function(args)
    --                 if not (args.data and args.data.client_id) then
    --                     return
    --                 end
    --
    --                 for _, client in ipairs(vim.lsp.get_clients())
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
        branch = "first_pass",
        cmd = "ToggleTerm",
        config = true,
        keys = {
            {
                "<Space>T",
                "<cmd>ToggleTerminal<CR>",
                desc = "Open / Close a terminal at the bottom of the tab",
                silent = true,
            },
        },
    },

    -- Add "submodes" to Neovim. e.g. <Space>G for "git mode"
    {
        -- TODO: Replace with nvimtools/hydra.nvim later, after they support Neovim nightly again.
        --
        -- Reference: https://github.com/nvimtools/hydra.nvim/pull/47
        -- Reference: https://github.com/cathyprime/hydra.nvim/commits/main
        --
        "cathyprime/hydra.nvim",
        config = function()
            require("my_custom.plugins.hydra.configuration")
        end,
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
                "<cmd>SymbolsOutline<CR>",
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
            { "<leader>rg", "<cmd>Rg<CR>", desc = "Search :pwd with [rg] - ripgrep." },
        },
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
        cmd = { "DeleteDebugPrints", "ToggleCommentDebugPrints" },
        config = function()
            require("debugprint").setup({})
        end,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        keys = {
            {
                "<leader>iV",
                function()
                    -- Note: setting `expr=true` and returning the value are essential
                    return require("debugprint").debugprint({
                        above = true,
                        variable = true,
                        ignore_treesitter = false,
                    })
                end,
                desc = "[i]nsert [V]ariable debug-print above the current line",
                expr = true,
                mode = { "n", "v" },
            },
            {
                "<leader>iv",
                function()
                    -- Note: setting `expr=true` and returning the value are essential
                    return require("debugprint").debugprint({
                        above = false,
                        variable = true,
                        ignore_treesitter = false,
                    })
                end,
                desc = "[i]nsert [v]ariable debug-print below the current line",
                expr = true,
                mode = { "n", "v" },
            },
        },
        version = "3.*",
    },

    -- Generic tool for picking stuff.
    --
    -- Favorites:
    -- :Telescope git_stash -- browse and apply past git stashes
    -- :Telescope marks -- browse and apply past git stashes
    --
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        config = function()
            require("my_custom.plugins.telescope.configuration")

            require("telescope").load_extension("plugin_template")
        end,
        dependencies = {
            "ColinKennedy/nvim-best-practices-plugin-template",
            "ColinKennedy/plenary.nvim",
        },
        version = "0.1.*",
    },

    -- Use <leader>cii to increment semver / dates
    -- Use <leader>cid to decrement semver / dates
    --
    {
        "monaqa/dial.nvim",
        config = function()
            require("my_custom.plugins.dial.configuration")
        end,
        keys = require("my_custom.plugins.dial.keys"),
        version = "0.*",
    },

    -- Use :DiffviewOpen to resolve git merge conflicts
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen" },
    },

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
            },
        },
    },
    {
        "kana/vim-gf-user",
        version = "1.*",
    },

    -- Add extra queries for RST to make it better suited for Python / Sphinx
    {
        "stsewd/sphinx.nvim",
        ft = {
            "python", -- I have RST injected into Python files to include it here
            "rst",
        },
    },

    -- Run unittests in a simple GUI. It has auto-watch capabilities and more!
    {
        "nvim-neotest/neotest",
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
            "HiPhish/neotest-busted",
            "nvim-neotest/neotest-plenary",
            "nvim-neotest/neotest-python",
        },
        keys = require("my_custom.plugins.neotest.keys"),
        version = "5.*",
    },

    -- Extract / Inline variables and functions
    {
        "ThePrimeagen/refactoring.nvim",
        config = true,
        dependencies = {
            "ColinKennedy/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            {
                mode = { "n", "x" },
                "<leader>rif",
                function()
                    require("refactoring").refactor("Inline Function")
                end,
                desc = "[r]efactor - [i]nline the [f]unction",
            },
            {
                mode = { "x" },
                "<leader>rxf",
                function()
                    require("refactoring").refactor("Extract Function")
                end,
                desc = "[r]efactor - e[x]tract into a [f]unction",
            },
            {
                mode = { "n", "x" },
                "<leader>riv",
                function()
                    require("refactoring").refactor("Inline Variable")
                end,
                desc = "[r]efactor - [i]nline the [v]ariable",
            },
            {
                mode = { "n", "x" },
                "<leader>rxv",
                function()
                    require("refactoring").refactor("Extract Variable")
                end,
                desc = "[r]efactor - e[x]tract into a [v]ariable",
            },
        },
    },

    {
        "ColinKennedy/spellbound.nvim",
        cmd = { "Spellbound" },
        config = function()
            local dictionary = "en-strict"

            require("spellbound").setup {
                profiles = {
                    strict = {
                        dictionaries = {
                            name = "en-strict",
                            input_paths = function()
                                local pattern = vim.fs.joinpath(vim.g.vim_home, "spell", "parts", "*")

                                return vim.fn.glob(pattern, true, false)
                            end,
                            output_path = vim.fs.joinpath(vim.g.vim_home, "spell", "en-strict.dic"),
                        },
                        spellfile = {
                            operation = "append",
                            text = function()
                                return "file:" .. vim.fs.joinpath(vim.g.vim_home, "spell", dictionary .. ".utf-8.add")
                            end,
                        },
                        spelllang = { operation = "replace", text = dictionary .. ",cjk" },
                        spellsuggest = {
                            operation = "replace",
                            text = function()
                                return "file:" .. vim.fs.joinpath(vim.g.vim_home, "spell", "strict_thesaurus.txt")
                            end,
                        },
                    },
                },
            }
        end,
        keys = {
            {
                "[r",
                "<Plug>(SpellboundGoToPreviousRecommendation)",
                desc = "Go to the previous recommendation.",
            },
            {
                "]r",
                "<Plug>(SpellboundGoToNextRecommendation)",
                desc = "Go to the next recommendation.",
            },
            {
                "<leader>tss",
                "<cmd>Spellbound toggle-profile strict<CR>",
                desc = "[t]oggle all [s]trict [s]pelling mistakes.",
            },
        },
    },

    -- View / Switch-to previously saved Vim Session.vim files
    {
        "ColinKennedy/telescope-session-viewer",
        config = function()
            require("telescope-session-viewer").setup()
            require("telescope").load_extension("session_viewer")
        end,
        dependencies = { "nvim-telescope/telescope.nvim" },
        event = { "SessionWritePost" },
        keys = {
            {
                "<Space>SV",
                "<cmd>Telescope session_viewer view<CR>",
                desc = "Open the Vim [S]ession [V]iewer GUI.",
            },
        },
    },

    -- Auto-backup your code to-disk whenever you save a file. And view its contents.
    {
        "ColinKennedy/timeline.nvim",
        branch = "first_pass",
        config = true,
        opts = {
            records = {
                file_save = {
                    extras = {
                        message = function(data)
                            return require("timeline.api.git").get_default_file_save_message(data)
                        end,
                    },
                },
            },
        },
        -- cmd = {"TimelineOpenCurrent", "TimelineOpenWindow"}
    },
}
