- Change snippets to not exit whenever I go into Normal mode

- <Space>G doesn't work if the current file isn't in a reasonable hunk (the fallback logic isn't working)
- Might possibly also not be able to handle submodules as expected

- The :Rg command is window sizes are still fucked.

- Figure out how to do real persistent undo
- persistent-breakpoints doesn't load as expected. Fix
- /bin/bash: par: command not found - Add an "auto-install par" script
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
