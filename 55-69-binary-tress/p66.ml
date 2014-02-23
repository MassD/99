(*

Layout a binary tree (3). (hard)

http://ocaml.org/img/tree-layout3.gif

Yet another layout strategy is shown in the above illustration. The method yields a very compact layout while maintaining a certain symmetry in every node. Find out the rules and write the corresponding predicate.

Hint: Consider the horizontal distance between a node and its successor nodes. How tight can you pack together two subtrees to construct the combined binary tree? This is a difficult problem. Don't give up too early!

*)



type 'a btree = Empty | Node of 'a * 'a btree * 'a btree

type 'a pos_binary_tree =
  | E (* represents the empty tree *)
  | N of 'a * int * int * 'a pos_binary_tree * 'a pos_binary_tree

let rec height = function
  | Empty -> 0
  | Node (_,l,r) -> 1 + max (height l) (height r)

let get_x h level = (2. ** (float_of_int (h-level)) |> int_of_float) - 1

let layout_btree2 t = 
  let h = height t in
  let rec build level xs = function
    | Empty -> E
    | Node (k,l,r) -> 
      let x = xs + get_x h level in
      N (k,x,level,build (level+1) xs l,build (level+1) (x+1) r)
  in 
  build 1 0 t
  
let bt = 
  Node ('n', 
	Node ('k', 
	      Node ('c', 
		    Node ('a',Empty, Empty), 
		    Node ('e', 
			  Node ('d',Empty,Empty),
			  Node ('g',Empty,Empty))), 
	      Node ('m',Empty,Empty)), 
	Node ('u', 
	      Node ('p',Empty, Node ('q',Empty,Empty)),
	      Empty))

let rec xys = function
  | E -> []
  | N (k,x,y,l,r) -> (k,x,y)::(List.rev_append (xys l) (xys r))
