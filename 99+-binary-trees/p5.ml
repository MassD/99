(*

Print all nodes that are at distance k from a leaf node

Given a Binary Tree and a positive integer k, print all nodes that are distance k from a leaf node.

Here the meaning of distance is different from previous post. Here k distance from a leaf means k levels higher than a leaf node. For example if k is more than height of Binary Tree, then nothing should be printed. Expected time complexity is O(n) where n is the number nodes in the given Binary Tree.


ref: http://www.geeksforgeeks.org/print-nodes-distance-k-leaf-node/

*)

type 'a btree = Empty | Node of 'a * 'a btree * 'a btree

let process k dl = List.map ((+) 1) dl

let rec has_k k = function
  | [] -> false
  | hd::_ when hd=k -> true
  | hd::tl -> has_k k tl

let at_dist k bt = 
  let rec collect = function
    | Empty -> [], [0]
    | Node (x,l,r) ->
      let acc1,dl1 = collect l in
      let acc2,dl2 = collect r in
      let dl = process k dl1 @ process k dl2 in
      let acc = acc1 @ acc2 in
      let next_dl = List.filter ((>) k) dl in
      if has_k k dl then x::acc, next_dl
      else acc, next_dl
  in 
  collect bt |> fst

let bt = Node ('n', Node ('k', Node ('c', Node ('a',Empty, Empty), Node ('h', Node ('g', Node ('e',Empty,Empty),Empty),Empty)), Node ('m',Empty,Empty)), Node ('u', Node ('p', Empty, Node ('s',Node ('q',Empty,Empty),Empty)),Empty))
      
