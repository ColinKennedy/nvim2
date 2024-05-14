-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({})

local on_attach = function(_, buffer)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set(
        "n",
        "gD",
        vim.lsp.buf.declaration,
        {
            buffer=buffer,
            desc="[g]o to all [D]eclarations of the current function, class, whatever.",
        }
    )
    vim.keymap.set(
        "n",
        "gd",
        vim.lsp.buf.definition,
        {
            buffer=buffer,
            desc="[g]o to [d]efinition of the function / class.",
        }
    )
    vim.keymap.set(
        "n",
        "K",
        vim.lsp.buf.hover,
        {
            buffer=buffer,
            desc="Open the documentation for the word under the cursor, if any.",
        }
    )
    vim.keymap.set(
        "n",
        "gi",
        vim.lsp.buf.implementation,
        {
            buffer=buffer,
            desc="Find and [g]o to the [i]mplementation of some header / declaration."
        }
    )
    -- vim.keymap.set(
    --     "n",
    --     "<space>wa",
    --     vim.lsp.buf.add_workspace_folder,
    --     {
    --         buffer=buffer,
    --         desc="[w]orkspace LSP [a]dd - Include a folder for your session.",
    --     }
    -- )
    -- vim.keymap.set(
    --     "n",
    --     "<space>wr",
    --     vim.lsp.buf.remove_workspace_folder,
    --     {
    --         buffer=buffer,
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
    --         buffer=buffer,
    --         desc="[w]orkspace [l]ist - Show the folders for your current session.",
    --     }
    -- )
    -- vim.keymap.set(
    --     "n",
    --     "<space>D",
    --     vim.lsp.buf.type_definition,
    --     {
    --         buffer=buffer,
    --         desc="Show the [D]efinition of some function / instance.",
    --     }
    -- )
    vim.keymap.set(
        "n",
        "<leader>oca",
        vim.lsp.buf.code_action,
        {
            buffer=buffer,
            desc="[o]pen [c]ode [a]ction - Show commands under the cursor."
        }
    )
    vim.keymap.set(
        "n",
        "gr",
        vim.lsp.buf.references,
        {
            buffer=buffer,
            desc="[g]o to [r]eferences - Show all locations where a variable is used."
        }
    )
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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

local lspconfig = require("lspconfig")

lspconfig.basedpyright.setup {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = on_attach,
}

lspconfig.clangd.setup {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = on_attach,
}

lspconfig.lua_ls.setup {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = on_attach,
}

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set(
    "n",
    "[d",
    function()
        vim.diagnostic.goto_prev(
            {
                float={source="always"},
                severity = { min = vim.diagnostic.severity.HINT },
            }
        )
    end,
    {desc="Search upwards for diagnostic messages and go to it, if one is found."}
)

vim.keymap.set(
    "n",
    "]d",
    function()
        vim.diagnostic.goto_next(
            {
                float={source="always"},
                severity = { min = vim.diagnostic.severity.HINT },
            }
        )
    end,
    {desc="Search downwards for diagnostic messages and go to it, if one is found."}
)

vim.keymap.set(
    "n",
    "=d",
    function() vim.diagnostic.open_float({source="always"}) end,
    {desc = "Open the [d]iagnostics window for the current cursor."}
)

vim.diagnostic.config({ virtual_text = false})
