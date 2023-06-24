;; extends
;; https://www.reddit.com/r/neovim/comments/1255tw1/comment/je3t93u/?utm_source=share&utm_medium=web2x&context=3

((comment) @text.danger @nospell
 (#lua-match? @text.danger "^.+%!$"))
((comment) @text.note.rare @nospell
 (#lua-match? @text.note.rare "^.+%?$"))
