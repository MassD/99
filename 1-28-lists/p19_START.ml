(*

Rotate a list N places to the left. (medium)

*)

let rotate l n =
  let rec roll acc i k = function
    | [] -> acc,[]
    | _::tl when i = k -> acc,tl
    | hd::tl -> roll (hd::acc) (i+1) k tl
  in 
  if n < 0 then
    let a,b = roll [] 0 (abs n) (List.rev l) in 
    List.rev_append (List.rev a) (List.rev b)
  else
    let a,b = roll [] 0 n l in
    List.rev_append (List.rev b) (List.rev a)
 
let l,n = ["a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"],3
let l1,n1 = ["a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"],(-2)
