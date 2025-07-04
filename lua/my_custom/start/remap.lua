--- Simple keymaps to include on-start-up.
---
---@module 'my_custom.start.remap'
---

vim.keymap.set("n", "<F12>", "ggg?G``", {
    desc = "Totally useless ROT13 encyption (for fun!)",
})

vim.keymap.set("n", "gUiw", "mpgUiw`p", { desc = "[g]o [U]PPERCASE the current word." })
vim.keymap.set("n", "guiw", "mpguiw`p", { desc = "[g]o [u]nder_case the current word." })

-- Reference:http://vim.wikia.com/wiki/Capitalize_words_and_regions_easily
-- gciw       - capitalize inner word (from start to end)
--
vim.keymap.set("n", "gcw", "guw~h", { desc = "Capitalize the current letter." })
vim.keymap.set("n", "gcW", "guW~h", { desc = "Capitalize the current letter." })
vim.keymap.set("n", "gciw", "guiw~h", { desc = "under_case the current WORD." })
vim.keymap.set("n", "gciW", "guiW~h", { desc = "Capitalize the current WORD." })

-- Select the most recent text change you've made
vim.keymap.set("n", "gp", "`[v`]", { desc = "Select the most recent text [p]ut you've done." })

vim.keymap.set("v", ".", "<cmd>norm.<CR>", {
    desc = "Make `.` work with visually selected lines.",
})

vim.keymap.set("n", "<leader>ss", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/<Right>", {
    desc = "[s]ubstitute [s]election (in-file search/replace) for the word under your cursor.",
})

-- When typing in INSERT mode, pass through : if the cursor is to the left of it.
vim.cmd("inoremap <expr> : search('\\%#:', 'n') ? '<Right>' : ':'")

vim.keymap.set(
    "n",
    "<leader>j",
    "j:s/^\\s*//<CR>kgJ",
    { desc = "[j]oin this line with the line below, without whitespace." }
)

-- Basic mappings that can be used to make Vim "magic" by default
-- Reference: https://stackoverflow.com/q/3760444
-- Reference: http://vim.wikia.com/wiki/Simplifying_regular_expressions_using_magic_and_no-magic
--
local description = { desc = 'Make Vim\'s search more "magic", by default.' }
vim.keymap.set("n", "/", "/\\v", description)
vim.keymap.set("v", "/", "/\\v", description)
vim.keymap.set("c", "%s/", "%smagic/", description)
vim.keymap.set("c", ">s/", ">smagic/", description)

-- Copies the current file to the clipboard
vim.cmd('command! CopyCurrentFile :let @+=expand("%:p")<bar>echo "Copied " . expand("%:p") . " to the clipboard"')
vim.keymap.set("n", "<leader>cc", "<cmd>CopyCurrentFile<CR>", {
    desc = "[c]opy the [c]urrent file in the current window to the system clipboard. Assuming +clipboard.",
    silent = true,
})

