- Figure out how to do remote debugging
 - /opt/hfs19.5.569/bin/houdini

- new tabs in Vim have a bad syntax highlight. Fix
- fix trailing whitespace syntax color
- completion menu should have a white trim, to make it look nicer
 - Same with the command menu
 - white trim, slightly darker background?

- Moving between splits and tmux no longer works. FIX

- indentation gets messed up sometimes. Not sure why. Was it due to lspconfig
  when I enabled indentation?

- nvim-dap-ui icons would be nice
- For some reason when I leave dap, the <F5> mapping gets unset. Why? Fix.

- https://www.youtube.com/watch?v=lEMZnrC-ST4
 - https://github.com/ldelossa/nvim-ide



let g:_project_home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

silent! argdelete *  " Clear existing args so we can create them, anew

execute ":argadd "
\ . g:_project_home . "/.vimrc"
\ . " " . g:_project_home . "/grammar.js"
\ . " " . g:_project_home . "/test/corpus/metadata.txt"
\ . " " . g:_project_home . "/test/corpus/prim.txt"









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







- null-ls's pylint isn't taking into account PYTHONPATH, even though it acutally is importable
 - See sphinx-code-include

- Try installing this onto another machine
- https://github.com/folke/which-key.nvim

- Pretty sure this stuff breaks but it'd be good to at least check it out again
 - https://github.com/hrsh7th/cmp-cmdline

https://github.com/ryanoasis/vim-devicons/issues/106
https://coreyja.com/vim-fzf-with-devicons/


- Pressing w should scroll up in the terminal(?)
- neogen has some issues
 - raises is parsed incorrectly, in Python

