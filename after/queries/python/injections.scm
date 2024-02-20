;;extends

(module . (expression_statement (string) @rst))

(class_definition
  body: (block . (expression_statement (string (string_content) @rst))))

(function_definition
  body: (block . (expression_statement (string (string_content) @rst))))

; Attribute docstring
((expression_statement (assignment)) . (expression_statement (string) @rst))