-- Delete the current line, without the ending newline character, but
-- still delete the line. This is useful for when you want to delete a
-- line and insert it somewhere else without introducing extra newlines.
-- e.g. <leader>dilpi( will delete the current line and then paste it
-- within the next pair of parentheses.
--
vim.keymap.set(
    "n",
    "<leader>dil",
    '^v$hd"_dd',
    { desc = "[d]elete [i]nside the current [l]ine, without the ending newline character." }
)

-- A mapping that quickly expands to the current file's folder. Much
-- easier than cd'ing to the current folder just to edit a single file.
--
vim.keymap.set("n", "<leader>e", ":Cedit ", { desc = "[e]xpand to the current file's folder." })

-- Reference: https://gist.github.com/habamax/0a6c1d2013ea68adcf2a52024468752e
vim.keymap.set("n", "gx", "<cmd>call command_extensions#better_gx()<CR>", {
    desc = "Change `gx` to be more useful.",
    silent = true,
})

vim.keymap.set("t", "<C-w>=", "<C-\\><C-n><C-w>=i", {
    desc = "Equalize all visible windows. Only useful when 2+ windows visible at once.",
})

vim.keymap.set(
    "n",
    "<leader>cd",
    "<cmd>lcd %:p:h<cr>:pwd<CR>",
    { desc = "[c]hange the [d]irectory (`:pwd`) to the directory of the current open window." }
)

vim.keymap.set("n", "<space>C", "<cmd>close<CR>", { desc = "[C]lose the current window." })

vim.keymap.set("n", "<space>q", function()
    require("my_custom.utilities.choose_window").select_quick_fix_window()
end, { desc = "Switch to [q]uickfix window, if open" })

-- TODO: Fix this
-- -- Get the Python dot-path from a Python unittest error / fail line
-- -- e.g. "tests.test_foo.TestClass.test_do_something"
-- --
-- function! AddVisualDotPathToTheClipboard()
--     let l:text = "python -m unittest " . unittest_error_parser#get_visual_dot_path()
--     let @+=l:text
--     echo l:text
-- endfunction
--
-- function! AddCurrentDotPathToTheClipboard()
--     let l:text = "python -m unittest " . unittest_error_parser#get_current_line()
--     let @+=l:text
--     echo l:text
-- endfunction
--
-- vnoremap <silent> <leader>pt :<C-U>call AddVisualDotPathToTheClipboard()<CR>
-- nnoremap <silent> <leader>pt :<C-U>call AddCurrentDotPathToTheClipboard()<CR>
--
-- vim.keymap.set(
--     "n",
--     "<leader>st",
--     ':execute "SendTop " . @+<CR>',
--     {
--         desc="Send copied system clipboard to the last-visited terminal (for the current tab).",
--         silent=true,
--     }
-- )
--
-- vim.keymap.set(
--     "n",
--     "<leader>rr",
--     ":SendTop !!<CR>",
--     {
--         desc="Replay the last-run in the terminal from the most recent terminal.",
--         silent=true,
--     }
-- )

vim.keymap.set("v", "<leader>pt", "<cmd><C-U>call traceback_parser_python#parse_visual_traceback()<CR>", {
    desc = "Load the selected [p]ython [t]raceback as a quickfix window.",
    silent = true,
})

vim.keymap.set("n", "J", "mzJ`z", {
    desc = "Keep the cursor in the same position while pressing ``J``.",
})

vim.keymap.set("n", "<leader>st", '<cmd>execute "SendToRecentTerminal " . @+<CR>', {
    desc = "[s]end to the nearest [t]erminal your system clipboard text.",
    silent = true,
})

vim.keymap.set("n", "<leader>rr", "<cmd>SendToRecentTerminal !!<CR>", {
    desc = "[r]e-[r]un the last terminal command (The !! syntax is UNIX-specific)",
    silent = true,
})

vim.keymap.set("n", "QQ", "<cmd>qall!<CR>", { desc = "Exit Vim without saving." })

-- Search for text within some visual selection
--
-- luacheck: ignore 631
-- Reference: https://www.reddit.com/r/neovim/comments/16ztjvl/comment/k3hd4i1/?utm_source=share&utm_medium=web2x&context=3
--
vim.keymap.set("x", "/", "<Esc>/\\%V", { desc = "Search within a visual selection" })

-- Change Vim to add numbered j/k  movement to the jumplist
vim.cmd [[nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k']]
vim.cmd [[nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j']]

-- Allow quick and easy movement out of a terminal buffer using just <C-hjkl>
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", {
    desc = "Move to the left of the terminal buffer.",
    silent = true,
})
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", {
    desc = "Move down to the buffer below the terminal buffer.",
    silent = true,
})
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", {
    desc = "Move up to the buffer above the terminal buffer.",
    silent = true,
})
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", {
    desc = "Move to the right of the terminal buffer.",
    silent = true,
})

vim.keymap.set("t", "<C-w>o", "<C-\\><C-n><cmd>ZoomWinTabToggle<CR>", { silent = true })
vim.keymap.set("t", "<C-w><C-o>", "<C-\\><C-n><cmd>ZoomWinTabToggle<CR>", { silent = true })

vim.cmd [[
let g:_pager_bottom_texts = [":", "?", "/", "Pattern not found  (press RETURN)", "(END)"]
]]

