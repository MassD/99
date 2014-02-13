(*

Find the number of elements of a list. (easy)

OCaml standard library has List.length but we ask that you reimplement it. Bonus for a tail recursive solution.

*)

let length_tail l = 
  let rec len acc = function
    | [] -> acc
    | _::tl -> len (acc+1) tl
  in 
  len 0 l

let l1 = []
let l2 = [1;2;3]
