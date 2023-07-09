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
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
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

vim.cmd(
    'let $PYTHONPATH = "'
    .. vim.g.vim_home .. "/python_stubs"
    .. separator
    .. os.getenv("PYTHONPATH")
    .. '"'
)

vim.api.nvim_create_user_command(
    "LspCapabilities",
    function()
        require("my_custom.utilities.lsp_helper").print_lsp_capabilities()
    end,
    { desc = "Print the features of each LSP" }
)
