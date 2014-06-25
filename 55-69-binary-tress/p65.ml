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

let get_x h level = (2. ** (Float.of_int (h-level)) |> Int.of_float) - 1

let get_fullsize h level = (2. ** (Float.of_int (h+1-level)) |> Int.of_float) - 1

let layout_btree2_correct t = 
  let h = height t in
  let rec lay off y = function
      | Empty -> get_fullsize h y, E
      | Node (w, Empty, r) when off = 0 ->
	let wtr, newr = lay 1 (y+1) r in
	1+wtr, N (w, 1, y+1, E, newr)
      | Node (w, l, r) ->
	let wt1, newl = lay off (y+1) l in
	let wt2, newr = lay (off+wt1+1) (y+1) r in
	wt1+wt2+1, N (w, off+wt1+1, y, newl, newr)
  in 
  lay 0 1 t |> snd

(* below is also wrong, as it doesn't handle the special case of leftmost node *)
let layout_btree2 t = 
  let h = height t in
  let rec build level xs = function
    | Empty -> E
    | Node (k,l,r) -> 
      let x = xs + get_x h level in
      N (k,x,level,build (level+1) xs l,build (level+1) (x+1) r)
  in 
  build 1 0 t
  
(* below is a so wrong algorithm *)
let layout_btree2' t = 
  let rec lay off width y = function
    | Empty -> 0, E
    | Node (w,l, r) -> 
      match width with
	| None ->
	  let wt, newl = lay off width (y+1) l in
	  let _, newr = lay (off+wt+1) (Some wt) (y+1) r in
	  2*wt+1, N (w, off+wt+1, y, newl, newr)
	| Some wt ->
	  let mid = wt / 2 in
	  let _, newl = lay off (Some mid) (y+1) l in
	  let _, newr = lay (off+mid+1) (Some mid) (y+1) r in
	  wt, N (w, off+mid+1, y, newl, newr)
  in 
  lay 0 None 1 t |> snd
	

let bt = 
  Node ('n', 
	Node ('k', 
	      Node ('c', 
		    Node ('a',Node ('0', Empty, Empty), Empty), 
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
