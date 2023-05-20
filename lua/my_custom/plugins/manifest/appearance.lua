return {
    {
        "ColinKennedy/hybrid2.nvim",
        priority = 1000,  -- Load this first
        config = function()
            vim.cmd.colorscheme("hybrid2")

            -- Show namespaces as a separate color
            -- TODO: Get this color automatically
            vim.api.nvim_set_hl(0, "@namespace", {fg="#707880", ctermfg=243})

            -- Show trailing whitespace as red text
            -- TODO: Get this color automatically
            vim.api.nvim_set_hl(0, "NonText", {bg="#5f0000", ctermbg=52})
        end,
        version = "1.*"
    },

    {
        "romainl/vim-cool",
        event = "VeryLazy",
    },

    -- TODO: Make this prettier. Like how NvChad works
    -- Shows added, removed, etc git hunks
    {
        "lewis6991/gitsigns.nvim",
        ft = "gitcommit",
        init = function()
            -- load gitsigns only when a git file is opened
            vim.api.nvim_create_autocmd(
                { "BufRead" },
                {
                    group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
                    callback = function()
                        vim.fn.system("git -C " .. vim.fn.expand "%:p:h" .. " rev-parse")
                        if vim.v.shell_error == 0 then
                            vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
                            vim.schedule(function()
                                require("lazy").load { plugins = { "gitsigns.nvim" } }
                            end)
                        end
                    end
                }
            )
        end,
        opts = {
            signs = {
                add = { text = "│" },
                change = { text = "╵" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "x" },
                untracked = { text = "" },
            },
        }
    },

    -- TODO: Add this later
    --
    -- A plugin that adds Prim type names to USD auto-complete results
    -- Plug 'https://korinkite@bitbucket.org/korinkite/vim-usd-complete-schemas.git'

    -- Add a quick status bar plugin
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("lualine").setup {
              options = {
                icons_enabled = true,
                theme = "onedark",
                section_separators = { left = "", right = ""},
                component_separators = { left = '', right = ''},
              },
              sections = {
                lualine_b = {"branch"},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {"diagnostics", "progress"},
                lualine_z = {"location"}
              },
            }
        end,
        event = "VeryLazy",
    },

    -- Extra, optional icons for ``nvim-lualine/lualine.nvim``
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            local _suggest_a_color = function(highlight_group)
                local data = vim.api.nvim_get_hl_by_name(highlight_group, true)
                local foreground = data["foreground"]

                if foreground ~= nil
                then
                    return foreground
                end

                return data["background"] or ""
            end

            local get_best_hex = function(highlight_group)
                local color = _suggest_a_color(highlight_group)

                if color ~= ""
                then
                    return string.format("#%06x", color)
                end

                return "#428850"
            end

            require("nvim-web-devicons").set_icon {
                dapui_breakpoints = {
                    icon = "",
                    color = get_best_hex("Question"),
                    -- cterm_color = "65",
                    name = "dapui_breakpoints"
                },
                dapui_console = {
                    icon = "",
                    color = get_best_hex("Comment"),
                    -- cterm_color = "65",
                    name = "dapui_console"
                },
                ["dap-repl"] = {  -- By default, it is shown as bright white
                    icon = "󱜽",
                    -- cterm_color = "65",
                    name = "dap_repl"
                },
                dapui_scopes = {
                    icon = "󰓾",
                    color = get_best_hex("Function"),
                    -- cterm_color = "40",
                    name = "dapui_scopes"
                },
                dapui_stacks = {
                    icon = "",
                    color = get_best_hex("Directory"),
                    -- cterm_color = "65",
                    name = "dapui_stacks"
                },
                dapui_watches = {
                    icon = "󰂥",
                    color = get_best_hex("Constant"),
                    -- cterm_color = "65",
                    name = "dapui_watches"
                },
            }
        end,
        lazy = true,
    },

    -- Enhanced markdown highlighting and syntax
    {
        "tpope/vim-markdown",
        ft = "markdown",
        config = function()
            vim.g.markdown_fenced_languages = {
                "bash=sh",
                "cpp",
                "js=javascript",
                "json",
                "lua",
                "php",
                "python",
                "sql",
                -- "usd=usda",  -- TODO: Add this, later
                -- "usda",  -- TODO: Add this, later
                "yaml",
            }
        end,
    },

    -- Show the current context at the top of the Vim window
    --
    -- Somewhat unrelated but a useful reference:
    --     https://github.com/ray-x/nvim/blob/c501ff52438d77652f529d13bea55b799850d8a7/lua/modules/ui/winbar.lua
    --
    {
        "ColinKennedy/winbar.nvim",
        config = function()
            require("winbar").setup(
                {
                    enabled = true,

                    show_file_path = true,
                    show_symbols = true,

                    colors = {
                        path = "", -- You can customize colors like #c946fd
                        file_name = "",
                        symbols = "",
                    },

                    icons = {
                        file_icon_default = "",
                        seperator = ">",
                        editor_state = "●",
                        lock_icon = "",
                    },

                    exclude_filetype = {
                        -- Built-in windows
                        "qf",
                        "help",

                        "",  -- Neovim terminals have no filetype. Disable terminals.
                        "NvimTree",  -- nvim-tree/nvim-tree.lua

                        -- Extras
                        "Outline",
                        "Trouble",
                        "alpha",
                        "dashboard",
                        "lir",
                        "neogitstatus",
                        "packer",
                        "spectre_panel",
                        "startify",
                        "toggleterm",

                    }
                }
            )
        end,
        dependencies = {"Lazytangent/nvim-gps", "nvim-tree/nvim-web-devicons"},
        event = "VeryLazy",
    },

    -- Use treesitter to show your current cursor context (class > function > etc)
    {
        "Lazytangent/nvim-gps",
        config = function()
            require("nvim-gps").setup()
        end,
        dependencies = {"nvim-treesitter/nvim-treesitter"},
        lazy = true,
    },

    -- Overrides Vim's default Command mode and provides "wild card" results
    -- + icons. Mostly cosmetic and isn't "necessary", but it is a fun little
    -- plug-in as long as it's harmless.
    --
    {
        "gelguy/wilder.nvim",
        config = function()
            local wilder = require("wilder")

            wilder.setup({modes = {":", "/", "?"}})

            -- Disable Python remote plugin
            wilder.set_option("use_python_remote_plugin", 0)

            wilder.set_option(
                "pipeline",
                {
                    wilder.branch(
                        wilder.cmdline_pipeline(
                            {
                                fuzzy = 1,
                                fuzzy_filter = wilder.lua_fzy_filter(),
                            }
                        ),
                        wilder.vim_search_pipeline()
                    )
                }
            )

            local gradient = {
              "#f4468f", "#fd4a85", "#ff507a", "#ff566f", "#ff5e63",
              "#ff6658", "#ff704e", "#ff7a45", "#ff843d", "#ff9036",
              "#f89b31", "#efa72f", "#e6b32e", "#dcbe30", "#d2c934",
              "#c8d43a", "#bfde43", "#b6e84e", "#aff05b"
            }

            for i, fg in ipairs(gradient) do
              gradient[i] = wilder.make_hl("WilderGradient" .. i, "Pmenu", {{a = 1}, {a = 1}, {foreground = fg}})
            end

            wilder.set_option(
                "renderer",
                wilder.renderer_mux(
                    {
                        [":"] = wilder.popupmenu_renderer(
                            wilder.popupmenu_border_theme(
                                {
                                    border = "rounded",
                                    highlights = {
                                        default = wilder.make_hl("WilderPmenu", "Normal"),
                                        border = "Normal", -- highlight to use for the border
                                        gradient = gradient,
                                    },
                                    highlighter = wilder.highlighter_with_gradient(
                                        { wilder.lua_fzy_highlighter() }
                                    ),
                                    left = { " ", wilder.popupmenu_devicons() },
                                    right = { " ", wilder.popupmenu_scrollbar() },
                                }
                            )
                        ),
                    }
                )
            )
        end,
        dependencies = {"romgrk/fzy-lua-native"},
        -- Reference: https://github.com/gelguy/wilder.nvim#faster-startup-time
        event = "CmdlineEnter",
    }
}
