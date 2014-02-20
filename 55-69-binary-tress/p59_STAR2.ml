(*

Construct height-balanced binary trees. (medium)

In a height-balanced binary tree, the following property holds for every node: The height of its left subtree and the height of its right subtree are almost equal, which means their difference is not greater than one.

Write a function hbal_tree to construct height-balanced binary trees for a given height. The function should generate all solutions via backtracking. Put the letter 'x' as information into all nodes of the tree.

*)

type 'a binary_tree = Empty | Node of 'a * 'a binary_tree * 'a binary_tree

let x = 'X'

let rev_flatten l =
  let rec flat acc = function
    | [] -> acc
    | hd::tl -> flat (List.rev_append hd acc) tl
  in 
  flat [] l

let rev_append3 l1 l2 l3 = List.rev_append l1 l2 |> List.rev_append l3

let grow_one l r =
  let fix_l xl = List.fold_left (fun acc xr -> Node (x,xl,xr)::acc) [] r in
  List.fold_left (fun acc xl -> List.rev_append (fix_l xl) acc) [] l

let hbal_tree h =
  let rec grow i acc_0 acc_1 =
    if i = h+1 then acc_1
    else grow (i+1) acc_1 (rev_append3 (grow_one acc_0 acc_1) (grow_one acc_1 acc_0) (grow_one acc_1 acc_1))
  in 
  grow 1 [] [Empty]
