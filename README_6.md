https://github.com/xzbdmw/colorful-menu.nvim
git add -p clone
 - On last hunk staged, auto-exit

- profiler work
 - Make a working profiler tool
  - integrates with GitHub things, on-release

 - Make it into a GitHub action

- nvim-dap-ui disassembly view
 - extend the assembly parser so that it can be used to target registers and offsets more easily

https://github.com/jake-stewart/force-cul.nvim

https://github.com/neovim/neovim/commit/c830901e8cde49467d1c99c2d656a13e51979790
 - Add complete highlight group

https://github.com/echasnovski/mini.bracketed
 - Try this out

Fix this broken case
```
def _ellipses_arguments(node: tree_sitter.Node, data: bytes) -> list[bytes]:
    """Create snippets that tell the AI "there needs to be text here. Please fill in".

    .. code-block:: python

        def foo(???) -> None:
            ...

    The above example tells the AI "the contents for ()s is non-empty, please
    fill it in".

    Args:
        node: Some tree-sitter node to start from. e.g. a class or function.
        data: The source code to query from.

    Yields:
        [TODO:description]
    """
    def _is_collapsible(node: tree_sitter.Node) -> bool:
        return node.type in {"parameters", "argument_list"}

    def _iter_all_leaf_nodes_modified(
        node: tree_sitter.Node,
    ) -> typing.Generator[tuple[bool, tree_sitter.Node], None, None]:
        stack = [node]

        while stack:
            node = stack.pop()

            if node.child_count == 0:
                yield False, node

                continue

            if _is_collapsible(node):
                yield True, node

                continue

            for child in reversed(node.children):
                stack.append(child)

    # Before:
    # def foo(some: int, thing: float) -> None:
    #     _call_something(some)

    # After:
    # def foo(???) -> None:
    #     _call_something(???)

    output: list[bytes] = []
    reduction_values = [0.1, 0.2, 0.4, 0.6, 0.7, 0.8, 0.9]

    for reduction in reduction_values:
        found = False
        previous: typing.Optional[tree_sitter.Node] = None
        case = b""

        for is_collapsible, child in _iter_all_leaf_nodes_modified(node):
            if found:
                previous = _get_previous_whitespace_node(child)

            found = True

            if previous is not None:
                # TODO: We could be more efficient (move the if out of the for loop)
                case += data[previous.end_byte : child.start_byte]

            if is_collapsible and random.random() < reduction:
                case += _NEEDS_EXPANSION_MARKER
            else:
                case += data[child.start_byte : child.end_byte]

        output.append(case)

    return output
```

Accidentally includes Raises: even though it shouldn't
```
def _get_module_namespaces(node: tree_sitter.Node, data: bytes) -> list[bytes]:

    """Find all Python imports within ``node`` and get their referenceable text.

    .. code-block:: python

        from .relative import foo
        from .relative.parent import bar
        from .blah.thing import stuff as thing
        from .parentheses.stuff import (first as first_, stuff, last as lasty)

        from absolute import absolutely
        from absolute.inner import core
        from multi.inner import child1, child2
        from aliased.thing import original as alias
        from complexy.one import (
            fizz as buzz,
            # Inner comment
            middle,
            stuff as final1,
        )

        import thing
        import thing2 as asdfbbb
        import nested.blah.final
        import nested.blah.final as too

        import thing2 as asdfbbb, thingz, something.ealse
        import thing2 as asdfbbb, thingz, something.ealse

        # Would return:
        # absolutely
        # alias
        # bar
        # buzz
        # child1
        # child2
        # core
        # final1
        # first_
        # foo
        # lasty
        # middle
        # stuff
        # thing

    Args:
        node: The tree-sitter Python module to search within.
        data: The source code to query from.

    Returns:
        [TODO:return]
    """
    def _get_import_namespace(
        node: tree_sitter.Node, data: bytes, start_index: int
    ) -> list[bytes]:
        output: list[bytes] = []

        # NOTE: We skip the ``import`` keyword by starting at ``1``.
        for index in range(start_index, node.child_count):
            child = node.child(index)

            if not child:
                raise RuntimeError(f'Index "{index}" has no child in "{node}" node.')

            if child.type == "dotted_name":
                output.append(_get_node_text(child, data))
            elif child.type == "aliased_import":
                namespace_identifier = child.named_child(child.named_child_count - 1)

                if not namespace_identifier:
                    raise RuntimeError(f'Child "{child}" has no namespace identifier.')

                output.append(_get_node_text(namespace_identifier, data))

        return output

    def _get_import_from_statement_namespaces(
        node: tree_sitter.Node, data: bytes
    ) -> list[bytes]:
        return _get_import_namespace(node, data, 3)

    def _get_import_statement_namespaces(
        node: tree_sitter.Node, data: bytes
    ) -> list[bytes]:
        return _get_import_namespace(node, data, 1)

    def _get_root_node(node: tree_sitter.Node) -> typing.Optional[tree_sitter.Node]:
        current: typing.Optional[tree_sitter.Node] = node
        previous: typing.Optional[tree_sitter.Node] = None

        while current:
            previous = current
            current = current.parent

        return previous

    output: list[bytes] = []
    root = typing.cast(tree_sitter.Node, _get_root_node(node))

    for child in _iter_all_nodes(root):
        if child.type == "import_from_statement":
            output.extend(_get_import_from_statement_namespaces(child, data))
        elif child.type == "import_statement":
            output.extend(_get_import_statement_namespaces(child, data))

    return output
```


