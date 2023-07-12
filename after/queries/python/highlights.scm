;; extends
;; https://www.reddit.com/r/neovim/comments/1255tw1/comment/je3t93u/?utm_source=share&utm_medium=web2x&context=3

;; Common comment prefix sections
((comment) @text.danger
 (#lua-match? @text.danger "^#%s+Important:"))
((comment) @text.note
 (#lua-match? @text.note "^#%s+Note:"))

;; General
((comment) @text.danger
 (#lua-match? @text.danger "^.+%!$"))
((comment) @text.question
 (#lua-match? @text.question "^.+%?$"))
