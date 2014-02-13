(*
  Duplicate the elements of a list. (easy)
*)

let duplicate l =
  List.fold_left (fun acc x -> x::x::acc) [] l |> List.rev

let l1 = []
let l2 = ["a";"b";"c";"c";"d"]