https://github.com/smilhey/ed-cmd.nvim

https://www.reddit.com/r/neovim/comments/1g8jeyn/ccls_and_lsp_semantic_tokens/

https://gregorias.github.io/posts/using-coroutines-in-neovim-lua/

https://www.youtube.com/watch?v=G3NKwhWv8x0

https://github.com/ck-zhang/mistake.nvim/blob/main/lua/mistake/dict.lua


https://github.com/neo451/feed.nvim

https://github.com/ck-zhang/mistake.nvim



- Looks really cool - https://github.com/t-troebst/perfanno.nvim



- git-signs plugin commit: 2c2463d. Roll back to this

github.com/LunarVim/bigfile.nvim
https://github.com/LazyVim/LazyVim/commit/938a6718c6f0d5c6716a34bd3383758907820c52#diff-c23db92fd0640198b1eb7ac514d6b8d815a2abcc1494f479d2f3c8f573ba3c0cR136


https://www.reddit.com/r/neovim/comments/1gi9iut/beta_symbolsnvim_code_outline_sidebar_my_first/

https://www.reddit.com/r/neovim/comments/1ghh4so/pickls_the_general_purpose_language_server_for/
https://github.com/mattn/efm-langserver


https://www.reddit.com/r/neovim/comments/1fwxa8b/comment/lqlqlm8/
https://github.com/alexpasmantier/pymple.nvim

https://github.com/lucaSartore/nvim-dap-exception-breakpoints

- Make a "recommend class/function position" function
 - takes the function definition under the cursor
 - tree-sitter based
 - search all functions
  - Finds the first place alphabetically where the class/function should go
   - Moves the cursor to it

https://www.reddit.com/r/neovim/comments/1fqdy28/introducing_my_first_plugin_hereterm_toggle/

- does tmux-ressurect still work?

- Why are my macros running so slowly?

https://github.com/ColinKennedy/telescope-session-viewer.nvim
https://github.com/ColinKennedy/simple-session.nvim

- Add a :Rg command the runs from the current buffer's directory
- tmux-ressurect isn't grabbing session files anymore. Probably  because I removed the tpope plugin. Fix!


- check - https://github.com/SleepySwords/change-function.nvim/issues/6#event-13897533982


https://github.com/akinsho/git-conflict.nvim

- https://github.com/MisanthropicBit/neotest-busted

- Add color to the telescope selector icon
 - telescope color gets cleared somehow. Fix?

- Make a quickfix search searcher

https://www.reddit.com/r/neovim/comments/1embbrf/my_top_10_neovim_plugins_with_demos/

https://www.reddit.com/r/nvim/comments/1egpnsv/pretty_git_graph_using_kitty_and_vimflog/
https://www.reddit.com/r/neovim/comments/1egwjgp/anyone_using_difftastic_with_fugitivevim/

https://github.com/svampkorg/moody.nvim

https://github.com/mvllow/modes.nvim



https://github.com/neovim/neovim/issues/27509



https://www.reddit.com/r/neovim/comments/1el3g8i/grugfarnvim_update_support_for_astgrep_syntax/




- Figure out inline diagnostics. They're weirdly inconsistent
    - "rachartier/tiny-inline-diagnostic.nvim", is pretty though

- https://github.com/ysmb-wtsg/in-and-out.nvim

