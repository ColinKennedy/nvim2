;; extends
;; https://www.reddit.com/r/neovim/comments/1255tw1/comment/je3t93u/?utm_source=share&utm_medium=web2x&context=3

((comment) @text.danger
 (#lua-match? @text.danger "^.+%!$"))
((comment) @text.question
 (#lua-match? @text.question "^.+%?$"))

; Highlight docstrings
(
 (comment) @spell @comment.documentation
 .
 (declaration
   (attribute_declaration
     (attribute)))
 (#lua-match? @comment.documentation "^\s*///")
)
(
 (comment) @spell @comment.documentation
 .
 [(class_specifier) (struct_specifier)]
 (#lua-match? @comment.documentation "^\s*///")
)
