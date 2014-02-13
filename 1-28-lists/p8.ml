(*

Eliminate consecutive duplicates of list elements. (medium)

*)

let compress l = 
  if l = [] then []
  else List.fold_left (fun (acc,x) y -> if y = x then acc,x else y::acc, y) ([List.hd l], List.hd l) (List.tl l) |> fst |> List.rev

let l1 = []
let l2 = ["a";"a";"a";"a";"b";"c";"c";"a";"a";"d";"e";"e";"e";"e"]
let l3 = [1;2;1;2;1];;
