-- Pressing Enter and Shift+Enter will add a new line below the bottom
vim.keymap.set("n", "<S-Enter>", "O<Esc>j")

-- Reference: https://www.reddit.com/r/neovim/comments/ohdptb/how_do_you_switch_terminal_buffers_but_keep_the/
-- Reference: https://github.com/mrjones2014/smart-splits.nvim
--
-- Allow movement between splits using Ctrl+h/j/k/l
-- recommended mappings
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
--
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)

vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", {noremap=true})
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", {noremap=true})
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", {noremap=true})
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", {noremap=true})


-- Totally useless ROT13 encyption (for fun!)
vim.keymap.set("n", "<F12>", "ggg?G``")

-- Select text you just pasted - Useful for snippets
vim.keymap.set("n", "gV", "`[v`]")

-- Quick toggle undercase and UPPERCASE words
vim.keymap.set("n", "gUiw", "mpgUiw`p")
vim.keymap.set("n", "guiw", "mpguiw`p")

-- Reference:http://vim.wikia.com/wiki/Capitalize_words_and_regions_easily
-- gciw       - capitalize inner word (from start to end)
--
vim.keymap.set("n", "gcw", "guw~h")
vim.keymap.set("n", "gcW", "guW~h")
vim.keymap.set("n", "gciw", "guiw~h")
vim.keymap.set("n", "gciW", "guiW~h")
vim.keymap.set("n", "gc", " gu$~h")
vim.keymap.set("n", "gcgc", "guu~h")

-- Select the most recent text change you've made
vim.cmd[[nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]']]

-- make . work with visually selected lines
vim.keymap.set("v", ".", ":norm.<CR>")

-- Substitute (in-file search/replace)
vim.cmd[[nnoremap <leader>ss :%s/\<<C-r><C-w>\>/<C-r><C-w>/<Right>]]

-- Cross file search/replace
-- Read about argdo before using (Spoiler, it's epic!)
--
vim.cmd[[nnoremap <leader>cs :argdo %s/\<<C-r><C-w>\>/<C-r><C-w>/gce \\| update<Left><Left><Left><Left><Left><Left><Left><Left><BS><Left><Left><Left>]]

-- Pass through : when typing
vim.cmd("inoremap <expr> : search('\\%#:', 'n') ? '<Right>' : ':'")

-- "Make capital-y work like capital-d and other commands. See :help Y
vim.cmd("map Y y$")

-- Join without adding an extra space
vim.keymap.set("n", "<leader>j", "gJx")

-- A mapping that lets you move up and down a QuickFix window
vim.keymap.set("n", "[q", ":cprevious<CR>")
vim.keymap.set("n", "]q", ":cnext<CR>")

-- Basic mappings that can be used to make Vim "magic" by default
-- Reference: https://stackoverflow.com/q/3760444
-- Reference: http://vim.wikia.com/wiki/Simplifying_regular_expressions_using_magic_and_no-magic
--
vim.keymap.set("n", "/", "/\\v")
vim.keymap.set("v", "/", "/\\v")
vim.keymap.set("c", "%s/", "%smagic/")
vim.keymap.set("c", ">s/",">smagic/")

-- Copies the current file to the clipboard
vim.cmd('command! CopyCurrentFile :let @+=expand("%:p")<bar>echo "Copied " . expand("%:p") . " to the clipboard"')
vim.keymap.set("n", "<leader>cc", ":CopyCurrentFile<CR>", {silent=true})

-- Delete the current line, without the ending newline character, but
-- still delete the line. This is useful for when you want to delete a
-- line and insert it somewhere else without introducing extra newlines.
-- e.g. <leader>dilpi( will delete the current line and then paste it
-- within the next pair of parentheses.
--
vim.keymap.set("n", "<leader>dil", '^v$hd"_dd')

-- A mapping that quickly expands to the current file's folder. Much
-- easier than cd'ing to the current folder just to edit a single file.
-- 
vim.keymap.set("n", "<leader>e", ":e <C-R>=expand('%:p:h') . '/'<CR>")

-- Reference: https://gist.github.com/habamax/0a6c1d2013ea68adcf2a52024468752e
vim.keymap.set("n", "gx", ":call command_extensions#better_gx()<CR>", {silent=true})

-- Center the buffers, even in terminal mode
vim.keymap.set("t", "<C-w>=", "<C-\\><C-n><C-w>=i")

-- Switch CWD to the directory of the open buffer
vim.keymap.set("n", "<leader>cd", ":lcd %:p:h<cr>:pwd<cr>")

-- Make navigation easier.
--
-- Important:
--     Requires:
--         - https://github.com/junegunn/fzf.vim
--
vim.keymap.set("n", "<space>B", ":Buffers<CR>")

-- Search from the project root
vim.keymap.set("n", "<space>E", ":call searcher#search_project_files()<CR>", {silent=true})

-- Search the current directory
vim.keymap.set("n", "<space>e", ":Files<CR>")
vim.keymap.set("n", "<space>L", ":Lines<CR>")
vim.keymap.set("n", "<space>O", ":GHistory<CR>")
vim.keymap.set("n", "<space>e", ":Files<CR>")

vim.keymap.set("n", "<space>C", ":close<CR>")

-- Nvim creates a terminal in the same buffer. So we make a separate one, first
vim.keymap.set("n", "<space>T", ":split<BAR>wincmd j<BAR>resize 10N<BAR>terminal<CR>", {silent=true})

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

-- Send the current clipboard selection to the top terminal (within the current tab)
vim.keymap.set("n", "<leader>st", ':execute "SendTop " . @+<CR>', {silent=true})

-- Load the user's visually-selected Python traceback as a quickfix window
vim.keymap.set("v", "<leader>pe", ":<C-U>call traceback_parser_python#parse_visual_traceback()<CR>", {silent=true})

-- Replay the last run in the terminal
-- TODO: Make this a function that auto-finds the last terminal
vim.keymap.set("n", "<leader>rr", ":SendTop !!<CR>", {silent=true})

-- Keep the cursor in the same position while pressing ``J``, in NORMAL mode
vim.keymap.set("n", "J", "mzJ`z")
