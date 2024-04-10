-- Add Qt.py auto-completion stubs to Vim
--
-- Reference: https://peps.python.org/pep-0561/
--
local separator = ""

if vim.fn.has("win32") == 1
then
    separator = ";"
else
    separator = ":"
end

local existing = os.getenv("PYTHONPATH")

if existing
then
    vim.cmd(
        'let $PYTHONPATH = "'
        .. vim.g.vim_home .. "/python_stubs"
        .. separator
        .. existing
        .. '"'
    )
else
    vim.cmd(
        'let $PYTHONPATH = "' .. vim.g.vim_home .. "/python_stubs" .. '"'
    )
end


vim.api.nvim_create_user_command(
    "LspCapabilities",
    function()
        require("my_custom.utilities.lsp_helper").print_lsp_capabilities()
    end,
    { desc = "Print the features of each LSP" }
)

-- The ctermfg colors are determined by your terminal (``echo $TERM``). Mine is
-- ``screen-256color`` at the time of writing. Their chart is located here:
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

-- Place virtual text really far away from the source code (so I don't see it often)
vim.diagnostic.config(
    {
        virtual_text = {
            -- Note: 84 here basically means "89" when you account for offsets
            --
            -- So this places diagnostics just after the 88 character mark.
            --
            virt_text_win_col = 84,
            severity_sort = true,
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

-- Add a bordered frame around the diagnostics window
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded', close_events = { "BufHidden", "InsertLeave" } }
)
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover, { border = 'rounded' }
)
vim.diagnostic.config { float = { border = "rounded" } }
