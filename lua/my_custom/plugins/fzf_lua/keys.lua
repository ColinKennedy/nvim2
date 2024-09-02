return {
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
                vim.api.nvim_err_writeln('No root could be found.')

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
}
