(*

Split a list into two parts; the length of the first part is given. (easy)

If the length of the first part is longer than the entire list, then the first part is the list and the second part is empty.

*)

let split l n =
  let a, b, _ = List.fold_left (fun (a,b,i) x -> if i < n then x::a,b,i+1 else a,x::b,i+1) ([],[],0) l in
  List.rev a, List.rev b

let l,k = ["a";"b";"c";"d";"e";"f";"g";"h";"i";"j"],3
let l2,k2 = ["a";"b";"c";"d"],5
