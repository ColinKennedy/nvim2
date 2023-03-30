" Reference: https://stackoverflow.com/questions/12485981
"
" Enable syntax highlighting when buffers are displayed in a window through
" :argdo and :bufdo, which disable the Syntax autocmd event to speed up
" processing.
augroup EnableSyntaxHighlighting
    " Filetype processing does happen, so we can detect a buffer initially
    " loaded during :argdo / :bufdo through a set filetype, but missing
    " b:current_syntax. Also don't do this when the user explicitly turned off
    " syntax highlighting via :syntax off.
    " The following autocmd is triggered twice:
    " 1. During the :...do iteration, where it is inactive, because
    " 'eventignore' includes "Syntax". This speeds up the iteration itself.
    " 2. After the iteration, when the user re-enters a buffer / window that was
    " loaded during the iteration. Here is becomes active and enables syntax
    " highlighting. Since that is done buffer after buffer, the delay doesn't
    " matter so much.
    " Note: When the :...do command itself edits the window (e.g. :argdo
    " tabedit), the BufWinEnter event won't fire and enable the syntax when the
    " window is re-visited. We need to hook into WinEnter, too. Note that for
    " :argdo split, each window only gets syntax highlighting as it is entered.
    " Alternatively, we could directly activate the normally effectless :syntax
    " enable through :set eventignore-=Syntax, but that would also cause the
    " slowdown during the iteration Vim wants to avoid.
    " Note: Must allow nesting of autocmds so that the :syntax enable triggers
    " the ColorScheme event. Otherwise, some highlighting groups may not be
    " restored properly.
    autocmd! BufWinEnter,WinEnter * nested if exists('syntax_on') && ! exists('b:current_syntax') && ! empty(&l:filetype) && index(split(&eventignore, ','), 'Syntax') == -1 | syntax enable | endif

    " The above does not handle reloading via :bufdo edit!, because the
    " b:current_syntax variable is not cleared by that. During the :bufdo,
    " 'eventignore' contains "Syntax", so this can be used to detect this
    " situation when the file is re-read into the buffer. Due to the
    " 'eventignore', an immediate :syntax enable is ignored, but by clearing
    " b:current_syntax, the above handler will do this when the reloaded buffer
    " is displayed in a window again.
    autocmd! BufRead * if exists('syntax_on') && exists('b:current_syntax') && ! empty(&l:filetype) && index(split(&eventignore, ','), 'Syntax') != -1 | unlet! b:current_syntax | endif
augroup END
