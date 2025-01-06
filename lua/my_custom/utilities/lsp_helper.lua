--- Miscellaneous functions to make dealing with LSPs easier.
---
---@module 'my_custom.utilities.lsp_helper'
---

local M = {}

--- Print every LSP's capabilities as a quick list.
---
--- Reference:
---     https://www.reddit.com/r/neovim/comments/13r7yzw/comment/jljyiar/?utm_source=share&utm_medium=web2x&context=3
---
function M.print_lsp_capabilities()
    local buffer = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients { bufnr = buffer }

    for _, client in pairs(clients) do
        if client.name ~= "null-ls" then
            ---@type string[]
            local capabilities = {}

            for key, value in pairs(client.server_capabilities) do
                if value and key:find("Provider") then
                    local capability = key:gsub("Provider$", "")
                    table.insert(capabilities, "- " .. capability)
                end
            end

            table.sort(capabilities) -- sorts alphabetically
            local message = "# " .. client.name .. "\n" .. table.concat(capabilities, "\n")

            vim.notify(message, vim.log.levels.TRACE, {
                on_open = function(win)
                    local buffer_ = vim.api.nvim_win_get_buf(win)
                    vim.bo[buffer_].filetype = "markdown"
                end,
                timeout = 14000,
            })
            vim.fn.setreg("+", "Capabilities = " .. vim.inspect(client.server_capabilities))
        end
    end
end

--- Returns a string with a list of attached LSP clients, including
--- formatters and linters from null-ls, nvim-lint and formatter.nvim
---
--- Reference: https://gist.github.com/Lamarcke/36e086dd3bb2cebc593d505e2f838e07
---
---@return string # A summary of the Neovim clients that are currently attached to LSPs.
---
function M.get_attached_clients()
    local buf_clients = vim.lsp.get_clients({ bufnr = 0 })

    if #buf_clients == 0 then
        return "LSP Inactive"
    end

    local buf_ft = vim.bo.filetype
    ---@type string[]
    local buf_client_names = {}

    -- add client
    for _, client in pairs(buf_clients) do
        if client.name ~= "copilot" and client.name ~= "null-ls" then
            table.insert(buf_client_names, client.name)
        end
    end

    -- Generally, you should use either null-ls or nvim-lint + formatter.nvim, not both.

    -- Add sources (from null-ls)
    -- null-ls registers each source as a separate attached client, so we need to filter for unique names down below.
    local null_ls_s, null_ls = pcall(require, "null-ls")

    if null_ls_s then
        local sources = null_ls.get_sources()
        for _, source in ipairs(sources) do
            if source._validated then
                for ft_name, ft_active in pairs(source.filetypes) do
                    if ft_name == buf_ft and ft_active then
                        table.insert(buf_client_names, source.name)
                    end
                end
            end
        end
    end

    -- Add linters (from nvim-lint)
    local lint_s, lint = pcall(require, "lint")

    if lint_s then
        for ft_k, ft_v in pairs(lint.linters_by_ft) do
            if type(ft_v) == "table" then
                for _, linter in ipairs(ft_v) do
                    if buf_ft == ft_k then
                        table.insert(buf_client_names, linter)
                    end
                end
            elseif type(ft_v) == "string" then
                if buf_ft == ft_k then
                    table.insert(buf_client_names, ft_v)
                end
            end
        end
    end

    -- Add formatters (from formatter.nvim)
    local formatter_s, _ = pcall(require, "formatter")

    if formatter_s then
        local formatter_util = require("formatter.util")
        for _, formatter in ipairs(formatter_util.get_available_formatters_for_ft(buf_ft)) do
            if formatter then
                table.insert(buf_client_names, formatter)
            end
        end
    end

    -- This needs to be a string only table so we can use concat below
    ---@type string[]
    local unique_client_names = {}

    for _, client_name_target in ipairs(buf_client_names) do
        local is_duplicate = false
        for _, client_name_compare in ipairs(unique_client_names) do
            if client_name_target == client_name_compare then
                is_duplicate = true
            end
        end
        if not is_duplicate then
            table.insert(unique_client_names, client_name_target)
        end
    end

    local client_names_str = table.concat(unique_client_names, ", ")
    local language_servers = string.format("[%s]", client_names_str)

    return language_servers
end

--- Show all Neovim clients that are currently connected to LSPs.
function M.print_attached_clients()
    print(M.get_attached_clients())
end

return M
