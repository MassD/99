(*

Collect the nodes at a given level in a list. (easy)

A node of a binary tree is at level N if the path from the root to the node has length N-1. The root node is at level 1. Write a function at_level t l to collect all nodes of the tree t at level l in a list.

*)

type 'a bt = Empty | Node of 'a * 'a bt * 'a bt

let at_level btree lvl = 
  let rec collect level = function
    | Node (x,l,r) when level = lvl -> [x]
    | Node (_,l,r) when level < lvl -> List.rev_append (collect (level+1) l) (collect (level+1) r)
    | _ -> []
  in 
  collect 1 btree

let at_level' btree lvl =
  let rec collect acc level = function
    | Empty, [] -> acc
    | _, [] when level > lvl -> acc
    | Node (x,l,r), [] when level = lvl -> x::acc
    | Empty, (hd,new_lvl)::tl -> collect acc new_lvl (hd,tl)
    | _, (hd,new_lvl)::tl when level > lvl -> collect acc new_lvl (hd,tl)
    | Node (x,l,r), (hd,new_lvl)::tl when level = lvl -> collect (x::acc) new_lvl (hd,tl)
    | Node (x,l,r), wl -> collect acc (level+1) (l, (r,level+1)::wl)
  in 
  collect [] 1 (btree,[])

let example_tree =
    Node('a', Node('b', Node('d', Empty, Empty), Node('e', Empty, Empty)),
         Node('c', Empty, Node('f', Node('g', Empty, Empty), Empty)))



