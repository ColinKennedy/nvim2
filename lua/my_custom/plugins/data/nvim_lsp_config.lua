-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd(
    "LspAttach",
    {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
	    -- Buffer local mappings.
	    -- See `:help vim.lsp.*` for documentation on any of the below functions
	    local opts = { buffer = ev.buf }
	    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
	    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
	    vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	    end, opts)
	    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
	    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
	    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	    vim.keymap.set("n", "<space>f", function()
		vim.lsp.buf.format { async = true }
	    end, opts)
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
vim.cmd[[highlight DiagnosticError ctermfg=DarkRed guifg=DarkRed]]
vim.cmd[[highlight DiagnosticWarn ctermfg=94 guifg=#875f00]]
vim.cmd[[highlight DiagnosticInfo ctermfg=239 guifg=#4e4e4e]]
vim.cmd[[highlight DiagnosticHint ctermfg=17 guifg=#00005f]]

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
