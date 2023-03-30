" TODO: Move to autoload
" This function changes the default Vim fold text
" Vim will try to fold a docstring in Python like this, by default:
" '''Example string.\n\nMore info.'''
" to "3 lines: '''Example string.
"
" This function will change it to
" "<'''Example string.>
"
" So that the docstring is closer to the indentation of the original docstring
"
" This code is taken from user 'DerWeh' in this thread: https://github.com/tmhedberg/SimpylFold/issues/92
"
function! CustomFoldText()
  "get first non-blank line
  let l:fs = v:foldstart
  while getline(l:fs) =~ '^\s*$' | let l:fs = nextnonblank(l:fs + 1)
  endwhile
  if l:fs > v:foldend
    let l:line = getline(v:foldstart)
  else
    let l:line = substitute(getline(l:fs), '\t', repeat(' ', &tabstop), 'g')
  endif

  "strip foldmarkers
  let l:markexpr = escape(substitute(&foldmarker, ',', '|', 'g'),'{')
  " TODO: check comment sign for filetype, add first line if comment
  let l:whitespace = '(\w\s*)?[#]\s*|\s*$'
  let l:strip_line = substitute(l:line, '\v'.l:markexpr.'|'.l:whitespace, '', 'g')
  let l:strip_line = substitute(l:strip_line, '\v'.l:whitespace, '', 'g')
  let l:strip_line = substitute(l:strip_line, '\v^(\s*)', '\1<', '').'>'
  let l:w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
  let l:foldSize = 1 + v:foldend - v:foldstart
  let l:foldSizeStr = ' ' . l:foldSize . ' lines '
  let l:foldLevelStr = repeat('+--', v:foldlevel)
  let l:lineCount = line('$')
  let l:foldPercentage = printf('[%.1f', (l:foldSize*1.0)/l:lineCount*100) . '%] '
  let l:expansionString = repeat('.', l:w - strwidth(l:foldSizeStr.strip_line.foldLevelStr.foldPercentage))
  return l:strip_line . l:expansionString . l:foldSizeStr . l:foldPercentage . l:foldLevelStr
endfunction

set foldtext=CustomFoldText()
