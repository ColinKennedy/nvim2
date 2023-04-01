-- Use Spacebar to execute commands
vim.keymap.set("n", "<Space>", ":")

-- Pressing Enter and Shift+Enter will add a new line below the bottom
vim.keymap.set("n", "<S-Enter>", "O<Esc>j")

-- Totally useless ROT13 encyption (for fun!)
vim.keymap.set("n", "<F12>", "ggg?G``")

-- Select text you just pasted - Useful for snippets
vim.keymap.set("n", "gV", "`[v`]")

-- Add new bottom line in insert mode
-- (good for getting out of auto-brackets)
--
vim.keymap.set("i", "<C-i>", "<C-[>o")

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
-- Important:
--     Requires:
--         - https://github.com/ColinKennedy/vim-git-backup
--         - https://github.com/junegunn/fzf.vim
--
vim.keymap.set("n", ":B", ":Buffers<CR>")
vim.keymap.set("n", ":C", ":close<CR>")

-- Search from the project root
vim.keymap.set("n", ":E", ":call searcher#search_project_files()<CR>")

-- Search the current directory
vim.keymap.set("n", ":e", ":Files<CR>")
vim.keymap.set("n", ":L", ":Lines<CR>")
vim.keymap.set("n", ":N", ":enew<CR>")
vim.keymap.set("n", ":O", ":GHistory<CR>")
vim.keymap.set("n", ":R", ":FrgNoName<CR>")
vim.keymap.set("n", ":e", ":Files<CR>")

if vim.fn.has("nvim")
then
    -- Nvim creates a terminal in the same buffer. So we make a separate one, first
    vim.keymap.set("n", ":T", ":split<BAR>terminal<CR>", {silent=true})
else
    -- Vim creates a terminal in a new buffer and puts you into insert mode
    vim.keymap.set("n", ":T", ":terminal<CR>", {silent=true})
end

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
