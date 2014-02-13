(*
  Drop every N'th element from a list. (medium)
*)

let drop l n =
  List.fold_left (fun (acc,i) x -> if i = n then acc,1 else x::acc,i+1) ([], 1) l |> fst |> List.rev

let l,k = ["a";"b";"c";"d";"e";"f";"g";"h";"i";"j"], 3 
