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


-- The ctermfg colors are determined by your terminal (``echo $TERM``). Mine is
-- ``screen-256color `` at the time of writing. Their chart is located here:
--
-- References:
--     https://www.ditig.com/256-colors-cheat-sheet
--     https://vim.fandom.com/wiki/Xterm256_color_names_for_console_Vim
--
vim.cmd[[highlight DiagnosticVirtualTextError ctermfg=DarkRed guifg=DarkRed]]
vim.cmd[[highlight DiagnosticVirtualTextWarn ctermfg=94 guifg=#875f00]]  -- Mustard-y
vim.cmd[[highlight DiagnosticVirtualTextInfo ctermfg=25 guifg=DeepSkyBlue4]]  -- Dark, desaturated blue
vim.cmd[[highlight link DiagnosticVirtualTextHint Comment]]  -- Dark gray

vim.cmd[[highlight DiagnosticError ctermfg=Red guifg=Red]]
vim.cmd[[highlight DiagnosticWarn ctermfg=94 guifg=Orange]]
vim.cmd[[highlight DiagnosticInfo ctermfg=26 guifg=DeepSkyBlue2]]  -- Lighter-ish blue
vim.cmd[[highlight DiagnosticSignHint ctermfg=7 guifg=#c0c0c0]]  -- Silver (gray)

-- Reference: https://www.reddit.com/r/neovim/comments/l00zzb/improve_style_of_builtin_lsp_diagnostic_messages
-- Errors in Red
vim.cmd[[highlight LspDiagnosticsVirtualTextError guifg=Red ctermfg=Red]]
-- Warnings in Yellow
vim.cmd[[highlight LspDiagnosticsVirtualTextWarning guifg=Yellow ctermfg=Yellow]]
-- Info and Hints in White
vim.cmd[[highlight LspDiagnosticsVirtualTextInformation guifg=White ctermfg=White]]
vim.cmd[[highlight LspDiagnosticsVirtualTextHint guifg=White ctermfg=White]]

-- Underline the offending code
vim.cmd[[highlight LspDiagnosticsUnderlineError guifg=NONE ctermfg=NONE cterm=underline gui=underline]]
vim.cmd[[highlight LspDiagnosticsUnderlineWarning guifg=NONE ctermfg=NONE cterm=underline gui=underline]]
vim.cmd[[highlight LspDiagnosticsUnderlineInformation guifg=NONE ctermfg=NONE cterm=underline gui=underline]]
vim.cmd[[highlight LspDiagnosticsUnderlineHint guifg=NONE ctermfg=NONE cterm=underline gui=underline]]


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

-- TODO: Figure out how to right-align the virtual text
--
-- Reference: https://github.com/neovim/neovim/issues/16545
--
-- Maybe useful?
--     https://github.com/neovim/neovim/issues/11634
--     https://github.com/neovim/neovim/issues/16634
--     https://jdhao.github.io/2021/09/09/nvim_use_virtual_text/
--     https://github.com/neovim/neovim/issues/11634
--
-- Place virtual text really far away from the source code (so I don't see it often)
vim.diagnostic.config(
    {
        virtual_text = {
            severity_sort = true,
            spacing = 40,
        }
    }
)

-- Add icons for the left-hand sign gutter
vim.fn.sign_define('DiagnosticSignError', {
    text='',  -- Reference: www.nerdfonts.com/cheat-sheet
    numhl='DiagnosticSignError',
    texthl="DiagnosticSignError",
})
vim.fn.sign_define('DiagnosticSignWarn', {
    text='⚠',  -- Reference: www.nerdfonts.com/cheat-sheet
    numhl='DiagnosticSignWarn',
    texthl="DiagnosticSignWarn"
})
vim.fn.sign_define('DiagnosticSignInfo', {
    text='',  -- Reference: www.nerdfonts.com/cheat-sheet
    numhl='DiagnosticSignInfo',
    texthl="DiagnosticSignInfo"
})
vim.fn.sign_define('DiagnosticSignHint', {
    text='',  -- Reference: www.nerdfonts.com/cheat-sheet
    numhl='DiagnosticSignHint',
    texthl="DiagnosticSignHint"
})