- How to save past qf queries? (If it isn't just a default behavior)


https://www.reddit.com/r/neovim/comments/1dyq2ez/what_do_you_think_of_my_cmp_thesaurus_neovim/


https://www.reddit.com/r/neovim/comments/1dy5z0n/leapnvim_remote_operations_with_visual_feedback/

https://github.com/ColinKennedy/hide-verbose-comments
https://github.com/ColinKennedy/assembly-explorer.nvim
https://github.com/ColinKennedy/neotest-cmake-ctest
https://github.com/ColinKennedy/ai-mode.nvim
https://github.com/ColinKennedy/timeline.nvim

How do you restart (attached) LSPs?


https://github.com/MagicDuck/grug-far.nvim


## Anki
Mapping to open a URL
nmap: `gx`

## Misc



- navigate
- search
- display (stuff)
- edit
- refactor
- infer
- container integrations?

- macros
- spelling
- assembly
- timeline


- https://github.com/TheBlob42/houdini.nvim


https://seniormars.com/posts/neovim-workflow/

https://github.com/OXY2DEV/markview.nvim

- https://github.com/neovim/neovim/pull/24565
 - Add lazyredraw once this is merged

https://www.reddit.com/r/neovim/comments/1dpww7b/finally_managed_to_integrate_lsp_servers_and/

that plugin that puts the commandline in te center of the screen might be a good addition


https://github.com/Ramilito/winbar.nvim

https://github.com/sleepyswords/change-function.nvim

https://github.com/FireIsGood/spaceman.nvim


https://github.com/ravibrock/spellwarn.nvim

https://github.com/echasnovski/mini-git


- https://www.reddit.com/r/neovim/comments/1d5orqz/open_files_from_windows_file_explorer_in_wsl/

- Apparently neodev isn't needed anymore - https://github.com/neovim/neovim/pull/24592

https://www.reddit.com/r/neovim/comments/1cxgfqk/mestizonvim_a_dark_theme_for_those_who_dont_leave/

Consider
https://github.com/brenoprata10/nvim-highlight-colors

- Add back in "dil" textobjects

- https://github.com/MeanderingProgrammer/markdown.nvim

- https://github.com/daniilrozanov/cmake.nvim
 - async loading?


I have coworkers who speak English as a second or even third language. To make my docstrings and documentation easier to understand, I added a restriction - "You may only use 1000 unique words" and made myself a list. Still, even though I made that list, I accidentally would still write words like "detected" instead of "found", "generate" instead of "create", "extract" instead of "get", etc. Old habits die hard.

spellbound.nvim exists in order to:

- Help point out hard words and suggest easier words instead
- Jump to these suggested words easily
- View suggestions entire projects

A nice side effect of this plugin - if docstrings are easier for second/third English speakers, chances are its even easier to read for native speakers too.

I have a setup that works well but spellbound.nvim is an attempt to make a generic plugin
that others can use. If you try this out, please let me know how it goes for you. Thanks!





- Update commands and remaps documentation

https://github.com/jakobkhansen/journal.nvim

- I want a ]f for moving between functions again. And ]m

- A mapping that iterates over spelling suggestions

- Remove virtual text for LSP / linter errors

