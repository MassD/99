(*
  Replicate the elements of a list a given number of times. (medium)
*)

let replicate l n =
  let xs x n = 
    let rec xs' i acc = if i = n then acc else xs' (i+1) (x::acc) in
    xs' 0 []
  in 
  List.fold_left (fun acc x -> List.rev_append (xs x n) acc) [] l |> List.rev

let l,3 = ["a";"b";"c"]
let l1,2 = []
