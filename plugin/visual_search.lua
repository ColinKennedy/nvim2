-- Visual mode search
--
-- Reference: https://github.com/godlygeek/vim-files/blob/871454686a5d05f9a84999232fb874fbd7a071f9/plugin/vsearch.vim
--
vim.cmd[[
function! VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V\<' . substitute(escape(@@, '\'), '\n', '\\n', 'g') . '\>'
  call histadd('/', substitute(@/, '[?/]', '\="\\%d".char2nr(submatch(0))', 'g'))
  let @@ = temp
endfunction
]]

vim.keymap.set(
    "v",
    "*",
    ":<C-u>call VSetSearch()<CR>/<CR>",
    {desc="Search down, using the current visual selection."}
)
vim.keymap.set(
    "v",
    "#",
    ":<C-u>call VSetSearch()<CR>?<CR>",
    {desc="Search up, using the current visual selection."}
)
