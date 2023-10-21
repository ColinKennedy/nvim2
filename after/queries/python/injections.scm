;;extends

; TODO: Remove once you drop Neovim 0.9.X support
; (module . (expression_statement (string) @rst))
;
; (class_definition
;   body: (block . (expression_statement (string (string_content) @rst))))
;
; (function_definition
;   body: (block . (expression_statement (string (string_content) @rst))))
; ;
; ; Attribute docstring
; ((expression_statement (assignment)) . (expression_statement (string) @rst))


(module . (expression_statement (string (string_content)) @injection.content)
  (#set! injection.language "rst"))

(class_definition
  body: (block . (expression_statement (string (string_content) @injection.content)))
  (#set! injection.language "rst"))

(function_definition
  body: (block . (expression_statement (string (string_content) @injection.content)))
  (#set! injection.language "rst"))

; Attribute docstring
((expression_statement (assignment)) . (expression_statement (string) @injection.content)
  (#set! injection.language "rst"))
