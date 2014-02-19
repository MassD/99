(*

56. Symmetric binary trees. (medium)

Let us call a binary tree symmetric if you can draw a vertical line through the root node and then the right subtree is the mirror image of the left subtree. Write a function is_symmetric to check whether a given binary tree is symmetric.

Hint: Write a function is_mirror first to check whether one tree is the mirror image of another. We are only interested in the structure, not in the contents of the nodes.

*)

type 'a bt = Empty | Node of 'a * 'a bt * 'a bt

let rec is_mirror = function
  | Empty, Empty -> true
  | Empty, _ | _, Empty -> false
  | Node (_,l1,r1), Node (_,l2,r2) -> is_mirror (l1,r2) && is_mirror (l2,r1)

let is_symmetric = function
  | Empty -> true
  | Node (_,l,r) -> is_mirror (l,r)
