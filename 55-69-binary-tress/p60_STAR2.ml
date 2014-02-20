(*

Construct height-balanced binary trees with a given number of nodes. (medium)

A. Clearly, maxN = 2^h - 1. However, what is the minimum number minN? This question is more difficult. Try to find a recursive statement and turn it into a function `min_nodes` defined as follows: `min_nodes h` returns the minimum number of nodes in a height-balanced binary tree of height h.

B. On the other hand, we might ask: what is the maximum height H a height-balanced binary tree with N nodes can have? `max_height n` returns the maximum height of a height-balanced binary tree with n nodes.

C. Now, we can attack the main problem: construct all the height-balanced binary trees with a given nuber of nodes. `hbal_tree_nodes n` returns a list of all height-balanced binary tree with n nodes.

*)

type 'a binary_tree = Empty | Node of 'a * 'a binary_tree * 'a binary_tree

let x = 'x'

let log2 d = (log d)/.(log 2.)

let rec min_nodes h =
  if h <= 0 then 0
  else if h = 1 then 1
  else 1+(min_nodes (h-1))+(min_nodes (h-2))

let min_h n = (float_of_int n |> log2 |> int_of_float) + 1

let max_h n = 
  let rec find h1 h2 h =
    if h1+h2 >= n then h-1
    else find h2 (h1+h2) (h+1)
  in 
  find 0 1 1

let rev_concat3 l1 l2 l3 = List.rev_append l1 l2 |> List.rev_append l3

let grow_one k l r =
  let fix_l (xl,sl) = List.fold_left (fun acc (xr,sr) -> if sl+sr <= k then (Node (x,xl,xr),sl+sr+1)::acc else acc) [] r in
  List.fold_left (fun acc x -> List.rev_append (fix_l x) acc) [] l

let hbal_tree_nodes n =
  let hbal_trees min_h max_h =
    let rec build acc acc0 acc1 h =
      if h = max_h+1 then acc
      else 
	let acc_h = rev_concat3 (grow_one (n-1) acc0 acc1) (grow_one (n-1) acc1 acc0) (grow_one (n-1) acc1 acc1) in
	if h >= min_h then build (List.rev_append (List.filter (fun (x,s) -> if s = n then true else false) acc_h) acc) acc1 acc_h (h+1)
	else build acc acc1 acc_h (h+1)
    in 
    build [] [] [(Empty,0)] 1
  in 
  hbal_trees (min_h (n-1)) (max_h (n-1)) |> List.map fst

