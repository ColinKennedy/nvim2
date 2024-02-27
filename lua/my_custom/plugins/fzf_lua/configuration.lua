require("fzf-lua").setup{
    previewers = { builtin = { syntax_delay = 200 } },
    winopts = {
        height = 0.95,
        width = 0.95,
        preview = {
            vertical = 'up:45%',
            layout = "vertical",
        },
    },
}

vim.api.nvim_create_user_command(
    "Commands",
    function() require("fzf-lua").commands() end,
    { desc = "Show all available Commands." }
)

vim.api.nvim_create_user_command(
    "GFiles",
    function() require("fzf-lua").git_files() end,
    { desc = "Find and [e]dit a file in the git repository." }
)

vim.api.nvim_create_user_command(
    "Helptags",
    function() require("fzf-lua").help_tags() end,
    { desc = "Search all :help tags." }
)

vim.api.nvim_create_user_command(
    "History",
    function() require("fzf-lua").history() end,
    { desc = "Show all past, executed commands." }
)
