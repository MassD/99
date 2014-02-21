(*

Layout a binary tree (2). (medium)

http://ocaml.org/img/tree-layout2.gif

An alternative layout method is depicted in this illustration. Find out the rules and write the corresponding OCaml function.

Hint: On a given level, the horizontal distance between neighbouring nodes is constant.

*)

type 'a btree = Empty | Node of 'a * 'a btree * 'a btree

type 'a pos_binary_tree =
  | E (* represents the empty tree *)
  | N of 'a * int * int * 'a pos_binary_tree * 'a pos_binary_tree

let layout_btree2 t = 
  


let bt = Node ('n', Node ('k', Node ('c', Node ('a',Empty, Empty), Node ('h', Node ('g', Node ('e',Empty,Empty),Empty),Empty)), Node ('m',Empty,Empty)), Node ('u', Node ('p', Empty, Node ('s',Node ('q',Empty,Empty),Empty)),Empty))

let rec xys = function
  | E -> []
  | N (k,x,y,l,r) -> (k,x,y)::(List.rev_append (xys l) (xys r))
