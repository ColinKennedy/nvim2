return {
    {
        "<leader>gac",
        ":Git add %<CR>",
        desc="[g]it [a]dd [c]urrent file.",
    },
    {
        "<leader>gap",
        ":Git add -p<CR>",
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
        "<leader>gcm",
        ':Git commit -m ""<Left>',
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