local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt
local index = luasnip.i
local snippet = luasnip.s


luasnip.add_snippets(
    "vim",
    {
        snippet(
            {
                docstring="Add project files.",
                trig="argadd_project",
            },
            format(
                [[
                    let g:_project_home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

                    silent! argdelete *  " Clear existing args so we can create them, anew

                    execute ":argadd "
                    \ . g:_project_home . "{}"
                    \ . " " . g:_project_home . "{}"
                ]],
                { index(1), index(2) }
            )
        ),

        snippet(
            {
                docstring="Set up mappings for a simple C++ project",
                trig="simple_cpp_project",
            },
            format(
                [[
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
                ]],
                {}
            )
        ),

        snippet(
            {
                docstring="Add a debug configuration for a C++ project.",
                trig="debug_cpp_executable",
            },
            format(
                [[
                    " Reference: https://stackoverflow.com/a/18734557
                    let g:_project_home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

                    " Reference: https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(gdb-via--vscode-cpptools)#configuration
                    lua << EOF
                    local dap = require("dap")
                    dap.configurations.cpp = {
                            name = "Launch file",
                            type = "cppdbg",
                            request = "launch",
                            program = function()
                                return vim.g._project_home .. "/@|"
                            end,
                            cwd = "$workspaceFolder",
                            stopAtEntry = true,
                    }
                    EOF
                ]],
                { index(1) },
                {
                    delimiters = "@|"
                }
            )
        ),

        snippet(
            {
                docstring="Set up project-level quick-commands for developing in Rust.",
                trig="rust_terminal_commands",
            },
            format(
                [[
                    " Reference: https://stackoverflow.com/a/18734557
                    let g:_project_home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

                    function! RunCommandInTerminal(command)
                        ToggleTerm direction=tab

                        tnoremap <buffer> <silent> <leader>x <C-\>\<C-n>:close<CR>
                        nnoremap <buffer> <silent> <leader>x :close<CR>

                        execute "TermExec cmd='" . a:command . "' dir='" . g:_project_home . "'"
                        " ToggleTerm [toggleterm.nvim plugin] starts in Terminal mode by default. Exit Terminal mode
                        call feedkeys("\<C-\>\<C-n>")
                    endfunction


                    execute 'nnoremap <silent> <leader>mc :call RunCommandInTerminal("cargo check")<CR>'
                    execute 'nnoremap <silent> <leader>mx :call RunCommandInTerminal("cargo run")<CR>'
                ]],
                {}
            )
        ),

        snippet(
            {
                docstring='A quick way to make "per-project" toggleable files Using [a and ]a.',
                trig="add_workspace_argslist",
            },
            format(
                [[
                    let g:_project_home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

                    silent! argdelete *  " Clear existing args so we can create them, anew

                    execute ":argadd "
                    \ . g:_project_home . "/.vimrc"
                    \ . " " . g:_project_home . "/grammar.js"
                    \ . " " . g:_project_home . "/test/corpus/metadata.txt"
                    \ . " " . g:_project_home . "/test/corpus/prim.txt"

                    nnoremap <M-j> :normal ]a<CR>
                    nnoremap <M-k> :normal [a<CR>
                    nnoremap <M-l> :args<CR>
                ]],
                {}
            )
        ),
    }
)
