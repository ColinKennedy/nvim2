- Change :Pcd to print the new directory
- <leader>rr isn't working anymore. Fix!
- Move /home/selecaoone/personal/.config/nvim/lua/my_custom/start/lsp_diagnostics.lua to hybrid2
- Add individual sections - https://github.com/danymat/neogen/issues/165

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

- <leader>rr seems to not work anymore. Fix!
- <leader>ts - Do I still want it?

- Adding doxygen per-type?

- https://www.reddit.com/r/neovim/comments/1abev8d/any_tips_to_optimize_cmp_performance/

- tree-sitter + src/ex_cmds.h is super slow. Figure out why and make it fast again

- How do you align LSP symbols to the right
- <Enter> in a quickfix buffer sometimes doesn't actually go to the selected thing. Fix!
 - Possibly related to ccls not being there (and causing an error)?

https://github.com/HoNamDuong/hybrid.nvim/blob/master/lua/hybrid/highlights.lua
https://github.com/PHSix/nvim-hybrid

https://github.com/idanarye/nvim-blunder


```
warning: Undefined global `vim`.
Error detected while processing TextChangedI Autocommands for "*":
Error executing lua callback: ...nal/.config/nvim/bundle/spaceless.nvim/lua/spaceless.lua:61: attempt to compare nil with numb
er
stack traceback:
        ...nal/.config/nvim/bundle/spaceless.nvim/lua/spaceless.lua:61: in function <...nal/.config/nvim/bundle/spaceless.nvim
/lua/spaceless.lua:55>
        .../.config/nvim/bundle/spaceless.nvim/plugin/spaceless.lua:12: in function <.../.config/nvim/bundle/spaceless.nvim/pl
ugin/spaceless.lua:11>
```

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

- Python navigation textobjects ]k ]c etc are missing

- Merge - https://github.com/danymat/neogen/pull/158
- Merge - https://github.com/nvim-treesitter/nvim-treesitter/pull/5755
- Merge - https://github.com/rcarriga/nvim-dap-ui/pull/309
 - Fix the gross stuff that I forgot to clean in this PR
 - nvim-dap-ui PR - note to self - need to check if parser is installed with vim.inspect(require "nvim-treesitter.info".installed_parsers())


- <Space>GD - single-removed-lines don't quite work. I can't stage the line. Fix
 - The `q` command doesn't delete the current tab correctly

- Consider changing :Rg to be a location list instead of a quickfix list. qflist blows

- Added <Space>CD for Fzf CDing

```
Issues while press pressing <Tab>. Fix?
E5108: Error executing lua ...al/.config/nvim/bundle/nvim-cmp/lua/cmp/utils/keymap.lua:154: Vim:E15: Invalid expression:
stack traceback:
        [C]: in function 'nvim_eval'
        ...al/.config/nvim/bundle/nvim-cmp/lua/cmp/utils/keymap.lua:154: in function 'solve'
        ...al/.config/nvim/bundle/nvim-cmp/lua/cmp/utils/keymap.lua:133: in function <...al/.config/nvim/bundle/nvim-cmp/lua/c
mp/utils/keymap.lua:132>
        ...al/.config/nvim/bundle/nvim-cmp/lua/cmp/utils/keymap.lua:248: in function <...al/.config/nvim/bundle/nvim-cmp/lua/c
mp/utils/keymap.lua:247>

```



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

- The :Rg command is window sizes are still fucked.

- persistent-breakpoints doesn't load as expected. Fix
- vim-git-backup - make into lua, maybe
- searcher / navigation mode ( project, c = class, f = function, m = method, etc)


Fix - Critical
- While in terminal mode, the `git rebase -i master` doesn't work. I cannot <ESC> properly


- Look into Neovim development


```
Failed to source `/home/selecaotwo/repositories/personal/.config/nvim/bundle/vim-ipmotion/plugin/ipmotion.vim`
vim/_editor.lua:0: nvim_exec2()../home/selecaotwo/repositories/personal/.config/nvim/bundle/vim-ipmotion/plugin/ipmotion.vim, line 50: Vim:E492:
Not an editor command: ^M
#
```



- Possibly not needed anymore? - Terminal is really slow at typing, sometimes



- need terminal send / etc code
  - Add tmux support
  - SendRecent! - sends to tmux if both are there
   - config to switch the priority






- Helptags doesn't work anymore. perl error!
 - https://github.com/junegunn/fzf.vim/issues/1506
  - 5d87ac1fe8d729f116bda2f90a7211ad309ddf5a, before perl was introduced as a dependency in 1dcdb21db618055134cd611f4f5918f6d00a5df0. I've locked my version for now to the lower commit but any advice would be appreciated.




https://github.com/dharmx/nvim/blob/e79ac39e3c9aff7e4e99ce889caea45c5fc65bc4/lua/scratch/node.lua
