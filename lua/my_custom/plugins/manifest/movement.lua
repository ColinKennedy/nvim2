return {
    -- Autojump but for Vim. Use `:J` to change directories
    -- or `:Cd` as a replacement to `:cd`.
    --
    {
        "padde/jump.vim",
        cmd = { "J", "Jc", "Jo", "Jco" },
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
            vim.api.nvim_create_user_command("Zz", "Help", {nargs=0})
        end,
        dependencies = { "junegunn/fzf" },
        cmd = { "Buffers", "Files", "GFiles", "Zz", "History", "Lines" },
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
        event = { "CursorMoved", "CursorMovedI" },
        config = function()
            require("my_custom.plugins.data.quick_scope")
        end
    },
}
