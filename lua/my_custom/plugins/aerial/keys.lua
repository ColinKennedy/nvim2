return {
    {
        "<space>SS",
        -- NOTE: NoNeckPain comes from https://github.com/shortcuts/no-neck-pain.nvim
        -- The two plugins don't play nice together. But they do if you run this.
        --
        function()
            local success, _ = pcall(vim.cmd.NoNeckPain)

            vim.schedule(vim.cmd.AerialToggle)

            if success then
                vim.schedule(vim.cmd.NoNeckPain)
            end
        end,
        desc = "[S]witch [S]idebar - Open a sidebar that shows the code file's classes, functions, etc.",
    },
    {
        "<space>SN",
        "<cmd>AerialNavToggle<CR>",
        desc = "[S]witch [N]avigation inside / outside of classes and functions.",
    },
}
