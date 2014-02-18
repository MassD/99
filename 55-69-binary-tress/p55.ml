(*

Construct completely balanced binary trees. (medium)

In a completely balanced binary tree, the following property holds for every node: The number of nodes in its left subtree and the number of nodes in its right subtree are almost equal, which means their difference is not greater than one.

Write a function cbal_tree to construct completely balanced binary trees for a given number of nodes. The function should **generate all solutions** via backtracking. Put the letter 'x' as information into all nodes of the tree.

*)

type 'a bst = Empty | Node of 'a * 'a bst * 'a bst

let singleton = Node ('X', Empty, Empty)

let cbal_tree n = 
  let add_node (x,lh,rh) =
    match x with 
      | Empty -> [singleton]
      | Node (_,l,r) -> 
  let rec build i acc =
    if i >= n-1 then 


