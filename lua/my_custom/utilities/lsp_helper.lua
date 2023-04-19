local M = {}

-- Print every LSP's capabilities as a quick list.
--
-- Reference: https://www.reddit.com/r/neovim/comments/13r7yzw/comment/jljyiar/?utm_source=share&utm_medium=web2x&context=3
--
function M.print_lsp_capabilities()
    local buffer = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_active_clients { bufnr = buffer }

    for _, client in pairs(clients)
    do
        if client.name ~= "null-ls"
        then
            local capabilities = {}

            for key, value in pairs(client.server_capabilities)
            do
                if value and key:find("Provider") then
                    local capability = key:gsub("Provider$", "")
                    table.insert(capabilities, "- " .. capability)
                end
            end

            table.sort(capabilities) -- sorts alphabetically
            local message = "# " .. client.name .. "\n" .. table.concat(capabilities, "\n")

            vim.notify(
                message,
                "trace",
                {
                    on_open = function(win)
                        local buf = vim.api.nvim_win_get_buf(win)
                        vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
                    end,
                    timeout = 14000,
                }
            )
            vim.fn.setreg("+", "Capabilities = " .. vim.inspect(client.server_capabilities))
        end
    end
end

return M
