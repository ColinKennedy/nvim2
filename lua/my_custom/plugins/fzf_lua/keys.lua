return {
    {
        "<space>A",
        "<cmd>FzfLua args<CR>",
        desc = "Select a new [A]rgs file from the `:args` list.",
    },
    {
        "<space>B",
        "<cmd>FzfLua buffers<CR>",
        desc = "Search existing [B]uffers and select + view it.",
    },
    {
        "<space>E",
        function()
            local filer = require("my_custom.utilities.filer")
            local root = filer.get_project_root()

            if not root then
                vim.notify("No root could be found.", vim.log.levels.ERROR)

                return
            end

            require("fzf-lua").files({ cwd = root })
        end,
        desc = "[E]dit a new project root file.",
    },
    {
        "<space>L",
        "<cmd>FzfLua blines<CR>",
        desc = "[L]ines searcher (current file)",
    },
    {
        "<space>e",
        "<cmd>FzfLua files<CR>",
        desc = "Find and [e]dit a file starting from `:pwd`.",
    },
    {
        "<space>l",
        "<cmd>FzfLua lines<CR>",
        desc = "[l]ines searcher (all lines from all buffers)",
    },
}