-- Reference: https://github.com/neovim/neovim/issues/21422#issue-1497443707
vim.keymap.set(
    "x",
    "Q",
    "<cmd>normal @<C-r>=reg_recorded()<CR><CR>",
    { desc = "Repeat the last recorded register on all selected lines." }
)

local _go_to_diagnostic

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
if vim.diagnostic.jump ~= nil then
    --- TODO: In later Neovim versions I think these are default mappings. If so,
    --- remove these diagnostic mappings.
    ---
    ---@param next boolean If `true`, go down / to next diagnostic matching `severity`.
    ---@param severity vim.diagnostic.Severity The issue's importance.
    ---@return fun(): nil # A function that goes to the diagnostic, when called.
    ---
    _go_to_diagnostic = function(next, severity)
        local count

        if next then
            count = 1
        else
            count = -1
        end

        return function()
            vim.diagnostic.jump({ count = count, float = true, severity = severity })
        end
    end
else
    --- TODO: In later Neovim versions I think these are default mappings. If so,
    --- remove these diagnostic mappings.
    ---
    ---@param next boolean If `true`, go down / to next diagnostic matching `severity`.
    ---@param severity vim.diagnostic.Severity The issue's importance.
    ---@return fun(): nil # A function that goes to the diagnostic, when called.
    ---
    _go_to_diagnostic = function(next, severity)
        local caller

        if next then
            ---@diagnostic disable-next-line deprecated
            caller = vim.diagnostic.goto_next
        else
            ---@diagnostic disable-next-line deprecated
            caller = vim.diagnostic.goto_prev
        end

        return function()
            caller({ severity = severity })
        end
    end
end

-- TODO: In later Neovim versions I think these are all default mappings. If so, remove them.
-- Reference: https://www.joshmedeski.com/posts/underrated-square-bracket
--
vim.keymap.set("n", "]e", _go_to_diagnostic(true, vim.diagnostic.severity.ERROR), { desc = "Next diagnostic [e]rror." })
vim.keymap.set(
    "n",
    "[e",
    _go_to_diagnostic(false, vim.diagnostic.severity.ERROR),
    { desc = "Previous diagnostic [e]rror." }
)
vim.keymap.set(
    "n",
    "]w",
    _go_to_diagnostic(true, vim.diagnostic.severity.WARN),
    { desc = "Next diagnostic [w]arning." }
)
vim.keymap.set(
    "n",
    "[w",
    _go_to_diagnostic(false, vim.diagnostic.severity.WARN),
    { desc = "Previous diagnostic [w]arning." }
)

vim.keymap.set("n", "<leader>gsp", function()
    local saver = require("my_custom.utilities.git_stash.saver")
    saver.push()
end, { desc = "[g]it [s]tash [p]ush the current repository." })

vim.keymap.set("n", "<leader>gsa", function()
    vim.cmd [[:Telescope git_stash]]
end, { desc = "[g]it [s]tash [a]pply onto the current repository." })

-- Auto-Replace :cd to :tcd, which is better, all around
--
-- Reference: https://vim.fandom.com/wiki/Replace_a_builtin_command_using_cabbrev
--
vim.cmd [[cabbrev cd <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'tcd' : 'cd')<CR>]]

vim.keymap.set("n", "QA", function()
    vim.cmd [[wqall]]
end, { desc = "[w]rite and [q]uit [all] buffers." })

vim.keymap.set("n", "<leader>rs", "<cmd>normal 1z=<CR>", {
    desc = "[r]eplace word with [s]uggestion.",
    silent = true,
})

vim.keymap.set("n", "z?", function()
    if require("my_custom.utilities.spelling").in_strict_mode() then
        vim.cmd [[:exe ":spellrare  " .. expand("<cWORD>")]]
    end
end, {
    desc = "Add the current word to the rare words list.",
    silent = true,
})

vim.keymap.set("v", "<leader>pd", function()
    local parser = require("my_custom.utilities.python_unittest_parser")

    parser.copy_current_line_unittest_to_clipboard()
end, {
    desc = "[p]arse the [d]ot separated path from a unittest read-out from the current line.",
    silent = true,
})

vim.keymap.set("n", "<leader>td", function()
    vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
end, { desc = "[t]oggle [d]iagnostic as virtual_lines." })
