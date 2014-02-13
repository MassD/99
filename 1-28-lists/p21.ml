(*

Insert an element at a given position into a list. (easy)

Start counting list elements with 0. If the position is larger or equal to the length of the list, insert the element at the end. (The behavior is unspecified if the position is negative.)

*)

let insert_at x k l =
  List.fold_left (fun (acc,c) y -> if c = k then y::x::acc,c+1 else y::acc,c+1) ([],0) l |> fst |> List.rev

let x,k,l = "alfa",1,["a";"b";"c";"d"]
let x1,k1,l1 = "alfa",3,["a";"b";"c";"d"]
let x2,k2,l2 = "alfa",4,["a";"b";"c";"d"]
