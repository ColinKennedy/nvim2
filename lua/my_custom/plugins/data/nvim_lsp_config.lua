-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set(
    "n",
    "[d",
    function()
        vim.diagnostic.goto_prev({float={source="always"}})
    end,
    {desc="Search upwards for diagnostic messages and go to it, if one is found."}
)
vim.keymap.set(
    "n",
    "]d",
    function()
        vim.diagnostic.goto_next({float={source="always"}})
    end,
    {desc="Search downwards for diagnostic messages and go to it, if one is found."}
)
-- vim.keymap.set(
--     "n",
--     "<space>q",
--     vim.diagnostic.setloclist,
--     {desc="Show the [d]iagnostics for the current file, in a location list window."}
-- )

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd(
    "LspAttach",
    {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(event)
            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            vim.keymap.set(
                "n",
                "gD",
                vim.lsp.buf.declaration,
                {
                    buffer=event.buf,
                    desc="[g]o to all [D]eclarations of the current function, class, whatever.",
                }
            )
            vim.keymap.set(
                "n",
                "gd",
                vim.lsp.buf.definition,
                {
                    buffer=event.buf,
                    desc="[g]o to [d]efinition of the function / class.",
                }
            )
            vim.keymap.set(
                "n",
                "K",
                vim.lsp.buf.hover,
                {
                    buffer=event.buf,
                    desc="Open the documentation for the word under the cursor, if any.",
                }
            )
            vim.keymap.set(
                "n",
                "gi",
                vim.lsp.buf.implementation,
                {
                    buffer=event.buf,
                    desc="Find and [g]o to the [i]mplementation of some header / declaration."
                }
            )
            -- vim.keymap.set(
            --     "n",
            --     "<space>wa",
            --     vim.lsp.buf.add_workspace_folder,
            --     {
            --         buffer=event.buf,
            --         desc="[w]orkspace LSP [a]dd - Include a folder for your session.",
            --     }
            -- )
            -- vim.keymap.set(
            --     "n",
            --     "<space>wr",
            --     vim.lsp.buf.remove_workspace_folder,
            --     {
            --         buffer=event.buf,
            --         desc="[w]orkspace [r]emove - Remove a folder from your session.",
            --     }
            -- )
            -- vim.keymap.set(
            --     "n",
            --     "<space>wl",
            --     function()
            --         print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            --     end,
            --     {
            --         buffer=event.buf,
            --         desc="[w]orkspace [l]ist - Show the folders for your current session.",
            --     }
            -- )
            -- vim.keymap.set(
            --     "n",
            --     "<space>D",
            --     vim.lsp.buf.type_definition,
            --     {
            --         buffer=event.buf,
            --         desc="Show the [D]efinition of some function / instance.",
            --     }
            -- )
            vim.keymap.set(
                "n",
                "<leader>gca",
                vim.lsp.buf.code_action,
                {
                    buffer=event.buf,
                    desc="[c]ode [a]ction - Show available commands for what's under your cursor."
                }
            )
            vim.keymap.set(
                "n",
                "gr",
                vim.lsp.buf.references,
                {
                    buffer=event.buf,
                    desc="[g]o to [r]eferences - Show all locations where a variable is used."
                }
            )
            -- vim.keymap.set(
            --     "n",
            --     "<space>f",
            --     function()
            --         vim.lsp.buf.format { async = true }
            --     end,
            --     {
            --         buffer=event.buf,
            --         desc="auto-[f]ormat the current file.",
            --     }
            -- )
        end,
    }
)


-- Whenever you move the cursor, the status-line shows LSP warnings / errors
local group = vim.api.nvim_create_augroup("lsp_extensions", { clear = true })

vim.api.nvim_create_autocmd(
    "CursorMoved",
    {
        callback = function()
            require("my_custom.utilities.diagnostic_status_display").echo_diagnostic()
        end,
        group = group,
        pattern = "*",
    }
)
