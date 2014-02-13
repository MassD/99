(*

Extract a slice from a list. (medium)

Given two indices, i and k, the slice is the list containing the elements between the i'th and k'th element of the original list (both limits included). Start counting the elements with 0 (this is the way the List module numbers elements).

*)

let slice l i j =
  let rec aux acc c = function
    | [] -> List.rev acc
    | hd::tl ->
      if c < i then aux acc (c+1) tl
      else if i <= c && c <= j then aux (hd::acc) (c+1) tl
      else List.rev acc
  in 
  aux [] 0 l

let l,i,j = ["a";"b";"c";"d";"e";"f";"g";"h";"i";"j"],2,6
