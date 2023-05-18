return {
    -- Zoxide auto-jump, but for Vim
    {
        "nanotee/zoxide.vim",
        command = "Zi",
        config = function()
            vim.keymap.set(
                "n",
                "<Space>Z",
                ":Zi<CR>",
                {desc="[Z]oxide's interative pwd switcher."}
            )
        end,
        dependencies = {
            "junegunn/fzf.vim",  -- Needed for ``:Zi``
        },
        keys = "<Space>Z",
    },

    {
        "junegunn/fzf",
        build=function()
            vim.cmd[[call fzf#install()]]
        end,
        lazy = true,
    },
    {
        "junegunn/fzf.vim",
        config = function()
            -- Define Zz to get around an error in lazy.nvim
            -- This should be temporary, ideally. Delete, later
            --
            -- Reference: https://github.com/folke/lazy.nvim/issues/718
            --
            vim.cmd[[let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }]]
            vim.api.nvim_create_user_command(
                "Args",
                ":call fzf#run(fzf#wrap({'source': sort(argv())}))",
                {}
            )

            vim.keymap.set(
                "n",
                "<space>B",
                ":Buffers<CR>",
                {desc="Search existing [B]uffers and select + view it."}
            )
            vim.keymap.set(
                "n",
                "<space>e",
                ":Files<CR>",
                {desc="[e]dit a new file from the `:pwd` for the current window."}
            )

            vim.keymap.set(
                "n",
                "<space>L",
                ":Lines<CR>",
                {desc="Search [l]ines in the current window for text."}
            )

            vim.keymap.set(
                "n",
                "<space>A",
                ":Args<CR>",
                {desc="Select a new [A]rgs file from the `:args` list."}
            )

            vim.keymap.set(
                "n",
                "<space>E",
                ":call searcher#search_project_files()<CR>",
                {
                    desc="[E]dit a new file, searching first from the project's root directory.",
                    silent=true,
                }
            )
        end,
        dependencies = { "junegunn/fzf" },
        cmd = { "Args", "Buffers", "Files", "GFiles", "Helptags", "History", "Lines" },
        keys = {"<space>A", "<space>B", "<space>E", "<space>L", "<space>e"},
    },

    -- A more modern, faster grep engine.
    -- Requires https://github.com/BurntSushi/ripgrep to be installed
    --
    {
        "jremmen/vim-ripgrep",
        cmd = "Rg",
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
    },
}
