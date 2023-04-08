vim.opt.guicursor = ""  -- Keeps the "fat cursor" in INSERT Mode

-- Note: Don't need to set these because I use the tpope/vim-sleuth plug-in
-- vim.opt.tabstop = 4
-- vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true
-- vim.opt.smartindent = true

-- Allow a large undo history. Don't use swap files. Those are so 80's
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

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
vim.g.python_host_prog = '/bin/python'
vim.g.python3_host_prog = '/bin/python3'
