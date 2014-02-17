(*

Truth tables for logical expressions. (medium)

Generalize the previous problem in such a way that the logical expression may contain any number of logical variables. Define table in a way that table variables expr returns the truth table for the expression expr, which contains the logical variables enumerated in variables.

*)

type bool_expr =
  | Var of string
  | Not of bool_expr
  | And of bool_expr * bool_expr
  | Or of bool_expr * bool_expr

let rec eval value_list = function
  | Var x  -> List.assoc x value_list
  | Not expr -> not (eval value_list expr)
  | And (expr1, expr2) -> (eval value_list expr1) && (eval value_list expr2)
  | Or (expr1, expr2) -> (eval value_list expr1) || (eval value_list expr2)

let table vl expr =
  let rec accum value_list = function
    | [] -> [(List.rev value_list, eval value_list expr)]
    | hd::tl -> (accum ((hd,true)::value_list) tl) @ (accum ((hd,false)::value_list) tl) 
  in 
  accum [] vl

let test = table ["a"; "b"] (And(Var "a", Or(Var "a", Var "b")))

let test2 = 
  let a,b,c = Var "a", Var "b", Var "c" in
  table ["a"; "b"; "c"] (Or(And(a, Or(b,c)), Or(And(a,b), And(a,c))));;
