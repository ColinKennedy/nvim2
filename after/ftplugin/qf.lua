-- Note: Two separate plugins both override `:Keep` and `:Reject`. We could
-- fork the plugins to remove the commands but it's easier just to override
-- them again, from scratch.
--
local buffer = vim.fn.bufnr()

vim.schedule(
    function()
        -- Override `Keep` and `Reject` to be more useful
        vim.api.nvim_buf_create_user_command(
            buffer,
            "Keep",
            function(data)
                local search_term = data.args
                local escaped = search_term:gsub("/", "\\/")

                vim.cmd("%v/" .. escaped .. "/norm dd")
            end,
            {
                desc = "Remove the lines not matching the given text from search results. Requires itchyny/vim-qfedit",
                nargs=1,
            }
        )

        -- Override `Keep` and `Reject` to be more useful
        vim.api.nvim_buf_create_user_command(
            buffer,
            "Reject",
            function(data)
                local search_term = data.args
                local escaped = search_term:gsub("/", "\\/")

                vim.cmd("%g/" .. escaped .. "/norm dd")
            end,
            {
                desc = "Remove the given text from search results. Requires itchyny/vim-qfedit",
                nargs=1,
            }
        )
    end
)
