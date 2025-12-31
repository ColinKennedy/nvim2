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

- Python integration, worth looking into - https://github.com/joshzcold/python.nvim

https://github.com/paopaol/cmp-doxygen

https://github.com/rcarriga/cmp-dap

https://github.com/davidsierradz/cmp-conventionalcommits

- https://github.com/cvusmo/LinuxUnrealBuildTool.nvim
- https://github.com/mbwilding/UnrealEngine.nvim

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

- Fun JSON viewer - https://github.com/Owen-Dechow/videre.nvim

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

- netrw + icons - https://gist.github.com/AndrewRadev/ea55ba1923da3f5074cad06144e8aed3

- cmake LSP - https://github.com/regen100/cmake-language-server

- Neovim documentation chatbot - https://gooey.ai/chat/vimbo-VYm/
 - Someone must be hosting this but I'm not sure who / how this was generated.

- CSV viewer (shown as a table) - https://github.com/hat0uma/csvview.nvim

- oil.nvim
 - LSP diagnostic icons for oil.nvim - https://github.com/JezerM/oil-lsp-diagnostics.nvim?tab=readme-ov-file
 - Git symbols for oil.nvim - https://github.com/benomahony/oil-git.nvim
 - Git symbols for oil.nvim - https://github.com/refractalize/oil-git-status.nvim

- LSP log viewer - https://github.com/mhanberg/output-panel.nvim

- multi-line inline LSP diagnostics
 - https://sr.ht/~whynothugo/lsp_lines.nvim/
 - https://github.com/rachartier/tiny-inline-diagnostic.nvim

- email client (wraps another called "notmuch") - https://github.com/yousefakbar/notmuch.nvim?tab=readme-ov-file

- A useful plugin that approximates the time it takes to read text - https://github.com/nick-skriabin/timeline.nvim

- A grammar(?) spell check LSP - https://github.com/Automattic/harper/blob/master/harper-ls/README.md

- A tool that supporedly makes it easier to copy code to a LLM - https://github.com/YounesElhjouji/nvim-copy

- multi-cursor https://github.com/jake-stewart/multicursor.nvim

- Pretty menus in Neovim - https://github.com/nvzone/menu

- SSH connection manager? https://github.com/epheien/conn-manager.nvim

- Possibly more useful "go to GitHub link" plugin - https://github.com/trevorhauter/gitportal.nvim


- Documentation related
https://github.com/mhausenblas/mkdocs-deploy-gh-pages
lua-doc-extractor
- npm lua-doc-extractor
https://github.com/squidfunk/mkdocs-material
https://squidfunk.github.io/mkdocs-material/creating-your-site/


- IDA Pro (Interactive Disassembler) + Neovim - https://www.reddit.com/r/neovim/comments/1iie9ix/re_with_ida_pro_and_telescope/
 - https://github.com/dead-null/idascope



- Code security layer to prevent sending bad / sensitive data to AIs - https://www.reddit.com/r/neovim/comments/1iwdv9s/codegatenvim_privacy_security_for_llmbased_coding/
 - https://docs.codegate.ai/

- surround text
 - https://github.com/altermo/ultimate-autopair.nvim?tab=readme-ov-file
 - https://www.reddit.com/r/neovim/comments/1iw5udx/claspnvim_fast_wrap_your_missing_pair_with/
 - https://github.com/kylechui/nvim-surround



- Calculator plugin - https://github.com/Apeiros-46B/qalc.nvim
- google calendar updater script- https://github.com/TheLeoP/nvim-config/blob/master/lua/personal/calendar.lua



https://github.com/ravitemer/mcphub.nvim
- MCP Server installer


- Unittest visualizer - https://github.com/Davidyz/coredumpy.nvim


- Useful for copying snippets of files (outside of git / GitHub) - https://www.reddit.com/r/neovim/comments/1je33gm/new_vim_plugin_copy_with_context_share_code/


- git worktrees (still no idea why someone would want worktrees) - https://github.com/afonsofrancof/worktrees.nvim


- Useful for annotating files (but does not save them to disk). Good for presentations - https://github.com/jake-stewart/vmark.nvim
 - https://github.com/LintaoAmons/bookmarks.nvim
 - https://github.com/kristijanhusak/line-notes.nvim



- REST client interface - https://github.com/mistweaverco/kulala.nvim

- NVIM DAP Docker, amazing - https://github.com/docker/nvim-dap-docker

- Hex viewer - https://github.com/CameronDixon0/hex-reader.nvim?tab=readme-ov-file

- Record from Neovim - https://github.com/ekiim/vim-recording-studio

- A CPP Insights integrator - There might be better ones out there - https://github.com/Freed-Wu/cppinsights.vim

- SQL in Vim with no plugins? - https://www.youtube.com/watch?time_continue=142&v=-TADlLgCQL4&embeds_referring_euri=https%3A%2F%2Fwww.reddit.com%2F

- Presentation in the terminal - https://github.com/Piotr1215/presenterm.nvim

- uv support, in Neovim
 - https://github.com/benomahony/uv.nvim
 - https://www.reddit.com/r/neovim/comments/1o6g7ep/uvneovimpython_lsps/
 - https://kuator.github.io/neovim/uv/basedpyright/pyrefly/ty/2025/10/14/uv-python-lsps-neovim.html

- A file explorer - https://github.com/A7Lavinraj/fyler.nvim

- A quick harpoon replacement - https://www.reddit.com/r/neovim/comments/1og2pg9/mom_can_i_have_harpoon_we_have_harpoon_at_home/

- Inspect HTML elements live, in Neovim, using svelte
 - https://jovianmoon.io/posts/svelte-inspector-with-neovim
 - https://www.reddit.com/r/neovim/comments/1pk1rkd/svelte_neovim_psa_connect_the_svelte_inspector_to/


- A SSH + filesystem plugin that has no dependencies. It could be useful! - https://github.com/uhs-robert/sshfs.nvim

- Local text-to-speech, for Neovim...? - https://github.com/Avi-D-coder/whisper.nvim

- A live-reload HTTP server, written in Lua - https://github.com/hyperstown/nvim-live-server

- Nicer-looking LSP typescript error messags - https://github.com/enochchau/nvim-pretty-ts-errors/tree/main

- Shows compression statistics of the current file. e.g. "if this was compressed, what would its size be" - https://github.com/CrestNiraj12/compress-size.nvim

- It shows references on functions and stuff, inline. Useful! - https://github.com/oribarilan/lensline.nvim

- A multi-TUI wrapper - https://github.com/jrop/tuis.nvim


## Python Development
virtual environment selector -
https://github.com/linux-cultist/venv-selector.nvim
https://github.com/neolooong/whichpy.nvim


## Probably not that useful
https://github.com/topaxi/gh-actions.nvim

- Fun but not that useful - https://github.com/rthrfrd/heatscroll


- Markdown live preview LSP(?) - https://github.com/mhersson/mpls

## Spelling
https://www.reddit.com/r/neovim/comments/1fcidod/cspell_for_neovim/
https://vim.fandom.com/wiki/Use_integrated_spell_checking
https://www.reddit.com/r/vim/comments/bce1ug/spell_check_with_camel_case/
https://github.com/Jason3S/cspell

## In theory useful but don't seem to work
https://github.com/briangwaltney/paren-hint.nvim
https://github.com/code-biscuits/nvim-biscuits
