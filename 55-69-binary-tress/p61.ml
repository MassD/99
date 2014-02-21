(*

Count the leaves of a binary tree. (easy)

A leaf is a node with no successors. Write a function count_leaves to count them.

*)

type 'a bt = Empty | Node of 'a * 'a bt * 'a bt

let rec count_leaves = function
  | Empty -> 0
  | Node (_,Empty,Empty) -> 1
  | Node (_,l,r) -> (count_leaves l) + (count_leaves r)

let _ = count_leaves (Node (1,Node (2,Empty,Empty),Empty))
