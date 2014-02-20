(*

Binary search trees (dictionaries). (medium)

A. Construct a binary search tree from a list of integer numbers.
B. Then use this function to test the solution of the previous problem.

*)

type 'a bst = Empty | Node of 'a * 'a bst * 'a bst

let rec insert x = function
  | Empty -> Node (x,Empty,Empty)
  | Node (k,l,r) -> if x < k then Node (k,insert x l,r) else Node (k,l,insert x r)

let construct l =
  List.fold_left (fun acc x -> insert x acc) Empty l


