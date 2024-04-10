;; extends

(
 (comment)* @string.documentation
 .
 (function_definition)
)

(
 (comment) @spell @comment.documentation
 .
 (struct_specifier)
 (#lua-match? @comment.documentation "^\s*///")
)
