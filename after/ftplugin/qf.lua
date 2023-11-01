-- Override `Keep` and `Reject` to be more useful
vim.api.nvim_buf_create_user_command(
    0,
    "Keep",
    function(data)
        local search_term = data.args
        local escaped = search_term:gsub("/", "\\/")

        vim.cmd("%v/" .. escaped .. "/norm dd")
    end,
    { nargs=1 }
)

-- Override `Keep` and `Reject` to be more useful
vim.api.nvim_buf_create_user_command(
    0,
    "Reject",
    function(data)
        local search_term = data.args
        local escaped = search_term:gsub("/", "\\/")

        vim.cmd("%g/" .. escaped .. "/norm dd")
    end,
    { nargs=1 }
)

-- When a quick-fix window is created, move it to the top of Vim
-- vim.cmd[[wincmd K]]
