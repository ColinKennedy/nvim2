;; extends

(command
  (command_name)
  ((word) @variable
    (#lua-match? @variable "^[^-][a-zA-Z_0-9\.]*$")) (#set! "priority" 110))
