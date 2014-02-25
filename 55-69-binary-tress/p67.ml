(*

A string representation of binary trees. (medium)

![Binary Tree](http://ocaml.org/img/binary-tree.gif)

Somebody represents binary trees as strings of the following type (see example): `"a(b(d,e),c(,f(g,)))"`.

- Write an OCaml function which generates this string representation, if the tree is given as usual (as `Empty` or `Node(x,l,r)` term). 

- Then write a function which does this inverse; i.e. given the string representation, construct the tree in the usual form. 

- Finally, combine the two predicates in a single function `tree_string` which can be used in both directions.

- Write the same predicate `tree_string` using difference lists and a single predicate `tree_dlist` which does the conversion between a tree and a difference list in both directions.

For simplicity, suppose the information in the nodes is a single letter and there are no spaces in the string.

*)

type 'a btree = Empty | Node of 'a * 'a btree * 'a btree

let rec tree_to_string f_str = function
  | Empty -> ""
  | Node (k, Empty, Empty) -> f_str k
  | Node (k,l,r) -> (f_str k) ^ "(" ^ (tree_to_string f_str l) ^ "," ^ (tree_to_string f_str r) ^ ")"

let rec proc_root f s = 
  if String.length s = 0 then Empty
  else if String.length s = 1 then Node (f s.[0], Empty, Empty)
  else 
    let l,rest = proc_child f (String.sub s 2 ((String.length s)-3)) in
    let r, rest1 = proc_child f rest in
    if String.length rest1 <> 0 then failwith "parse error"
    else Node (f s.[0], l, r)
and proc_child f s = 
  let len = String.length s in
  if len = 0 then proc_root f s, ""
  else if len = 1 then proc_root f s, ""
  else if s.[0] = ',' then proc_root f "", (String.sub s 1 (len-1))
  else if len >= 2 && s.[1] = ',' then proc_root f (String.sub s 0 1) , (String.sub s 2 (len-2))
  else
    let rec scan left i =
      if i >= len && left <> 0 then failwith "parse error"
      else if i > 1 && left = 0 && i < len && s.[i] = ',' then proc_root f (String.sub s 0 i), (String.sub s (i+1) (len-i-1))
      else if i > 1 && left = 0 then proc_root f (String.sub s 0 i), (String.sub s i (len-i))
      else if s.[i] = '(' then scan (left+1) (i+1)
      else if s.[i] = ')' then scan (left-1) (i+1)
      else scan left (i+1)
    in scan 0 0 

let string_to_tree str_f s = proc_root str_f s
      
let bt = Node (1, 
	       Node (2, 
		      Node (3, Empty, Empty), 
		      Node (4, Empty, Empty)), 
		Node (5, 
		       Empty, 
		       Node (6, 
			     Node (7, Empty, Empty), 
			     Empty)
		)
)


