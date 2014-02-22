(*

Collect the leaves of a binary tree in a list. (easy)

A leaf is a node with no successors. Write a function leaves to collect them in a list.

*)

type 'a bt = Empty | Node of 'a * 'a bt * 'a bt

let rec leaves = function
  | Empty -> []
  | Node (x,Empty,Empty) -> [x]
  | Node (_,l,r) -> List.rev_append (leaves l) (leaves r)

