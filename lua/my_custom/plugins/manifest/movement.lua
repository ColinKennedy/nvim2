return {
    -- Zoxide auto-jump, but for Vim
    { "nanotee/zoxide.vim", cmd = { "Z" } },

    {
        "junegunn/fzf",
        build=function()
            vim.cmd[[call fzf#install()]]
        end,
        lazy = true,
        version = "0.*",
    },

    -- Integrate FZF into Neovim
    {
        "ibhagwan/fzf-lua",
        cmd = { "Commands", "FzfLua", "GFiles", "Helptags", "History" },
        config = function()
            require("fzf-lua").setup{
                previewers = { builtin = { syntax_delay = 200 } },
                winopts = {
                    height = 0.95,
                    width = 0.95,
                    preview = {
                        vertical       = 'up:45%',
                        layout = "vertical",
                    },
                },
            }

            vim.api.nvim_create_user_command(
                "Commands",
                function() require("fzf-lua").commands() end,
                { desc = "Show all available Commands." }
            )

            vim.api.nvim_create_user_command(
                "GFiles",
                function() require("fzf-lua").git_files() end,
                { desc = "Find and [e]dit a file in the git repository." }
            )

            vim.api.nvim_create_user_command(
                "Helptags",
                function() require("fzf-lua").help_tags() end,
                { desc = "Search all :help tags." }
            )

            vim.api.nvim_create_user_command(
                "History",
                function() require("fzf-lua").history() end,
                { desc = "Show all past, executed commands." }
            )
        end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            {
                "<space>A",
                ":FzfLua args<CR>",
                desc="Select a new [A]rgs file from the `:args` list.",
            },
            {
                "<space>B",
                ":FzfLua buffers<CR>",
                desc="Search existing [B]uffers and select + view it.",
            },
            {
                "<space>E",
                function()
                    local filer = require("my_custom.utilities.filer")
                    local root = filer.get_project_root()

                    if not root
                    then
                        vim.api.nvim_err_writeln('No root could be fould.')

                        return
                    end

                    require("fzf-lua").files({ cwd = root })
                end,
                desc="[E]dit a new project root file.",
            },
            {
                "<space>L",
                ":FzfLua blines<CR>",
                desc="[L]ines searcher (current file)",
            },
            {
                "<space>e",
                ":FzfLua files<CR>",
                desc="Find and [e]dit a file starting from `:pwd`.",
            },
            {
                "<space>l",
                ":FzfLua lines<CR>",
                desc="[l]ines searcher (all lines from all buffers)",
            },
        },
    },

    -- A plugin that highlights the character to move to a word or WORD with f/t
    --
    -- Note:
    --     The original repo, unblevable/quick-scope, has been dead for a while
    --     bradford-smith94 has been added as a maintainer so hopefully the repo
    --     will get some action but, for now, use his fork
    --
    -- Reference:
    --     https://github.com/unblevable/quick-scope/issues/38
    --
    -- TODO: Check if lazy-loading can make this load faster
    --
    {
        "bradford-smith94/quick-scope",
        config = function()
            require("my_custom.plugins.data.quick_scope")
        end,
        init = function()
            require("my_custom.utilities.utility").lazy_load("quick-scope")
        end,
        event = "VeryLazy",
        version = "2.*",
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
            require("leap").init_highlight()

            require('leap').opts.safe_labels = {
                "a", "s", "d", "f", "j", "k", "l", ";",
                "g", "h",
                "A", "S", "D", "F", "J", "K", "L",
            }
        end,
        keys = {
            { "S", "<Plug>(leap-backward-to)", desc = "Leap backward to", silent = true },
            { "s", "<Plug>(leap-forward-to)", desc = "Leap forward to", silent = true },
        },
    },

    -- Use `jk` to exit -- INSERT -- mode. AND there's j/k input delay. Pretty useful.
    {
        "max397574/better-escape.nvim",
        config = function()
          require("better_escape").setup()
        end,
        event = "InsertEnter",
    },

}
