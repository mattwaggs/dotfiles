; Function and method calls
;--------------------------

;(invocation_expression
;  function: (member_access_expression
;    expression: (member_access_expression
;      name: (identifier) @member_access_expression_name
;    )
;  )
;)

;(member_access_expression
;  name: (identifier) @member_access_expression_name)
;
;(invocation_expression
;  (member_access_expression
;    name: (identifier) @method))
;
;(expression_statement
;  (invocation_expression
;    function: (generic_name 
;      (identifier) @method
;    )
;  )
;)
