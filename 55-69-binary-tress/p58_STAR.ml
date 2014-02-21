(*

Generate-and-test paradigm. (medium)

Apply the generate-and-test paradigm to construct all symmetric, completely balanced binary trees with a given number of nodes.

How many such trees are there with 57 nodes? Investigate about how many solutions there are for a given number of nodes? What if the number is even? Write an appropriate function.

*)

type 'a bt = Empty | Node of 'a * 'a bt * 'a bt

let x = 'X'

let grow_one l r =
  let fix_l xl = List.fold_left (fun acc xr -> Node (x,xl,xr)::acc) [] r in
  List.fold_left (fun acc xl -> List.rev_append (fix_l xl) acc) [] l

let rec cbal_trees n =
  if n = 0 then [Empty]
  else if n = 1 then [Node (x,Empty,Empty)]
  else if n mod 2 = 1 then 
    let t = cbal_trees (n/2) in
    grow_one t t 
  else 
    let l,r = cbal_trees (n/2), cbal_trees (n/2-1) in
    List.rev_append (grow_one l r) (grow_one r l)

let rec is_mirror l r =
  match l,r with
    | Empty,Empty -> true
    | Empty,_ | _,Empty -> false
    | Node (_,l1,r1), Node (_,l2,r2) -> is_mirror l1 r2 && is_mirror r1 l2

let is_symmetric = function
  | Empty -> true
  | Node (_,l,r) -> is_mirror l r

let sym_cbal_trees n = cbal_trees n |> List.filter is_symmetric

let rec num_trees n =
  if n = 0 then 1
  else if n = 1 then 1
  else if n mod 2 = 0 then 2 * (num_trees (n/2-1)) * (num_trees (n/2))
  else let m = num_trees (n/2) in m*m

let sym_cbal_trees' n =
  if n mod 2 = 0 then 0
  else num_trees (n/2)
