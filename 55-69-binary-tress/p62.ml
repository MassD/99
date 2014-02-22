(*

Collect the internal nodes of a binary tree in a list. (easy)

An internal node of a binary tree has either one or two non-empty successors. Write a function internals to collect them in a list.

*)

type 'a bt = Empty | Node of 'a * 'a bt * 'a bt

let rec internals = function
  | Empty | Node (_,Empty,Empty) -> []
  | Node (x,l,r) -> x::(List.rev_append (internals l) (internals r))

let internals' btree = 
  let rec collect acc = function
    | Empty, [] | Node (_,Empty,Empty), [] -> acc
    | Empty, hd::tl | Node (_,Empty,Empty), hd::tl -> collect acc (hd,tl)
    | Node (x,l,r), wl -> collect (x::acc) (l, r::wl)
  in 
  collect [] (btree,[])
