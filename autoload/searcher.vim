let g:project_search_order = ['searcher#get_cmake_root', 'searcher#get_rez_root', 'searcher#get_git_root']

" bool: Check if `text` is a file or directory.
function! s:exists(text)
    return filereadable(a:text) || isdirectory(a:text)
endfunction


" Search from `root` until a file or folder matching `name` is found.
"
" This function is inclusive. Which means "`root`/`name`" is also searched.
"
" Args:
"     name (str): The name of the file or directory to find.
"     root (str): The directory to search within. e.g. "~/foo"
"
" Returns:
"     str: The "directory/`name`" match, if found. Otherwise, return an empty string.
"
function! s:find_up(name, root)
    let l:previous = ''
    let l:path = expand(a:root)

    while l:path != l:previous && !s:exists(l:path . '/' . a:name)
        let l:previous = l:path
        let l:path = s:get_parent_directory(l:path)
    endwhile

    let l:expected = l:path . '/' . a:name

    if s:exists(l:expected)
        return l:expected
    endif

    return ''
endfunction


" str: Get the parent directory of `path`
function! s:get_parent_directory(path)
    return fnamemodify(a:path, ':h')
endfunction


" Find the top-most CMake project file.
"
" This searches upwards for the first-found CMakeLists.txt and then, assuming
" a contiguous CMake project structure, continues to search for more
" CMakeLists.txt files until it can't find any more. It then assumes the
" last found CMakeLists.txt is the root file.
"
" Args:
"     directory (str): The directory on-disk to search for a CMake project.
"
" Returns:
"     str: The found, top level CMakeLists.txt file, if any.
"
function! searcher#get_cmake_root(directory)
    let l:nearest = s:find_up('CMakeLists.txt', a:directory)

    if empty(l:nearest)
        return ''
    endif

    let l:previous = ''
    let l:path = s:get_parent_directory(l:nearest)

    while !empty(l:path) && filereadable(l:path . '/CMakeLists.txt')
        let l:previous = l:path
        let l:path = s:get_parent_directory(l:path)
    endwhile

    if empty(l:path)
        return ''
    endif

    return l:previous
endfunction


" Provide auto-complete options for files/directories under the currently-opened file.
"
" This is meant to be used with :Cedit to get a current-file-relative
" auto-completion list of files which the user can open.
"
" The returned paths are relative to the currently-open file and can nest into
" subfolders.
"
" Args:
"     base (str):
"       The user's WIP file/folder name input, if any. This is auto-provided
"       by Vim, during auto-completion.
"
" Returns:
"     list[str]: The found completion results, if any.
"
function! searcher#get_current_directory_options(base, ...)
    let l:current_file_directory = expand('%:p:h')
    let l:helper_directory = expand('%:p:h')  " A transient directory, just for this function
    let l:text = a:base

    if !empty(l:text)
        let l:written_directory = fnamemodify(l:text, ':h')

        " When you call fnamemodify('foo', ':h'), it returns '.' So we have to
        " prevent the '.' from getting accidentally appended.
        "
        if !empty(l:written_directory) && l:written_directory != '.'
            let l:helper_directory .= '/' . l:written_directory
            let l:text = fnamemodify(l:text, ':t')
        endif
    endif

    let l:output = []

    for l:full_path in glob(l:helper_directory . '/*', 0, 1)
        let l:file_name = fnamemodify(l:full_path, ':t')

        if l:file_name =~ '^' . l:text
            let l:partial_path = substitute(l:full_path, l:current_file_directory . '[/\\]', '', '')

            " This makes directories auto-complete with a trailing '/', which
            " makes diving into subfolders faster. And overall makes
            " autocomleting feel much more fun!
            "
            if isdirectory(l:full_path)
                call add(l:output, l:partial_path . '/')
            else
                call add(l:output, l:partial_path)
            endif
        endif
    endfor

    call sort(l:output)

    return l:output
endfunction


