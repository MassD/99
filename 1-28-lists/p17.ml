(*

Split a list into two parts; the length of the first part is given. (easy)

If the length of the first part is longer than the entire list, then the first part is the list and the second part is empty.

*)

let split l n =
  let rec aux acc i = function
    | [] -> List.rev acc, []
    | hd::tl when i < n -> aux (hd::acc) (i+1) tl
    | _ as l -> List.rev acc, l
  in 
  aux [] 0 l

let l,k = ["a";"b";"c";"d";"e";"f";"g";"h";"i";"j"],3
let l2,k2 = ["a";"b";"c";"d"],5
