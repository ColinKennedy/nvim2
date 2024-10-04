return {
    {
        "<leader>gac",
        ":Git add %<CR>",
        desc="[g]it [a]dd [c]urrent file.",
    },
    {
        "<leader>gap",
        function()
            local git_helper = require("my_custom.utilities.git_helper")

            vim.cmd[[Git add -p]]

            -- vim-fugitive always displays paths relative to the root of the
            -- git repository. But our `getcwd()` may be a subfolder or
            -- somewhere else, which causes `gf` to fail. This command tells
            -- the `gf` command to point the relative paths to the correct
            -- absolute directory.
            --
            vim.b.vim_gf_diff_base_directory = git_helper.get_git_root()
        end,
        -- TODO: Figure out how to get nice tree-sitter highlighting here
        -- function()
        --     vim.cmd[[Git add -p]]
        --     local keys = vim.api.nvim_replace_termcodes(
        --         "<C-\\><C-n>",
        --         true,
        --         false,
        --         true
        --     )
        --     local mode = "m"
        --     vim.api.nvim_feedkeys(keys, mode, false)
        --     vim.treesitter.start(2, "diff")
        --     vim.api.nvim_feedkeys("a", mode, false)
        --     -- vim.schedule(function()
        --     --     local keys = vim.api.nvim_replace_termcodes(
        --     --         "<C-\\><C-n>",
        --     --         true,
        --     --         false,
        --     --         true
        --     --     )
        --     --     local mode = "m"
        --     --     vim.api.nvim_feedkeys(keys, mode, false)
        --     --     vim.treesitter.start(0, "diff")
        --     --     vim.api.nvim_feedkeys("a", mode, false)
        --     -- end)
        -- end,
        desc="[g]it [a]dd -[p] interactive command.",
    },
    {
        "<leader>ga%",
        ":Git add %<CR>",
        desc="[g]it [a]dd %-[c]urrent file.",  -- This is the same as <leader>gac
    },
    {
        "<leader>gcb",
        ":Git checkout ",
        desc="[g]it [c]heckout [b]ranch.",
    },
    {
        "<leader>gcm",
        ':Git commit -m ""<Left>',
        desc="[g]it [c]ommit [m]essage (WIP, you still have to press Enter).",
    },
    {
        "<leader>gcM",
        '<cmd>Git commit --template ~/.gitcommit_template.txt<CR>',
        desc="[g]it [c]ommit [m]essage (WIP, you still have to press Enter).",
    },
    {
        "<leader>gcop",
        ':Git checkout -p<CR>',
        desc="[g]it [c]heckout --[p]artial.",
    },
    {
        "<leader>gdc",
        ":Git diff --cached<CR>",
        desc="[g]it [d]iff --[c]ached.",
    },
    {
        "<leader>gdi",
        ":Git diff ",
        desc="[g]it [d][i] (WIP).",
    },
    {
        "<leader>gph",
        ":Git push<CR>",
        desc="[g]it [p]us[h].",
    },
    {
        "<leader>gpl",
        ":Git pull<CR>",
        desc="[g]it [p]ul[l].",
    },
    {
        "<leader>grc",
        ":Git reset %<CR>",
        desc="[g]it [r]eset [c]urrent.",
    },
    {
        "<leader>gr%",
        ":Git reset %<CR>",
        desc="[g]it [r]eset %-[c]urrent.",
    },
    {
        "<leader>gss",
        ":Git status --short --branch<CR>",
        desc="[g]it [s]hort [s]tatus.",
    },
}
