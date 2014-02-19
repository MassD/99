(*

Construct completely balanced binary trees. (medium)

In a completely balanced binary tree, the following property holds for every node: The number of nodes in its left subtree and the number of nodes in its right subtree are almost equal, which means their difference is not greater than one.

Write a function cbal_tree to construct completely balanced binary trees for a given number of nodes. The function should **generate all solutions** via backtracking. Put the letter 'x' as information into all nodes of the tree.

*)

type 'a bst = Empty | Node of 'a * 'a bst * 'a bst

let rev_flatten l =
  let rec flat acc = function
    | [] -> acc
    | hd::tl -> flat (List.rev_append hd acc) tl
  in 
  flat [] l

let merge l r = 
  let fix_l xl = List.fold_left (fun acc xr -> Node ('X', xl, xr)::acc) [] r in
  List.fold_left (fun acc xl -> fix_l xl::acc) [] l |> rev_flatten

let rec cbal_tree n = 
  if n = 0 then [Empty]
  else if n mod 2 = 1 then
    let l = cbal_tree (n/2) in
    let r = l in
    merge l r
  else 
    let t1 = cbal_tree (n/2-1) in
    let t2 = cbal_tree (n/2) in
    List.rev_append (merge t1 t2) (merge t2 t1)


(* Below is an interesting generalisation for various left and right size diffs *)

(* diffs 4 1 => [(2,2)], diffs 6 2 => [(3,3);(2,4)], find all (x,y) where x+y=n && abs(y-x)<=k *)
let diffs n k =
  let rec dif acc i =
    let d = n-2*i in
    if d = 0 then dif ((i,n-i)::acc) (i-1)
    else if d <= k then dif ((i, n-i)::(n-i,i)::acc) (i-1)
    else acc
  in 
  dif [] (n/2)

let rec cbal_tree_var n k =
  if n = 0 then [Empty]
  else if n = 1 then [Node ('X', Empty, Empty)]
  else 
    let gen_tree (x,y) =
      if x = y then let t = cbal_tree_var x k in merge t t
      else merge (cbal_tree_var x k) (cbal_tree_var y k)
    in 
    List.fold_left (fun acc p -> List.rev_append (gen_tree p) acc) [] (diffs (n-1) k)