- yi` doesn't work. Fix!!!

- Auto completion work
 --- Python LSPs
 - C++ LSPs
  --- Jumpy (CMake enabled projects)
  --- General
  - USD
   - Maybe clangd is better? ccls keeps reporting incorrect information
    - it's better if I use explicit types. But ``auto`` is great. Need it.
    - maybe I can compile clangd with mason, but with an older version so that GLIBC works

- See if I can adapt NvChad for my purposes
 - Objectives
  --- auto complete tab behavior is good. Use their config
   --- Make tab complete based on tab. And snippets auto-expand with tab. But still allow ctrl+n / ctrl+p to cycle through snippets
    --- like NvChad
  --- Auto complete cycling is fast. Emulate it




















- wilder bug
 - print a lot of stuff
 - load telescope
  - go :message
  - it fills the screen, weirdly


- Check out circles.nvim
- https://github.com/folke/neodev.nvim

- vim config clean-up
 - change manifest / data code to just "plugins" / "configs" - Use NvChad as an example

- lazy's window stylesheet is gross. Fix
- Disable trailing whitespace from lazy's pop-up window

- command line completion should have icons and other fun stuff

- Add ``did`` support. See ``require("nvim-treesitter.configs").setup``

- disable trailing whitespace from mason-style GUIs
- neogen raises docstring stuff doesn't work as expected
 - https://github.com/danymat/neogen/issues/139

- Change af / if to match preceding comment lines. For God's sake

- Remove after/ files, maybe. They probably aren't needed
- try installing this on a fresh machine

- It'd be nice if the cursor centering doesn't break
 - Possible solution? https://stackoverflow.com/questions/64280931/keep-cursor-line-vertically-centered-in-vim
- Ask treesitter people about module highlighting
- Is it possible to add devicons / LSP information into Command mode?



















- Add lua auto-complete?

https://github.com/jackguo380/vim-lsp-cxx-highlight

- Port block-party to treesitter
 - https://github.com/RRethy/nvim-treesitter-textsubjects
  - Maybe someone else already did it?


Apparently my stylesheet is able to have a colored number AND cursorline at the same time. How? Find out.
cursorline does not need to be set

https://www.reddit.com/r/neovim/comments/12hnn66/fyi_your_vim_help_docs_looking_a_little_bland/
Neovim statuscolumn? Highlighting?

Disable editorconfig
- https://www.youtube.com/watch?v=3TRouzuWOuQ&ab_channel=ElijahManor

- return snippet - try to use treesitter to delete the left-hand assignment (if one exists)
Try NvChad again

• Added preliminary support for the `workspace/didChangeWatchedFiles` capability
  to the LSP client to notify servers of file changes on disk. The feature is
  disabled by default and can be enabled by setting the
  `workspace.didChangeWatchedFiles.dynamicRegistration=true` capability.

https://www.reddit.com/r/neovim/comments/12h6fc7/am_i_doing_wrong_with_lazynvim/


- Consider - https://github.com/kevinhwang91/nvim-bqf


- need terminal send / etc code
 - Change my terminal set-up to have the terminal below, not above
  - SendRecent! - sends to tmux if both are there
   - config to switch the priority


- Check that the lazy-load logic is actually fast


https://www.reddit.com/r/neovim/comments/10zgrn1/hightlight_treesitter_node_under_cursor_thing/
https://github.com/dharmx/nvim/blob/e79ac39e3c9aff7e4e99ce889caea45c5fc65bc4/lua/scratch/node.lua

- Consider
 - https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#gitsigns
 - https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#refactoring
 - https://github.com/pylint-dev/pylint#advised-linters-alongside-pylint
 - https://github.com/DanielNoord/pydocstringformatter
 - https://github.com/jendrikseipp/vulture
 - https://github.com/ThePrimeagen/refactoring.nvim

https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-cht.sh

https://youtu.be/hJzqEAf2U4I?t=392

https://www.reddit.com/r/neovim/comments/ug2s4s/disable_diagnostic_while_expanding_luasnip/

- jedi_language_server's autocomplete is way better than pylsp. Remove pylsp from completion sources

- https://github.com/hrsh7th/nvim-cmp/wiki/Advanced-techniques#disabling-completion-in-certain-contexts-such-as-comments
- https://github.com/hrsh7th/nvim-cmp/wiki/Advanced-techniques#add-parentheses-after-selecting-function-or-method-item
- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#super-tab-like-mapping

- Configure settings for pydocstyle / pylint (they seem to not report every issue)

- Look into what LSP / linter / formatter stuff can be done. Can I do refactoring / auto
fixes and stuff now? I probably will need to add the mappings.

- Where do treesitter parsers install to? Can I bundle it / control their path?


- autocomplete
 - Keep an eye out for my current mappings. Do they feel good? Do they need adjusting?


- add LSP for C++, Python, and C++ USD, and C++ Qt
 - LSP auto-complete
 - Python
  - USD?
 - C++
  - CMake compile_commands.json
  - USD
  - General
 - add deferred event call so that the plugins aren't loaded by default
  - NvChad uses ``event = "InsertEnter"``

- wtf is this thing?
 - https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#code-actions
 - https://github.com/streetsidesoftware/cspell
 - https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md


- holding w in the terminal should scroll up
- On-load speed-up?
- Check out
 - after/plugin/more_keymaps.vim:vnoremap <silent> <leader>pe :<C-U>call traceback_parser_python#parse_visual_traceback()<CR>
- Try this out - /home/selecaoone/repositories/NvChad/lua/plugins/init.lua
 - example gitsigns.nvim. Might be good?

- language server stuff
 - auto-refactors
 - renames
 - project cd
 - auto-completion
 - other settings?

- Consider these completion sources
 - https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources#miscellaneous
 - https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
 - https://github.com/lukas-reineke/cmp-rg

- Make sure to add plugins as git submodules, later

- Where do treesitter parses install to? Can I localize them to my single folder?
- Add treesitter parsers for other languages

- Implement HLNext?


https://github.com/williamboman/mason.nvim/blob/b54d4e3171cc9735de915dbb97e987fb1f05dad9/lua/mason/mappings/language.lua#L22


https://github.com/mfussenegger/nvim-dap
Doesn’t appear to need Python 3
Apparently it can also do remote debugging??
https://github.com/rcarriga/nvim-dap-ui
https://www.youtube.com/watch?v=5KQK2id3JtI
https://www.youtube.com/watch?v=ga3Cas7vNCk



https://alpha2phi.medium.com/neovim-for-beginners-lua-autocmd-and-keymap-functions-3bdfe0bebe42

https://github.com/brainfucksec/neovim-lua/blob/main/nvim/lua/core/autocmds.lua

https://www.youtube.com/watch?v=stqUbv-5u2s

https://www.youtube.com/watch?v=w7i4amO_zaE&t=1464s

https://www.youtube.com/watch?v=kdP4ZHE4Bx4

https://www.youtube.com/watch?v=HR1dKKrOmDs&t=29s


- Go through checkhealth stuff
- Do the rest of the TODO notes
- Make sure to defer load as much as possible



- Dependencies, maybe
 - A patched nerd font (for icons)
  - https://www.nerdfonts.com/font-downloads
  - Using DroidSansMono Nerd Font
 - python3 -m pip install python-lsp-server
 - ccls installation
  (mason was unable to install clangd because CentOS is on a super old GLIBC version)


- Make sure to note that you need to specify the host python version(s)()
    vim.g.python_host_prog = "/bin/python"
    vim.g.python3_host_prog = "/usr/local/bin/python3.7"



I've been using w0ng/vim-hybrid as my colorscheme for 8 years and I really like it. Recently I've been trying to embrace neovim rather than treating it as a "Vim + terminal / debugger". During that journey, I downloaded nvim-treesitter and was frankly underwhelmed by its syntax highlighting. I see potential so I'd love to make it work but I'm having trouble pinning down where the problem exactly lives. Is it treesitter's parse? vim-hybrid? Or something completely different. I was hoping for some Neovim community advice :)

Here's a screenshot of what I see
Without treesitter (normal Python syntax highlighting)
With treesitter








## Deal With These Later
- Make ticket about treesitter module / class import parsing




## Make Sure Works At Scale
This is stuff that I think is working but not entirely sure.

- Python docstring is not getting auto-folded. Fix!
 - https://www.reddit.com/r/neovim/comments/wiomf6/any_luck_working_with_foldexpr_and_treesitter/
 - https://github.com/kevinhwang91/nvim-ufo
 - https://www.jmaguire.tech/posts/treesitter_folding/
 - http://vimcasts.org/episodes/writing-a-custom-fold-expression/




```
**Is your feature request related to a problem? Please describe.**
I'm trying to use nvim-treesitter-textobjects to create a blockwise set of select, delete, and movement mappings in Python and other languages but I cannot get a configuration that behaviors as I expected. I don't know if it's a bug or just a configuration issue. If it's a configuration issue, I think adding it as a documentation example would go a long way.

