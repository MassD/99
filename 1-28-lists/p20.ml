(*

Remove the K'th element from a list. (easy)

The first element of the list is numbered 0, the second 1,...

*)

let remove_at kth l =
  let rec aux acc i = function
    | [] -> l
    | hd::tl when i = kth-1 -> List.rev_append acc tl
    | hd::tl -> aux (hd::acc) (i+1) tl
  in 
  aux [] 0 l

let k,l = 1,["a";"b";"c";"d"]