- ]q and [q sequencing is completely broken
 - repro:
  - /home/selecaoone/repositories/personal/.config/nvim/bundle/git-extended-statusline/lua/git-extended-statusline/_core/display.lua
  - search _LOGGER and ]q / [q around

https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L890-L908


https://stackoverflow.com/questions/44237255/automatic-display-of-git-status-in-linux-bash

https://github.com/ohmyzsh/ohmyzsh

https://github.com/romkatv/gitstatus

https://github.com/magicmonty/bash-git-prompt

```
Mode: normal
Mapping: <leader>ts
Changes the user's current buffer for a terminal buffer (toggles between the two)
```


https://www.reddit.com/r/neovim/comments/1ckvoxr/fzflua_added_builtin_support_for_vscode_like_path/

https://www.reddit.com/r/neovim/comments/1cktb6k/comment/l2paq1t/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
https://github.com/hieulw/nvimrc


- https://github.com/farmergreg/vim-lastplace

- Update all plugins to their latest version
 - debugprint got a new major version (for example)

https://gist.github.com/romainl/7e2b425a1706cd85f04a0bd8b3898805

https://github.com/neovim/neovim/commit/688860741589b4583129e426f4df0523f9213275

https://www.reddit.com/r/neovim/comments/1ca3rm8/shoutout_to_andrewferrierdebugprintnvim_add/
 - What a coincidence! I'll need to update. Thankfully you've been using git tags so it should be pretty painless. I might just deprecate my mappings and use the text object defaults.

- Update debugprint to v2+
https://github.com/andrewferrier/debugprint.nvim
 - It provides commands to delete all debugging lines added to the current buffer as well as comment/uncomment those lines.

- https://www.reddit.com/r/neovim/comments/1c9ftdp/how_to_turn_off_code_suggestions_in_strings/

- @lsp.mod.defaultLibrary - Make it purple! like the others
- tmux rename window - color should be yellow or white, not red
- tmux "more tabs" arrow could be a better color. Right now it's blue

Similar comments. Gross!

```
# "Quick Fill" divider
mc.menuItem(divider=True, dividerLabel="Quick Fill", parent=parent)

# "Update all assets to latest" menu item
mc.menuItem(
    command=_update_all_assets_to_latest,
    label="Update all assets to latest",
    parent=parent,
)

# "Update selected assets to latest" menu item
mc.menuItem(
    command=_update_selected_assets_to_latest,
    label="Update selected assets to latest",
    parent=parent,
)

# "Remove selected assets" menu item
mc.menuItem(
    command=_remove_selected_assets,
    image="/path/to/icon.png"
    label="Remove selected assets",
    parent=parent,
)
```

https://github.com/tamton-aquib/keys.nvim
https://github.com/roobert/f-string-toggle.nvim
https://github.com/rktjmp/fwatch.nvim
https://github.com/dhruvasagar/vim-highlight-word
https://dotfyle.com/this-week-in-neovim/47#zootedb0t/citruszest.nvim
https://gitlab.com/madyanov/svart.nvim
https://github.com/marilari88/twoslash-queries.nvim
https://github.com/barrett-ruth/import-cost.nvim
https://github.com/roobert/action-hints.nvim
https://github.com/willothy/savior.nvim
https://github.com/willothy/wezterm.nvim

- Plugins that could benefit from persistent windows
 - nvim-tree
 - symbols-outline.nvim  SymbolsOutline  <Space>SO
 - diffview.nvim
 - hydra.nvim  <Space>GD  <Space>GG  <Space>D
 - nvim-dap-ui
 - undotree  UndotreeToggle
 - vim-fugitive
 - zoxide

 - Make it work for a terminal or tmux
- Add lc / sc snippets back

toggleterm + sessions. Get this working

vim.lsp: File watcher ~
- File watch backend: libuv-watchdirs
- WARNING libuv-watchdirs has known performance issues. Consider installing fswatch.

- https://github.com/folke/neodev.nvim/issues/98

- Add back in if / ik & af / aK for functions and classes

- Once async tree-sitter parsing is possible, consider re-adding winbuf for Lua
  files (currently it is disabled because it was too slow)

- Ask this to support winfixbuf
 - https://github.com/mbbill/undotree
 - vim-fugitive
 - diffview.nvim

- Weird Lualine flashing when switching buffers. Fix
 - https://github.com/mrjones2014/smart-splits.nvim/issues/179

- Move /home/selecaoone/personal/.config/nvim/lua/my_custom/start/lsp_diagnostics.lua to hybrid2

When resizing the disassembly buffer, I get this error
Fix
```
Error executing vim.schedule lua callback: .../bundle/nvim-dap-ui/lua/dapui/components/disassembly.lua:555: Cursor position outside buffer
stack traceback:
        [C]: in function 'nvim_win_set_cursor'
        .../bundle/nvim-dap-ui/lua/dapui/components/disassembly.lua:555: in function <.../bundle/nvim-dap-ui/lua/dapui/components/disassembly.lua:554>
Error executing vim.schedule lua callback: .../bundle/nvim-dap-ui/lua/dapui/components/disassembly.lua:555: Cursor position outside buffer
stack traceback:
        [C]: in function 'nvim_win_set_cursor'
        .../bundle/nvim-dap-ui/lua/dapui/components/disassembly.lua:555: in function <.../bundle/nvim-dap-ui/lua/dapui/components/disassembly.lua:554>
```

- Try this out - https://github.com/jvgrootveld/telescope-zoxide
- https://gitlab.com/yorickpeterse/nvim-pqf

- Check up on https://github.com/folke/lazy.nvim/issues/1343
- Change nvim-lspconfig to trigger if gd / gf or some other mapping is pressed

- kevinhwang91/nvim-bqf is causing the <CR> (Enter) key not to work. Fix!
- Re-add lua to winbar. Find out why it's slow and fix
- Try out Nvim 0.10's `nvim -q -` for loading files into the quickfix

- get my cool git add -p working on Neovim again


- Figure out how to get this while keeping my put plugin
https://github.com/bfredl/nvim-miniyank

Try out one of these
```
https://github.com/wsdjeg/vim-fetch
https://github.com/bogado/file-line
https://github.com/lervag/file-line
```

- <leader>ts - Do I still want it?

- Adding doxygen per-type?

- https://www.reddit.com/r/neovim/comments/1abev8d/any_tips_to_optimize_cmp_performance/

https://github.com/debugloop/layers.nvim
- consider replacing hydra with this

- tree-sitter + src/ex_cmds.h is super slow. Figure out why and make it fast again

- How do you align LSP symbols to the right
- <Enter> in a quickfix buffer sometimes doesn't actually go to the selected thing. Fix!
 - Possibly related to ccls not being there (and causing an error)?

https://github.com/HoNamDuong/hybrid.nvim/blob/master/lua/hybrid/highlights.lua
https://github.com/PHSix/nvim-hybrid

https://github.com/idanarye/nvim-blunder

- pylance, try it out
- Update hybrid2 to deal with LSP colors


- Check on https://github.com/jdrupal-dev/code-refactor.nvim in a few months



- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
 - black
 - debugpy
 - isort
 - mypy
 - pylint
 - pydocstyle
 - ruff
- Or maybe do none-ls?
- https://www.youtube.com/watch?v=jWZ_JeLgDxU
- https://youtu.be/jWZ_JeLgDxU?si=gAMaE5a-mNA0BQca&t=333
 - https://github.com/bcampolo/nvim-starter-kit/tree/python#neovim-starter-kit-for-python-
 - <leader>di to show information under the cursor?
 - You can use dap somehow to run unittests????


- Abbreviations don't trigger. Why? Possibly cmp related
<Space>GD goes to the wrong tab when the command ends. Fix

Request jumplist support for debugging

Often when debugging it's useful to step quickly through the code until some area of interest is found. Sometimes you realize that you've past the area of interest and are actually now in a different function, with a different call stack. If we had `<c-p>`/`<c-o>` to go backwards, we'd be able to effectively retrace the movements of the debugger to get to the current point. However to use `<c-p>`/`<c-o>`, (Neo)vim requires cursor positions to be added to the jump list.

- Merge - https://github.com/danymat/neogen/pull/158
- Merge - https://github.com/nvim-treesitter/nvim-treesitter/pull/5755
- Merge - https://github.com/rcarriga/nvim-dap-ui/pull/309
 - Fix the gross stuff that I forgot to clean in this PR
 - nvim-dap-ui PR - note to self - need to check if parser is installed with vim.inspect(require "nvim-treesitter.info".installed_parsers())


- <Space>GD - single-removed-lines don't quite work. I can't stage the line. Fix
 - The `q` command doesn't delete the current tab correctly

- Consider changing :Rg to be a location list instead of a quickfix list. qflist blows

- Added <Space>CD for Fzf CDing


- viI mapping doesn't work anymore. FIX
- Add groups to all vim.api.nvim_create_autocmd( commands

- Assembly viewer - https://github.com/neovim/neovim/issues/19708
    - Implement a "VisualChanged" event

- Auto-install any dependencies (like servers and such)
    - https://www.reddit.com/r/neovim/comments/171erkj/python3_provider_when_pep_668_is_adopted_by_your/k3qu6zz/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
        - https://github.com/wookayin/dotfiles/blob/master/nvim/lua/config/pynvim.lua#L73-L110


- Change snippets to not exit whenever I go into Normal mode

- <Space>G doesn't work if the current file isn't in a reasonable hunk (the fallback logic isn't working)
- <Space>G doesn't work cross-files all of the time. Probably replace that whole logic
- Might possibly also not be able to handle submodules as expected

- searcher / navigation mode ( project, c = class, f = function, m = method, etc)


- need terminal send / etc code
  - Add tmux support
  - SendRecent! - sends to tmux if both are there
   - config to switch the priority


https://github.com/dharmx/nvim/blob/e79ac39e3c9aff7e4e99ce889caea45c5fc65bc4/lua/scratch/node.lua