In a file like this (Where `|X|` notes the cursor position)

```python
class Foo2():
    def __init__(self):
        super().__init__()

    def another(self):
        |X|print("more")

    def last(self):
        print("more")
```

I expected `daf` to result in


```python
class Foo2():
    def __init__(self):
        super().__init__()

    def last(self):
        print("more")
```

What I got is

```python
class Foo2():
    def __init__(self):
        super().__init__()

        print("more")
```

Note the removal of `    def last(self):`. This was, I assume, because I set the selection_mode to `["@function.outer"] = "V"`. However if I set `["@function.outer"] = "v"` and place `Foo2` in front of another Python class, it produces another bug, in `last`

Before

```python
class Foo2():
    def __init__(self):
        super().__init__()

    def another(self):
        print("more")

    def last(self):
        |X|print("more")

class Foo3():
    def __init__(self):
        super().__init__()
```

After
```python
class Foo2():
    def __init__(self):
        super().__init__()

    def another(self):
        print("more")

    class Foo3():
    def __init__(self):
        super().__init__()
```

Note that Python has a syntax error now, due to deleting too much (`class Foo3(object):`)

Linewise vs blockwise both produce poor results from what I can see

When playing with the configuration values of `keymaps` and `include_surrounding_whitespace`, I have not found a combination that produces the results that [vim-pythonsense](https://github.com/jeetsukumaran/vim-pythonsense#python-text-objects) provides out of box. But that's only for Python and I want to use nvim-treesitter-textobjects if I can.

I also noticed, perhaps related to this or not, that there are inconsistencies between `vaf + d` vs `daf`. Which might be worth its own bug report ticket.

This is the configuration I've been using, for the most part (but have tried a variety of combinations)

```lua
require("nvim-treesitter.configs").setup {
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = {
          desc = "Select function + whitespace to the next function / class",
          query = "@function.outer",
        },
        ["if"] = {
          desc = "Select function up to last source code line (no trailing whitespace)",
          query = "@function.inner",
        },
        ["ac"] = {
          desc = "Select class + whitespace to the next class / class",
          query = "@class.outer",
        },
        ["ic"] = {
          desc = "Select class up to last source code line (no trailing whitespace)",
          query = "@class.inner",
        },
      },
      selection_modes = {
        ["@class.inner"] = "V",
        ["@class.outer"] = "V",
        ["@function.inner"] = "V",
        ["@function.outer"] = "V",
      },
      include_surrounding_whitespace = function(data)
        local query = data["query_string"]
        local mode = data["selection_mode"]

        if query == "@function.outer" or query == "@class.outer"
        then
          return true
        end

        return false
      end
    },
  },
}
```

I didn't post as a bug report because I don't know if this is the plug-in working as intended. So far, I'm exhausted from trying to get this to work and could use a helping hand.
```







```
**Is your feature request related to a problem? Please describe.**
I'm coming from another vim plugin, [vim-pythonsense](https://github.com/jeetsukumaran/vim-pythonsense#python-text-objects), and am trying to replicate its behavior so that I can use its feature-set not just in Python but across all of the languages that I use. That's where I hoped `nvim-treesitter-textobjects` would come in.

I encountered problems while trying to set this up. At first, I wrote a rather long, text/screenshot message with a (likely configuration) bug report to submit here. Which I'm still happy to send if you'd like to see it. But I figure some GIFs are worth 1000 words and will help make discussing this easier.

If there's a configuration that makes what I'm looking for easy, it'd be really great if it can be added as documentation so other new users can benefit from it. I'm sure I'm not the only one looking to improve their `dac` / `daf` etc motions.


## Expected Behavior
In short, I would like 3 main things from [vim-pythonsense](https://github.com/jeetsukumaran/vim-pythonsense#python-text-objects), but in this plug-in:

- `da{c,f}` deletes the entire class or function. If the class / function is in the top, middle, or bottom, this text-motion-delete should retain the pre/post whitespace from before the motion was ran.
- `di{c,f}` deletes the body of the text object and positions the cursor such that pressing `O` immediately afterwards will place the cursor within the class / function and retain the pre/post whitespace from before the motion was ran
- `]m` / `[m` to jump to the previous class + function. Repeating next / previous spans multiple functions / classes


## vim-pythonsense Out Of Box
Here's vim-pythonsense, doing what I'd mentioned earlier.

### `dif` - Deletes the function body, leaves the cursor in the "right" place
![vim_pythonsense_dif_command](https://user-images.githubusercontent.com/10103049/231349986-39d4d898-7409-48ac-991d-08f05009d237.gif)

### `dic` - Deletes the class body, leaves the cursor in the "right" place
![vim_pythonsense_dic_command](https://user-images.githubusercontent.com/10103049/231350066-d085dc3e-05d1-492c-ae22-7723472b2a89.gif)

### `daf` - Deletes entire function + some whitespace
This isn't 100% what I'd want personally (note that the comment above the function that was deleted was kept) but it is mostly what I would've expected.

![vim_pythonsense_daf_command](https://user-images.githubusercontent.com/10103049/231350336-fcf6d34d-6aea-41b7-97d3-e03170089eea.gif)

### `dac` - Deletes entire class + some whitespace
![vim_pythonsense_dac_command](https://user-images.githubusercontent.com/10103049/231350484-41dc39f0-538a-47e2-ba63-9c278c70fc94.gif)

### `]m` / `[m` - moves between the start of methods, cross-class, back and forth
![vim_pythonsense_bracket_m_movement](https://user-images.githubusercontent.com/10103049/231349867-cf45a2f4-a764-41f1-a966-024cc565c5e4.gif)

### `]M` / `[M` - moves between the end of methods, cross-class, back and forth
![vim_pythonsense_bracket_M_movement](https://user-images.githubusercontent.com/10103049/231349944-d7e200f8-da3e-43ce-b8f1-c419b3fa1d8f.gif)

### `]K` / `[K` - moves between end of classes
![vim_pythonsense_bracket_K_movement](https://user-images.githubusercontent.com/10103049/231350649-291ff3e3-2e0b-424b-95e9-1515ec207150.gif)

There's also a `[k` / `]k` pair but I don't use it much.


## nvim-treesitter-textobjects Out Of Box
I experimented with a combination of `selection_modes` for `@{class,function}.{inner,outer}` as well as `include_surrounding_whitespace` settings, including using a function for `include_surrounding_whitespace` to only return True on `outer (for example).

For what its worth, this entire post might actually be achievable with out of box `nvim-treesitter-textobjects`. I just couldn't get it working so please correct me if there's a way to get what I'm looking for. At any rate, I'll try showing the same keys, `dic` / `dif` / `dac` / `daf` like vim-pythonsense.





## What I Have Now

## GIF Summary

TODO include table, here


**Describe the solution you'd like**
Ideally, a configuration which mimics the shown the functionality and if not, an explanation of what changes could be made to make it possible.

**Describe alternatives you've considered**
As mentioned earlier, I made my own fork of `nvim-treesitter-textobjects` kind of works but still has some flaws.
``




- Silence null-ls errors
  - This file - /home/selecaoone/temp/complex_file.py

```

[null-ls] failed to run generator: ...e/null-ls.nvim/lua/null-ls/helpers/generator_factory.lua:219: error in generator output:
Traceback (most recent call last):
File "/home/selecaoone/.local/bin/pylint", line 10, in <module>
sys.exit(run_pylint())
File "/home/selecaoone/.local/lib/python3.6/site-packages/pylint/__init__.py", line 24, in run_pylint
PylintRun(sys.argv[1:])
File "/home/selecaoone/.local/lib/python3.6/site-packages/pylint/lint/run.py", line 384, in __init__
linter.check(args)
File "/home/selecaoone/.local/lib/python3.6/site-packages/pylint/lint/pylinter.py", line 971, in check
[self._get_file_descr_from_stdin(filepath)],
File "/home/selecaoone/.local/lib/python3.6/site-packages/pylint/lint/pylinter.py", line 1009, in _check_files
self._check_file(get_ast, check_astroid_module, name, filepath, modname)
File "/home/selecaoone/.local/lib/python3.6/site-packages/pylint/lint/pylinter.py", line 1035, in _check_file
check_astroid_module(ast_node)
File "/home/selecaoone/.local/lib/python3.6/site-packages/pylint/lint/pylinter.py", line 1173, in check_astroid_module
ast_node, walker, rawcheckers, tokencheckers
File "/home/selecaoone/.local/lib/python3.6/site-packages/pylint/lint/pylinter.py", line 1217, in _check_astroid_module
walker.walk(ast_node)
File "/home/selecaoone/.local/lib/python3.6/site-packages/pylint/utils/ast_walker.py", line 77, in walk
self.walk(child)
File "/home/selecaoone/.local/lib/python3.6/site-packages/pylint/utils/ast_walker.py", line 74, in walk
callback(astroid)
File "/home/selecaoone/.local/lib/python3.6/site-packages/pylint/checkers/deprecated.py", line 112, in visit_importfrom
basename = get_import_name(node, basename)
File "/home/selecaoone/.local/lib/python3.6/site-packages/pylint/checkers/utils.py", line 1553, in get_import_name
modname, level=importnode.level
File "/home/selecaoone/.local/lib/python3.6/site-packages/astroid/scoped_nodes.py", line 726, in relative_to_absolute_name
raise TooManyLevelsError(level=level, name=self.name)
astroid.exceptions.TooManyLevelsError: Relative import with too many levels (1) for module 'complex_file'
```

## Debugging
:help dap.set_log_level

```
lua require("dap").set_log_level("TRACE")
lua print(vim.fn.stdpath('cache') .. "/dap.log")  -- ~/.cache/nvim/dap.log
```

Use this to show verbose messages on why the debugger doesn't start.
