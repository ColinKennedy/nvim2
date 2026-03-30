vim.g.qf_auto_resize = 0
vim.g.qf_window_bottom = 0

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        vim.keymap.set("n", "{", "<Plug>(qf_previous_file)", {
            buffer = true,
            desc = "Select the previous quick-fix entry of a different file.",
        })
        vim.keymap.set("n", "}", "<Plug>(qf_next_file)", {
            buffer = true,
            desc = "Select the next quick-fix entry of a different file.",
        })

        local buffer = vim.fn.bufnr()

        vim.schedule(function()
            -- Override `Keep` and `Reject` to be more useful
            vim.api.nvim_buf_create_user_command(buffer, "Keep", function(data)
                local search_term = data.args
                local escaped = search_term:gsub("/", "\\/")

                vim.cmd("%v/" .. escaped .. "/norm dd")
            end, {
                desc = "Remove the lines not matching the given text from search results."
                    .. "Requires itchyny/vim-qfedit",
                nargs = 1,
            })

            -- Override `Keep` and `Reject` to be more useful
            vim.api.nvim_buf_create_user_command(buffer, "Reject", function(data)
                local search_term = data.args
                local escaped = search_term:gsub("/", "\\/")

                vim.cmd("%g/" .. escaped .. "/norm dd")
            end, {
                desc = "Remove the given text from search results. Requires itchyny/vim-qfedit",
                nargs = 1,
            })
        end)
    end,
    pattern = "qf",
})
