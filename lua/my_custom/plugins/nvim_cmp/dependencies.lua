return {
    -- Snippet related
    {
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },

    -- Completion sources
    -- TODO: If I remember right, one of these is bugged when I type in the
    -- command-line. I think it was cmp-cmdline?
    --
    {
        -- LSP completion sources
        "python-lsp/python-lsp-server",
        "pappasam/jedi-language-server",

        -- Generic completion sources
        "andersevenrud/cmp-tmux",
        "hrsh7th/cmp-buffer",
        "ColinKennedy/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-path",
        "neovim/nvim-lspconfig",
    },

    -- For optional, fun icons in the completion menu
    {
        "nvim-tree/nvim-web-devicons",
        "onsails/lspkind.nvim",
    },
}
