- Python navigation textobjects ]k ]c etc are missing

- Merge - https://github.com/danymat/neogen/pull/158
- Merge - https://github.com/nvim-treesitter/nvim-treesitter/pull/5755

- ZoomWinToggle loses my place in terminal-normal mode. Annoying!
 - Check on: https://github.com/akinsho/toggleterm.nvim/issues/516
 - Also maybe make a PR for zoomwintoggle
  - https://github.com/troydm/zoomwintab.vim/pull/16


- <Space>GD - single-removed-lines don't quite work. I can't stage the line. Fix
 - The `q` command doesn't delete the current tab correctly

- Consider changing :Rg to be a location list instead of a quickfix list. qflist blows





- :Rg is so annoying. It changes the size of the window!
 - It's because of `vim.opt.laststatus = 3`, somehow. Make a reproduction
 - vimgrep also has this problem

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
