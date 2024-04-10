;; extends

; Treat the comment at the top of the file as a docstring
(source_file
  .
  (line_comment)* @comment.documentation
)
