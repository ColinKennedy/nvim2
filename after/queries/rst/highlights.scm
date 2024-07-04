;; extends

(paragraph (literal) @nospell)

; This is needed so :ref:`foo` is highlighted
(
 paragraph (literal) @markup.raw
 ; Put the literal much higher than other priorities so it is preferred
 (#set! "priority" 400)
)
