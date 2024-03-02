-- vim.keymap.set(
--     "n",
--     "<space>q",
--     vim.diagnostic.setloclist,
--     {desc="Show the [d]iagnostics for the current file, in a location list window."}
-- )

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
return {
    {
        "[d",
        function()
            vim.diagnostic.goto_prev({float={source="always"}})
        end,
        {desc="Search upwards for diagnostic messages and go to it, if one is found."}
    },
    {
        "]d",
        function()
            vim.diagnostic.goto_next({float={source="always"}})
        end,
        {desc="Search downwards for diagnostic messages and go to it, if one is found."}
    },
    {
        "<leader>d",
        function() vim.diagnostic.open_float({ source="always" }) end,
        desc = "Open the [d]iagnostics window for the current cursor.",
    },
}
