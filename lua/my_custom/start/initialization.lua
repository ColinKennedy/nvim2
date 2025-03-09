--- Set all basic Neovim settings at Neovim's start-up.
---
---@module 'my_custom.start.initialization'
---

-- TODO: Remove later
-- local wsl = require("my_custom.utilities.wsl")

vim.cmd [[command! W :SudoWrite]]

vim.opt.ttyfast = true -- Makes certain terminals scroll faster

-- Command-line completion, use '<Tab>' to move and '<CR>' to validate.
vim.opt.wildmenu = true

-- Ignore compiled/backup files when displaying files
vim.opt.wildignore = "*.o,*~,*.pyc,.git,.hg,.svn,*/.hg/*,*/.svn/*,*/.DS_Store"

-- Always show current position at the given line
vim.opt.ruler = true

-- Set the height of the command bar
vim.opt.cmdheight = 2

-- A buffer becomes hidden when it is abandoned, even if it has modifications
vim.opt.hidden = true

-- In many terminal emulators the mouse works just fine, thus enable it.
if vim.fn.has("mouse") then
    vim.opt.mouse = "a"
end

-- Ignore case when searching
vim.opt.ignorecase = true

-- When searching try to be smart about cases
vim.opt.smartcase = true

-- Makes regular characters act as they do in grep, during searches
vim.opt.magic = true

-- Show matching brackets when text indicator is over them
vim.opt.showmatch = true

-- How many tenths of a second to blink when matching brackets
vim.opt.mat = 2

-- Add a bit extra margin to the gutter
vim.opt.foldcolumn = "1"

-- Only let Vim wait for user input (characters) for 0.3 seconds. Gotta go fast!
vim.opt.timeoutlen = 300
-- Wait very little for key sequences
vim.opt.ttimeoutlen = 10

-- Return to last edit position when opening files (You want this!)
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local line = vim.fn.line("'\"")

        if line > 0 and line <= vim.fn.line("$") then
            vim.cmd [[execute "normal! g`\""]]
        end
    end,
})

-- Remember info about open buffers on close
vim.cmd("set viminfo^=%")

-- Always show the status line
vim.opt.laststatus = 2

-- Show relative line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Show weird characters (tabs, trailing whitespaces, etc)
vim.opt.list = true
vim.opt.listchars = "tab:> ,trail: ,nbsp:+"

-- Auto-save whenever you switch buffers - potentially dangerous
vim.opt.autowrite = true
vim.opt.autowriteall = true
vim.api.nvim_create_autocmd({ "FocusLost", "WinLeave" }, {
    -- Write all files before navigating away from Vim
    pattern = "*",
    command = ":silent! wa",
})

-- In vimdiff mode, make diffs open as vertical buffers
-- Seriously. Why is this not the default
--
vim.opt.diffopt:append { "vertical" }

-- This makes joining lines more intelligent
--
-- Example:  without this patch - (X) is the cursor position
-- example_document.vim
-- 1
-- 2 " I am a multiline comment (X)
-- 3 " and here is more info
-- 4
--
-- press Shift+j
--
-- 1
-- 2 " I am a multiline comment (X) " and here is more info
-- 3
--
-- Nooo!! whyyyyy!
--
-- Example:
-- 1
-- 2 " I am a multiline comment (X) and here is more info
-- 3
--
-- Works with other coding languages, too, like Python!
-- Reference: kinbiko.com/vim/my-shiniest-vim-gems
--
if vim.v.version > 703 then
    vim.opt.formatoptions:append { "j" }
end

-- TODO: Make the I/O in this async, later? Then we can remove vim.schedule
vim.schedule(function()
    -- Enable (or download `par`)
    local module = "my_custom.utilities.par"
    local package_exists, par = pcall(require, module)

    if package_exists then
        par.load_or_install()
    else
        vim.notify('Could not load "' .. module .. '" module.', vim.log.levels.ERROR)
    end
end)

-- Disable tag completion (TAB)
--
-- Reference: https://stackoverflow.com/a/13232327/3626104
--
vim.cmd [[set complete-=t]]

-- Common typos that I want to automatically fix
vim.cmd [[abbreviate hte the]]
vim.cmd [[abbreviate het the]]
vim.cmd [[abbreviate chnage change]]

-- Add a new filetype for VEX (SideFX Houdini) files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { ".vex", ".vfl" },
    command = "set filetype=vex",
})

-- Nvim does not have special `t_XX` options nor <t_XX> keycodes to configure
-- terminal capabilities. Instead Nvim treats the terminal as any other UI,
-- e.g. 'guicursor' sets the terminal cursor style if possible.
--
vim.opt.guicursor = "n-v-c:block-Cursor"

-- Allow sentences to start with "E.g.". Don't mark them as bad sentences
vim.opt.spellcapcheck = [[.?!]\_[\])'"\t ]\+,E.g.,I.e.]]

-- Don't auto-resize buffers when a buffer is opened or closed
--
-- Reference: https://stackoverflow.com/a/33388054/3626104
--
vim.opt.equalalways = false

-- TODO: Fix this later
-- --- Change a Windows `path` to a WSL-compatible path.
-- ---
-- --- @param path string An absolute path on-disk. e.g. `"C:\Users\korinkite\temp\test.py"`.
-- --- @return string # The converted path. e.g. `"/mnt/c/users/korinkite/temp/test.py"`.
-- ---
-- function _convert_windows_paths_to_linux(path)
--     path = path:gsub("\\", "/")
--     path = string.gsub(
--         path,
--         "^([A-Z]):/",
--         function(match) return "/mnt/" .. string.lower(match) .. "/" end
--     )
--
--     return vim.fs.normalize(path)
-- end
--
-- if wsl.in_wsl() then
--     vim.opt.isfname:append("\\")
--     vim.opt.isfname:append(":")
--     vim.opt.includeexpr = "v:lua._convert_windows_paths_to_linux(v:fname)"
-- end

-- This removes all "Press ENTER or type command to continue" prompts
--
-- Requires Neovim 0.11+
--
-- Reference: https://github.com/neovim/neovim/pull/31492
--
if pcall(function() return vim.o.messagesopt end) then
    vim.o.messagesopt = "wait:200,history:500"
end
