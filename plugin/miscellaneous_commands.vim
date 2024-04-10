" TODO: Change to autoloads
" Reference: https://stackoverflow.com/questions/8450919
function! DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction
command! -complete=buffer -nargs=1 -bang DeleteHiddenBuffers
    \ :call DeleteHiddenBuffers()

function! CloseAllQFAndLL()
      windo if &buftype == "quickfix" || &buftype == "locationlist" | lclose | endif
endfunction
command! CloseAllQFAndLL call CloseAllQFAndLL()

" Search at the project root (CMake, rez, git) for some search term
command! -nargs=1 Prg :silent call searcher#search_project_text(<q-args>)

command! -nargs=1 Crg :silent call searcher#search_buffer_directory_files(<q-args>)

" Change the current directory to the project root (CMake, rez, git)
command! -nargs=0 Pcd :call searcher#cd_to_project()

" Create a new file from the point of view of the currently-opened file.
function! s:edit_from_current_file_directory(name)
    let path = expand('%')

    if path == ''
        execute ':edit ' . getcwd()

        return
    endif

    " Reference: https://stackoverflow.com/a/13239757
    execute ':edit %:h/' . a:name
endfunction
" Create a new file from the point of view of the currently-opened file.
command! -nargs=1 -complete=customlist,searcher#get_current_directory_options Cedit :call s:edit_from_current_file_directory(<q-args>)
" Create a new file from the point of view of the currently-opened file.
command! -nargs=1 -complete=customlist,searcher#get_current_directory_options CEdit :call s:edit_from_current_file_directory(<q-args>)
