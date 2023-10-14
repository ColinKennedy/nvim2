vim.keymap.set(
    "n",
    "<S-Enter>",
    "O<Esc>j",
    {
        desc="Pressing Shift+Enter will add a new line below the bottom.",
    }
)

vim.keymap.set(
    "n",
    "<F12>",
    "ggg?G``",
    {
        desc="Totally useless ROT13 encyption (for fun!)",
    }
)

vim.keymap.set("n", "gUiw", "mpgUiw`p", {desc="[g]o [U]PPERCASE the current word."})
vim.keymap.set("n", "guiw", "mpguiw`p", {desc="[g]o [u]nder_case the current word."})

-- Reference:http://vim.wikia.com/wiki/Capitalize_words_and_regions_easily
-- gciw       - capitalize inner word (from start to end)
--
vim.keymap.set(
    "n",
    "gcw",
    "guw~h",
    {desc="Capitalize the current letter."}
)
vim.keymap.set(
    "n",
    "gcW",
    "guW~h",
    {desc="Capitalize the current letter."}
)
vim.keymap.set(
    "n",
    "gciw",
    "guiw~h",
    {desc="under_case the current WORD."}
)
vim.keymap.set(
    "n",
    "gciW",
    "guiW~h",
    {desc="Capitalize the current WORD."}
)

-- Select the most recent text change you've made
vim.cmd("noremap gp `[v`]")
-- Note: I couldn't figure out how to get this to work with the above command, in lua
-- vim.keymap.set(
--     "n",
--     "gp",
--     "`[v`]",
--     {
--         desc="Select the most recent text change you've made",
--         expr=true,
--     }
-- )

vim.keymap.set(
    "v",
    ".",
    ":norm.<CR>",
    {
        desc="Make `.` work with visually selected lines."
    }
)

vim.keymap.set(
    "n",
    "<leader>ss",
    ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/<Right>",
    {
        desc="[s]ubstitute [s]election (in-file search/replace) for the word under your cursor.",
    }
)

-- When typing in INSERT mode, pass through : if the cursor is to the left of it.
vim.cmd("inoremap <expr> : search('\\%#:', 'n') ? '<Right>' : ':'")

vim.keymap.set(
    "n",
    "Y",
    "y$",
    {desc="Make capital-y work like capital-d and other commands. See :help Y"}
)

vim.keymap.set(
    "n",
    "<leader>j",
    "gJx",
    {desc="[j]oin the line below without adding an extra space"}
)

vim.keymap.set("n", "[q", ":cprevious<CR>", {desc="Move up the QuickFix window."})
vim.keymap.set("n", "]q", ":cnext<CR>", {desc="Move down the QuickFix window."})

-- Basic mappings that can be used to make Vim "magic" by default
-- Reference: https://stackoverflow.com/q/3760444
-- Reference: http://vim.wikia.com/wiki/Simplifying_regular_expressions_using_magic_and_no-magic
--
local description = {desc='Make Vim\'s search more "magic", by default.'}
vim.keymap.set("n", "/", "/\\v", description)
vim.keymap.set("v", "/", "/\\v", description)
vim.keymap.set("c", "%s/", "%smagic/", description)
vim.keymap.set("c", ">s/",">smagic/", description)

-- Copies the current file to the clipboard
vim.cmd('command! CopyCurrentFile :let @+=expand("%:p")<bar>echo "Copied " . expand("%:p") . " to the clipboard"')
vim.keymap.set(
    "n",
    "<leader>cc",
    ":CopyCurrentFile<CR>",
    {
        desc="[c]opy the [c]urrent file in the current window to the system clipboard. Assuming +clipboard.",
        silent=true,
    }
)

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
    {desc="[d]elete [i]nside the current [l]ine, without the ending newline character."}
)

-- A mapping that quickly expands to the current file's folder. Much
-- easier than cd'ing to the current folder just to edit a single file.
--
vim.keymap.set(
    "n",
    "<leader>e",
    ":Cedit ",
    {desc="[e]xpand to the current file's folder."}
)

-- Reference: https://gist.github.com/habamax/0a6c1d2013ea68adcf2a52024468752e
vim.keymap.set(
    "n",
    "gx",
    ":call command_extensions#better_gx()<CR>",
    {
        desc="Change `gx` to be more useful.",
        silent=true,
    }
)

vim.keymap.set(
    "t",
    "<C-w>=",
    "<C-\\><C-n><C-w>=i",
    {
        desc="Equalize all visible windows. Only useful when 2+ windows visible at once.",
    }
)

vim.keymap.set(
    "n",
    "<leader>cd",
    ":lcd %:p:h<cr>:pwd<cr>",
    {desc="[c]hange the [d]irectory (`:pwd`) to the directory of the current open window."}
)

vim.keymap.set(
    "n",
    "<space>C",
    ":close<CR>",
    {desc="[C]lose the current window."}
)

vim.keymap.set(
    "n",
    "<space>q",
    function()
        require("my_custom.utilities.choose_window").select_quick_fix_window()
    end,
    {desc="Switch to [q]uickfix window, if open"}
)

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

vim.keymap.set(
    "v",
    "<leader>pe",
    ":<C-U>call traceback_parser_python#parse_visual_traceback()<CR>",
    {
        desc="Load the selected [p]ython [e]rror as a quickfix window.",
        silent=true,
    }
)

vim.keymap.set(
    "n",
    "J",
    "mzJ`z",
    {
        desc="Keep the cursor in the same position while pressing ``J``.",
    }
)

vim.keymap.set(
    "n",
    "<leader>st",
    ':execute "SendToRecentTerminal " . @+<CR>',
    {
        desc="[s]end to the nearest [t]erminal your system clipboard text.",
        silent=true,
    }
)

vim.keymap.set(
    "n",
    "<leader>rr",
    ":SendToRecentTerminal !!<CR>",
    {
        desc="[r]e-[r]un the last terminal command (The !! syntax is UNIX-specific)",
        silent=true,
    }
)

vim.keymap.set(
    "n",
    "QQ",
    ":qall!<CR>",
    {desc="Exit Vim without saving."}
)

-- Allow quick and easy movement out of a terminal buffer using just <C-hjkl>
vim.keymap.set(
    "t",
    "<C-h>",
    "<C-\\><C-n><C-w>h",
    {
        desc = "Move to the left of the terminal buffer.",
        silent = true,
    }
)
vim.keymap.set(
    "t",
    "<C-j>",
    "<C-\\><C-n><C-w>j",
    {
        desc = "Move down to the buffer below the terminal buffer.",
        silent = true,
    }
)
vim.keymap.set(
    "t",
    "<C-k>",
    "<C-\\><C-n><C-w>k",
    {
        desc = "Move up to the buffer above the terminal buffer.",
        silent = true,
    }
)
vim.keymap.set(
    "t",
    "<C-l>",
    "<C-\\><C-n><C-w>l",
    {
        desc = "Move to the right of the terminal buffer.",
        silent = true,
    }
)
