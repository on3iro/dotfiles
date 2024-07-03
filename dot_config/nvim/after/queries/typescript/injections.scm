; extends

(call_expression
  (expression
   (identifier) @identifier (#eq? @identifier "sql"))
  (template_string) @sql)
; inject into sql<>`` for sql syntax highlighting (same but with type generics)
; apparently currently doesn't work
; (call_expression
;   function: (await_expression
;    (identifier) @identifier (#eq? @identifier "sql")) @expression
;   type_arguments: (type_arguments) @typeArgs
;   (template_string) @sql
; ) @full;
