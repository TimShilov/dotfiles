; Matching any strings directly after 'language=MySQL' comments
((comment) @comment
  (#contains? @comment "language=MySQL")
  .
  [
    (string
      (string_fragment) @injection.content
      (#set! injection.language "sql"))
    (template_string
      (string_fragment) @injection.content
      (#set! injection.language "sql"))
  ])

; Pattern for string variables following a MySQL language comment
((comment) @comment
  (#contains? @comment "language=MySQL")
  .
  (lexical_declaration
    (variable_declarator
      value: [
        (string
          (string_fragment) @injection.content
          (#set! injection.language "sql"))
        (template_string
          (string_fragment) @injection.content
          (#set! injection.language "sql"))
      ])))
