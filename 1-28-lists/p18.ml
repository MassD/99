(*

Extract a slice from a list. (medium)

Given two indices, i and k, the slice is the list containing the elements between the i'th and k'th element of the original list (both limits included). Start counting the elements with 0 (this is the way the List module numbers elements).

*)

let slice l i j =
  List.fold_left (fun (acc,c) x -> if i <= c && c <= j then x::acc,c+1 else acc,c+1) ([],0) l |> fst |> List.rev

let l,i,j = ["a";"b";"c";"d";"e";"f";"g";"h";"i";"j"],2,6
