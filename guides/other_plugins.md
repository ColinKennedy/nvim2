## Rest Plugins
Website development and other stuff

- https://github.com/rest-nvim/rest.nvim

## Databases
- https://github.com/tpope/vim-dadbod
- https://github.com/kristijanhusak/vim-dadbod-ui
- https://github.com/kristijanhusak/vim-dadbod-completion

## Working With Remotes
https://github.com/chipsenkbeil/distant.nvim

## iOS stuff
https://github.com/wojciech-kulik/xcodebuild.nvim

## Appearance
Pretty quickfix buffer - https://github.com/folke/trouble.nvim
https://github.com/yorickpeterse/nvim-pqf

```lua
{
    "brenoprata10/nvim-highlight-colors",
    config = function()
        vim.cmd[[
            set termguicolors
            set t_Co=256
        ]]

        require('nvim-highlight-colors').setup {}
    end
}
```


## Possibly Useful
https://github.com/bfredl/nvim-miniyank
https://github.com/dlvhdr/gh-addressed.nvim?tab=readme-ov-file
https://github.com/dlvhdr/gh-blame.nvim
https://github.com/yioneko/nvim-yati
https://www.reddit.com/r/neovim/comments/1amp8hm/spookynvim_motionplugin_agnostic_remote_text/
https://github.com/tamton-aquib/keys.nvim

https://github.com/LunarVim/bigfile.nvim - Disable slow stuff while in big files

https://github.com/Willem-J-an/nvim-dap-powershell

https://github.com/Jezda1337/nvim-html-css

https://github.com/DNLHC/glance.nvim

https://github.com/rizsotto/Bear

https://github.com/emmanueltouzery/decisive.nvim?tab=readme-ov-file

https://github.com/Fildo7525/reloader.nvim

https://github.com/paopaol/cmp-doxygen

https://github.com/rcarriga/cmp-dap

https://github.com/davidsierradz/cmp-conventionalcommits

https://github.com/cvusmo/LinuxUnrealBuildTool.nvim

https://www.reddit.com/r/neovim/comments/1dpzlfr/kulalanvim_a_minimal_httpclient_interface_for/

- Really pretty gitk alternative - https://github.com/isakbm/gitgraph.nvim

- Really cool sidebar minimap - Isrothy/neominimap.nvim

- Possibly useful? https://github.com/CWood-sdf/banana.nvim

- LSP textDocument/documentLink support for neovim - https://github.com/icholy/lsplinks.nvim

- REST / CURL queries - https://www.reddit.com/r/neovim/comments/1eqrnz2/kulalanvim_v300_is_in_the_wild/

- Remote devcontainers, ran through Neovim
    - https://github.com/amitds1997/remote-nvim.nvim
    - https://cadu.dev/running-neovim-on-devcontainers/
    - https://github.com/erichlf/devcontainer-cli.nvim


- zh / zl scrolls virtual text - https://www.reddit.com/r/neovim/comments/1ewps7u/newbie_question_how_to_scroll_virtual_text/

- structured (nvim-treesitter) search and replace - https://github.com/cshuaimin/ssr.nvim

https://github.com/matkrin/telescope-spell-errors.nvim


Also it looks like there's a way to show a markdown file as presentation slides. Not sure how!

- Writing markdown - https://github.com/Piotr1215/youtube/blob/main/nvim-markdown/slides.md
    - https://github.com/jubnzv/mdeval.nvim

- Sort basedon tree-sitter nodes - https://github.com/mtrajano/tssorter.nvim

- git graph, with neovim - https://www.reddit.com/r/nvim/comments/1egpnsv/pretty_git_graph_using_kitty_and_vimflog/

https://github.com/vigoux/architext.nvim

- A HTML renderer in Neovim - https://github.com/CWood-sdf/banana.nvim

- Swap arguments (contains text objects) - https://github.com/machakann/vim-swap

- SideFX Houdini integration - https://github.com/TheBlob42/houdini.nvim

- Doesn't seem to work - https://github.com/shortcuts/no-neck-pain.nvim


- A command to help you learn Neo/Vim commands - https://www.reddit.com/r/neovim/comments/1fhbo7j/livecommandnvim_v200_just_released_new_preview/

- Allow lowercase vim commands - https://github.com/gcmt/cmdfix.nvim

- Faster web searches - https://github.com/Aliqyan-21/wit.nvim

- Kubernetes CLI interactive viewer - https://github.com/Ramilito/kubectl.nvim

- RSS Feed Reader - https://github.com/neo451/feed.nvim

- Neovim Remote Helper - https://github.com/mikew/nvrh. Works with a remote Neovim instance

- Profiler plugin, uses perf to show profile statistics in-line - https://github.com/t-troebst/perfanno.nvim

- A useful color picker - https://github.com/eero-lehtinen/oklch-color-picker.nvim

- Loading large files quickly - https://github.com/pteroctopus/faster.nvim?tab=readme-ov-file

- Really nice color picker
 - https://www.reddit.com/r/neovim/comments/1h44ibi/oklchcolorpickernvim_a_new_color_picker_and/
 - https://github.com/eero-lehtinen/oklch-color-picker.nvim

- Presentation - https://github.com/Piotr1215/typeit.nvim
 - Simulate typing

- Fill inline hints into the buffer - https://github.com/davidyz/inlayhint-filler.nvim

- A concurrency plugin that might be useful - https://github.com/gregorias/coop.nvim

- https://www.reddit.com/r/neovim/comments/1hfy3uz/dynamic_inlay_hints_with_inlayhintnvim/
 - remove inlay hints but only for the current cursor line

- Note-taking plugins
 - https://github.com/zk-org/zk-nvim
 - https://github.com/wsdjeg/vim-zettelkasten

- Display the keys that are currently being pressed - https://github.com/wsdjeg/record-key.nvim

- Environment variable auto-complete - https://github.com/philosofonusus/ecolog.nvim

- Javascript / JS style async promises API - https://github.com/izelnakri/async.nvim


## Python Development
virtual environment selector -
https://github.com/linux-cultist/venv-selector.nvim
https://github.com/neolooong/whichpy.nvim


## Probably not that useful
https://github.com/topaxi/gh-actions.nvim

- Fun but not that useful - https://github.com/rthrfrd/heatscroll


- Markdown live preview LSP(?) - https://github.com/mhersson/mpls


## In theory useful but don't seem to work
https://github.com/briangwaltney/paren-hint.nvim
https://github.com/code-biscuits/nvim-biscuits
