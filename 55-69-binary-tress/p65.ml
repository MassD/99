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
