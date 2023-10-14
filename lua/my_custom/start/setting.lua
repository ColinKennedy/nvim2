vim.opt.guicursor = ""  -- Keeps the "fat cursor" in INSERT Mode

-- Note: Don't need to set these because I use the tpope/vim-sleuth plug-in
-- vim.opt.tabstop = 4
-- vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true
-- vim.opt.smartindent = true

-- Allow a large undo history. Don't use swap files. Those are so 80's
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
local temporary_directory = os.getenv("HOME") or os.getenv("APPDATA")
vim.opt.undodir = temporary_directory .. "/.vim/undodir"
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        pattern = "*",
        command = "execute 'wundo ' . escape(undofile(expand('%')),'% ')",
    }
)

vim.opt.cmdheight = 2

-- Enables 24-bit RGB color
vim.opt.termguicolors = true

-- TODO: Set this differently depending on if in Python or not
vim.opt.colorcolumn = "88"
-- Remove the column-highlight on QuickFix & LocationList buffers
vim.api.nvim_create_autocmd(
    "FileType",
    {
        pattern = "qf",
        command = "setlocal nonumber colorcolumn=",
    }
)

-- Don't redraw while executing macros (good performance config)
vim.opt.lazyredraw = true

-- TODO: This doesn't work. Add it later
-- :W sudo saves the file
-- (useful for handling the permission-denied error)
--
-- vim.api.nvim_add_user_command("W", "w !sudo tee % > /dev/null", { nargs = 0 })


-- Adding these lines makes Neovim load 110ms faster!
--
-- Reference: https://www.reddit.com/r/neovim/comments/r9acxp/neovim_is_slow_because_of_python_provider/
--
vim.g.python_host_prog = "/bin/python"
vim.g.python3_host_prog = "/usr/local/bin/python3.7"

-- Force Neovim to have one statusline for all buffers (rather than one-per-buffer)
--
-- Reference: https://github.com/neovim/neovim/pull/17266
--
vim.opt.laststatus = 3

-- Don't allow editor config files that I don't use for accidentally causing issues.
--
-- Reference: https://youtu.be/3TRouzuWOuQ?t=107
--
vim.g.editorconfig = false



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
