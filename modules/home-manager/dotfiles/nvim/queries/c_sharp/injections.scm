(
 assignment_expression
   left: (identifier) @id (#eq? @id "PropertiesJsonSchema")
   right: (raw_string_literal (raw_string_content) @injection.content (#set! injection.language "json"))
)

