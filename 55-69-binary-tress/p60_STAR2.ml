(*

Construct height-balanced binary trees with a given number of nodes. (medium)

A. Clearly, maxN = 2h - 1. However, what is the minimum number minN? This question is more difficult. Try to find a recursive statement and turn it into a function `min_nodes` defined as follows: `min_nodes h` returns the minimum number of nodes in a height-balanced binary tree of height h.

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

let grow_one l r =
  let fix_l (xl,sl,hl) = List.fold_left (fun acc (xr,sr,hr) -> (Node (x,xl,xr),sl+sr+1,1+(max hl hr))::acc) [] r in
  List.fold_left (fun acc x -> List.rev_append (fix_l x) acc) [] l

let hbal_trees min_h max_h =
  let rec build acc acc0 acc1 h =
    if h = max_h+1 then acc
    else 
      let acc_h = rev_concat3 (grow_one acc0 acc1) (grow_one acc1 acc0) (grow_one acc1 acc1) in
      if h >= min_h then build (List.rev_append acc_h acc) acc1 acc_h (h+1)
      else build acc acc1 acc_h (h+1)
  in 
  build [] [] [(Empty,0,0)] 1

let rec pairing k l2 acc = function
  | [], _ -> acc
  | _::tl, [] -> pairing k l2 acc (tl,l2)
  | (bt1,s1,h1)::_ as l1, (bt2,s2,h2)::tl2 -> 
    if s1+s2 = k && abs(h1-h2) <= 1 then pairing k l2 ((bt1,bt2)::acc) (l1,tl2)
    else pairing k l2 acc (l1,tl2)

let hbal_tree_nodes n =
  let trees = hbal_trees (min_h (n-1)) (max_h (n-1)) in
  pairing (n-1) trees [] (trees,trees)
  





