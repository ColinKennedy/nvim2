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

-- TODO: Add this, maybe
-- " Reference:http://vim.wikia.com/wiki/Capitalize_words_and_regions_easily
-- " gciw       - capitalize inner word (from start to end)
-- "
-- if (&tildeop)
--     nnoremap gcw guw~l  " Capitalize the current letter
--     nnoremap gcW guW~l  " Capitalize the current letter
--     nnoremap gciw guiw~l  " Capitalize the current word
--     nnoremap gciW guiW~l  " Capitalize the current word
--     nnoremap gc$ gu$~l  " Capitalize the current letter and lower case the line
--     nnoremap gcgc guu~l  " undercase the whole line
-- else
--     nnoremap gcw guw~h
--     nnoremap gcW guW~h
--     nnoremap gciw guiw~h
--     nnoremap gciW guiW~h
--     nnoremap gc$ gu$~h
--     nnoremap gcgc guu~h
-- endif

-- Select the most recent text change you've made
vim.cmd("nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'")

-- make . work with visually selected lines
vim.keymap.set("v", ".", ":norm.<CR>")

-- TODO: Finish this one
-- Substitute (in-file search/replace)
-- vim.cmd("nnoremap <leader>ss :%s/\\<<C-r><C-w>\\>/<C-r><C-w>/<Right>")
-- vim.keymap.set("n", "<leader>ss", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/<Right>")

-- TODO: DO this one
-- Cross file search/replace
-- Read about argdo before using (Spoiler, it's epic!)
--
-- vim.keymap.set("n", "<leader>cs", ":argdo %s/\<<C-r><C-w>\>/<C-r><C-w>/gce \\| update<Left><Left><Left><Left><Left><Left><Left><Left><BS><Left><Left><Left>")

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
vim.keymap.set("n", "/", "/\v")
vim.keymap.set("v", "/", "/\v")
vim.keymap.set("c", "%s/", "%smagic/")
vim.keymap.set("c", ">s/",">smagic/")

-- Copies the current file to the clipboard
vim.cmd('command! CopyCurrentFile :let @+=expand("%:p")<bar>echo "Copied " . expand("%:p") . " to the clipboard"')
vim.keymap.set("n", "<silent> <leader>cc", ":CopyCurrentFile<CR>")

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
vim.keymap.set("n", "<silent> gx", ":call command_extensions#better_gx()<CR>")

-- Center the buffers, even in terminal mode
vim.keymap.set("t", "<C-w>=", "<C-\\><C-n><C-w>=i")
