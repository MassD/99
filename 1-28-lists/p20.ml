(*

Remove the K'th element from a list. (easy)

The first element of the list is numbered 0, the second 1,...

*)

let remove_at k l =
  List.fold_left (fun (acc,c) x -> if c = k then acc,c+1 else x::acc,c+1) ([],0) l |> fst |> List.rev

let k,l = 1,["a";"b";"c";"d"]
