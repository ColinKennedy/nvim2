require("aerial").setup(
    {
        backends = { "lsp", "treesitter" },
        highlight_on_jump = 100,  -- Shorten the blink time to be fast
        nav = {
            keymaps = {
                ["<CR>"] = "actions.jump",
                ["q"] = "actions.close",
            },
        },
        layout = {
            resize_to_content = false,
        },
    }
)
