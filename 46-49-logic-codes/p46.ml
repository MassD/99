(*

Truth tables for logical expressions (2 variables). (medium)

Define a function, table2 which returns the truth table of a given logical expression in two variables (specified as arguments). The return value must be a list of triples containing (value\_of\_a, value\_of\_b, value\_of\_expr).

*)

type bool_expr =
  | Var of string
  | Not of bool_expr
  | And of bool_expr * bool_expr
  | Or of bool_expr * bool_expr

let rec eval a value_a b value_b= function
  | Var x when x = a -> value_a
  | Var x when x = b -> value_b
  | Var _ -> failwith "Variable not defined"
  | Not expr -> not (eval a value_a b value_b expr)
  | And (expr1, expr2) -> (eval a value_a b value_b expr1) && (eval a value_a b value_b expr2)
  | Or (expr1, expr2) -> (eval a value_a b value_b expr1) || (eval a value_a b value_b expr2)

	  
let table2 a b expr =
  [(true, true, eval a true b true expr);
   (true, false, eval a true b false expr);
   (false, true, eval a false b true expr);
   (false, false, eval a false b false expr);
  ]

let _ = table2 "a" "b" (And(Var "a", Or(Var "a", Var "b")));;
