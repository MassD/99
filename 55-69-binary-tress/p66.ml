(*

Layout a binary tree (1). (medium)

As a preparation for drawing the tree, a layout algorithm is required to determine the position of each node in a rectangular grid. Several layout methods are conceivable, one of them is shown in the illustration.

![Binary Tree Grid](http://ocaml.org/img/tree-layout1.gif)

In this layout strategy, the position of a node v is obtained by the following two rules:

- x(v) is equal to the position of the node v in the inorder sequence;
- y(v) is equal to the depth of the node v in the tree.

In order to store the position of the nodes, we redefine the OCaml type representing a node (and its successors) as follows:

    type 'a pos_binary_tree =
      | E (* represents the empty tree *)
      | N of 'a * int * int * 'a pos_binary_tree * 'a pos_binary_tree
	  
`N(w,x,y,l,r)` represents a (non-empty) binary tree with root `w` "positioned" at `(x,y)`, and subtrees `l` and `r`. 

Write a function `layout_binary_tree` with the following specification: `layout_binary_tree t` returns the "positioned" binary tree obtained from the binary tree `t`.

*)

type 'a btree = Empty | Node of 'a * 'a btree * 'a btree

type 'a pos_binary_tree =
  | E (* represents the empty tree *)
  | N of 'a * int * int * 'a pos_binary_tree * 'a pos_binary_tree

let layout_btree t =
  let rec pos_btree s y = function
    | Empty -> (E,0)
    | Node (x,l,r) ->
      let (new_pl,sl) = pos_btree s (y+1) l in
      let (new_pr,sr) = pos_btree (sl+1+s) (y+1) r in
      (N (x,sl+1+s, y, new_pl, new_pr), sl+1+sr)
  in 
  pos_btree 0 1 t
    
let bt = Node ('n', Node ('k', Node ('c', Node ('a',Empty, Empty), Node ('h', Node ('g', Node ('e',Empty,Empty),Empty),Empty)), Node ('m',Empty,Empty)), Node ('u', Node ('p', Empty, Node ('s',Node ('q',Empty,Empty),Empty)),Empty))

let rec xys = function
  | E -> []
  | N (k,x,y,l,r) -> (k,x,y)::(List.rev_append (xys l) (xys r))


