" Search for a new director and :cd into it.
"
" Reference: https://github.com/junegunn/fzf.vim/issues/338#issuecomment-751500234
"
function! FzfCd()
    let l:current_directory = getcwd()

    call fzf#run(fzf#wrap(fzf#vim#with_preview({'source': 'fd --type directory', 'dir': l:current_directory, 'sink': 'cd', 'options': ['--prompt', l:current_directory . "/"]})))
endfunction
