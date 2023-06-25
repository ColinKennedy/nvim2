Add USD to Comment.nvim
https://github.com/numToStr/Comment.nvim#treesitter

https://alpha2phi.medium.com/neovim-for-beginners-lua-autocmd-and-keymap-functions-3bdfe0bebe42

https://github.com/brainfucksec/neovim-lua/blob/main/nvim/lua/core/autocmds.lua

https://www.youtube.com/watch?v=stqUbv-5u2s

https://www.youtube.com/watch?v=w7i4amO_zaE&t=1464s

https://www.youtube.com/watch?v=kdP4ZHE4Bx4

https://www.youtube.com/watch?v=HR1dKKrOmDs&t=29s

- For some reason when I leave dap, the <F5> mapping gets unset. Why? Fix.


- Go through checkhealth stuff
- Do the rest of the TODO notes
- Make sure to defer load as much as possible

[null-ls] failed to run generator: ...1/colin-k/nvim2/bundle/null-ls.nvim/lua/null-ls/loop.lua:237: failed to create temp file: EROFS: read-only file system: /path/to/read/only/site-packages/pyblish_lite/.null-ls_559820_window.py


- null-ls's pylint isn't taking into account PYTHONPATH, even though it acutally is importable
 - See sphinx-code-include


- https://github.com/nvim-treesitter/completion-treesitter
 - Is it possible to get treesitter keywords in auto-completion, as a completion source?



- Add lua auto-complete?



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


- Ask treesitter people about module highlighting
 - Can Python highlight based on modules?
- Is it possible to add devicons / LSP information into Command mode?

- Sometimes BackupCurrentFile is slow. Consider rewriting in Lua

Fix Neogen broken docstring output

```
**kwargs docstrings are broken, in Python
def __init__(self, **kwargs):
        super(Foo, self).__init__()
        self.gui_kwargs = kwargs
        self.dockName = self.gui_class.object_name
        self.panelWidth = 400
        self.type = "dialog"

So is *args
```


I've been using w0ng/vim-hybrid as my colorscheme for 8 years and I really like it. Recently I've been trying to embrace neovim rather than treating it as a "Vim + terminal / debugger". During that journey, I downloaded nvim-treesitter and was frankly underwhelmed by its syntax highlighting. I see potential so I'd love to make it work but I'm having trouble pinning down where the problem exactly lives. Is it treesitter's parse? vim-hybrid? Or something completely different. I was hoping for some Neovim community advice :)

Here's a screenshot of what I see
Without treesitter (normal Python syntax highlighting)
With treesitter

- Change af / if to match preceding comment lines. For God's sake
 - https://github.com/nvim-treesitter/nvim-treesitter-textobjects/discussions/452







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





```
If I have a file buffer, a terminal buffer, and a quickfix buffer all open at once with this layout

    +------------+
    |            |
    |    file    |
    |            |
    +------------+
    |            |
    |  terminal  |
    |            |
    +------------+
    |  quickfix  |
    +------------+

Usually not but sometimes when I press use \`:.cc\` to go do the selected QuickFix line, (n)vim switches the terminal buffer to that QuickFix line, not the file buffer. This is never what I want to have happen. Is there a way to have (n)vim choose the file buffer, instead?
```
