- new tabs in Vim have a bad syntax highlight. Fix
- fix trailing whitespace syntax color
- completion menu should have a white trim, to make it look nicer
 - Same with the command menu
 - white trim, slightly darker background?

- For some reason when I leave dap, the <F5> mapping gets unset. Why? Fix.

- https://www.youtube.com/watch?v=lEMZnrC-ST4
 - https://github.com/ldelossa/nvim-ide

- Figure out how to prevent debugpy / dap from closing Houdini after the breakpoint finishes


let g:_project_home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

silent! argdelete *  " Clear existing args so we can create them, anew

execute ":argadd "
\ . g:_project_home . "/.vimrc"
\ . " " . g:_project_home . "/grammar.js"
\ . " " . g:_project_home . "/test/corpus/metadata.txt"
\ . " " . g:_project_home . "/test/corpus/prim.txt"



## Mappings
TODO Add this


## Requires
- lazy.nvim requires git 2.27+ so that it can used the --filter=blob:none
    - Reference: https://stackoverflow.com/a/51411174
    - Install on CentOS 7 with: https://computingforgeeks.com/install-git-2-on-centos-7/
- Requires jedi-language-server to be installed (for null-ls)
- For debugging [debugpy](https://pypi.org/project/debugpy)




require("dap").disconnect({terminateDebugee=false})
