- Fix - https://github.com/stevearc/qf_helper.nvim/issues/10


https://github.com/chris-montero/LateForLunch-nvim

https://dtinth.github.io/comic-mono-font/

- Do this + set conceallevel=1 to conceal stuff
; (
;    (
;       (list) @capture
;       (#offset! @capture 0 1 0 -1)
;    )
;    (#set! conceal "…")
; )


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

https://www.reddit.com/r/neovim/comments/1frlhwu/aqfnvim_store_edit_like_a_buffer_swap_filter_and/


- Follow-up
 - Typing "D" for a docstring in a real file is frustrating because cmp takes control away when new  LSP entries are added
  - https://github.com/hrsh7th/nvim-cmp/issues/1597

- https://github.com/MagicDuck/grug-far.nvim

- https://www.reddit.com/r/neovim/comments/1fmoxvw/oilnvim_appreciation/

- language server stuff
 - project cd
 - auto-completion
 - other settings?

- Consider these completion sources
 - https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources#miscellaneous
  - https://github.com/rcarriga/cmp-dap
 - https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
 - https://github.com/lukas-reineke/cmp-rg


https://github.com/williamboman/mason.nvim/blob/b54d4e3171cc9735de915dbb97e987fb1f05dad9/lua/mason/mappings/language.lua#L22
