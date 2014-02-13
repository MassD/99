(*

11. Modified run-length encoding. (easy)

Modify the result of the previous problem in such a way that if an element has no duplicates it is simply copied into the result list. Only elements with duplicates are transferred as (N E) lists.

Since OCaml lists are homogeneous, one needs to define a type to hold both single elements and sub-lists.

*)

type 'a rle = One of 'a | Many of int * 'a

let encode l =
  if l = [] then []
  else 
    let acc,s = List.fold_left (fun (acc,(c,x)) y -> if y = x then acc,(c+1,x) else (c,x)::acc,(1,y)) ([],(1,List.hd l)) (List.tl l)
    in
    List.map (fun (c,x) -> if c = 1 then One x else Many (c,x)) (s::acc)

let l = ["a";"a";"a";"a";"b";"c";"c";"a";"a";"d";"e";"e";"e";"e"]
let l1 = []
let l2 = [1;2;3];;
    
													       
