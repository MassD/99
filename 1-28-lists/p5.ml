(*

Reverse a list. (easy)

OCaml standard library has List.rev but we ask that you reimplement it.

*)

let rev l =
  let rec rev' acc = function
    | [] -> acc
    | hd::tl -> rev' (hd::acc) tl
  in 
  rev' [] l

let l1 = []
let l2 = [1;2;3]