" Find the nearest git repository (or submodule) from a given `directory`.
"
" Args:
"     directory (str):
"         A directory on-disk which is assumed to be on or under some git
"         repository.
"
" Returns:
"     str: Get the directory of the git repository, if found.
"
function! searcher#get_git_root(directory)
    let l:repository = s:find_up('.git', a:directory)

    if empty(l:repository)
        return ''
    endif

    return s:get_parent_directory(l:repository)
endfunction


" Find the nearest Rez directory from a given `directory`.
"
" Args:
"     directory (str): The directory to search within. e.g. "~/foo"
"
" Returns:
"     str: The directory containing a Rez package definition, if any.
"
function! searcher#get_rez_root(directory)
    let l:package = s:find_up('package.py', a:directory)

    if empty(l:package)
        return ''
    endif

    return s:get_parent_directory(l:package)
endfunction


" Find a project root, starting from `directory`.
"
" This function is inclusive. `directory` will also be considered for returns.
"
" Args:
"     directory (str): The folder on-disk to search a project root search.
"
" Returns:
"     str: The found project root, if any.
"
function! s:get_project_root(directory)
    let l:root = ''
    let l:current = getcwd()

    for l:name in g:project_search_order
        let l:root = function(l:name)(l:current)

        if !empty(l:root)
            return l:root
        endif
    endfor

    return ''
endfunction


function! s:execute_from_buffer(command, ...)
    let l:current = getcwd()
    let l:term = get(a:, '1', '')
    let l:root = expand('%:p:h')
    echo "ROOT"
    echo l:root

    " Change to the temporary root
    execute ':cd ' . l:root

    if !empty(l:term)
        execute a:command . ' ' . l:term
    else
        execute a:command
    endif

    " Restore the previous working directory
    execute ':cd ' . l:current
endfunction


" Run a command within a known project root, if any.
"
" The function searches, by default, in the following order
" - CMake
" - Rez
" - Git
"
" The order can be controlled by overriding `g:project_search_order` to use
" other functions.
"
" Important:
"     If any search terms are provided, they need to be escaped properly.
"
" Args:
"     command (str): The executable command to run. e.g. ":Rg".
"     ... (str, optional): The search arguments to add, if any.
"
" Raises:
"     If no project root could be found, the search is aborted.
"
function! s:execute_from_project(command, ...)
    let l:term = get(a:, '1', '')
    let l:current = getcwd()
    let l:root = s:get_project_root(l:current)

    if empty(l:root)
        echoerr 'No root could be found'

        return
    endif

    " Change to the temporary root
    execute ':cd ' . l:root

    if !empty(l:term)
        execute a:command . ' ' . l:term
    else
        execute a:command
    endif

    " Restore the previous working directory
    execute ':cd ' . l:current
endfunction


function! searcher#search_buffer_directory_files(text)
    call s:execute_from_buffer(':Rg', a:text)
endfunction


" Search for text within a known project root, if any.
"
" The function searches, by default, in the following order
" - CMake
" - Rez
" - Git
"
" The order can be controlled by overriding `g:project_search_order` to use
" other functions.
"
" Important:
"     Requires :Rg command, which is a fzf.vim or vim-ripgrep plugin command.
"
" Args:
"     text (str): A search term to look for.
"
" Raises:
"     If no project root could be found, the search is aborted.
"
function! searcher#search_project_text(text)
    call s:execute_from_project(':Rg', a:text)
endfunction


" Search for files within a known project root, if any.
"
" The function searches, by default, in the following order
" - CMake
" - Rez
" - Git
"
" The order can be controlled by overriding `g:project_search_order` to use
" other functions.
"
" Important:
"     Requires :Files command, which is a fzf.vim plugin command.
"
" Raises:
"     If no project root could be found, the search is aborted.
"
function! searcher#search_project_files()
    call s:execute_from_project(':Files')
endfunction


" Change the current directory to the root of the project.
"
" Raises:
"     If no project root could be found, the `:cd` is aborted.
"
function! searcher#cd_to_project()
    let l:current = getcwd()
    let l:root = s:get_project_root(l:current)

    if empty(l:root)
        echoerr 'No project root could be found'

        return
    endif

    execute ':cd ' . l:root
endfunction
