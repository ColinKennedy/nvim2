This doesn't split into newlines, properly
- vim.keymap.set("n", "[q", ":cprevious<CR>")
- vim.keymap.set("n", "<leader>dil", '^v$hd"_dd', {desc="Delete the current line, without the ending newline character, but still delete the line."})

- nvim-dap-ui - Show the hotkey needed to jump between windows, in the winbar!
snippet simple_cpp_project "Set up mappings for a simple C++ project"
" Reference: https://stackoverflow.com/a/18734557
let g:_project_home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

function! FakeMake(override)
    execute 'DispatchSilentSuccess -compiler=cpp ' . a:override
endfunction

" Compile the project silently
execute 'nnoremap <leader>mm :call FakeMake("cd ' . g:_project_home . '/build && cmake --build .")<CR>'
" Compile the project and show the output
execute 'nnoremap <leader>mv :call FakeMake("cd ' . g:_project_home . '/build && cmake --build . --target install")<CR>'

execute 'nnoremap <leader>tt :call FakeMake("' . g:_project_home . '/build/tests/run_tests")<CR>'

" Note: Requires tpope/vim-projectionist in order to work
function s:go_to_test(file_name)
    execute ':Etest ' . a:file_name
endfunction
nnoremap <leader>gt :execute ':Etest ' . expand('%:t:r')<CR>
endsnippet
