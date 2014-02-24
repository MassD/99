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

let rec tag x = function
    | Empty -> Empty
    | Node (k,l,r) -> Node ((k,x), tag (x-1) l, tag (x+1) r)

let rec check_clash l r =
  match l, r with
    | _, Empty | Empty, _ -> 0
    | Node ((k1,x1),_,r1), Node ((k2,x2),l2,_) ->
      let shift = check_clash r1 l2 in
      if x1-shift < x2+shift then shift
      else if x1-shift = x2+shift then shift+1
      else (x1-shift)-(x2+shift)

let rec shift_move shift = function
  | Empty -> Empty
  | Node ((k,x),l,r) -> Node ((k,x+shift),shift_move shift l, shift_move shift r)

let rec wider = function
    | Empty -> Empty
    | Node ((k,x),l,r) -> 
      let wide_l, wide_r = wider l, wider r in
      let shift = check_clash wide_l wide_r in
      Node ((k,x),shift_move (-shift) l, shift_move shift r)

let rec min_x = function
  | Empty -> 0
  | Node ((_,x),Empty,_) -> x
  | Node (_,l,_) -> min_x l

let layout3 btree =
  let rec build shift y = function
    | Empty -> E
    | Node ((k,x),l,r) -> N (k, x+shift, y, build shift (y+1) l, build shift (y+1) r)
  in 
  let wider_btree = tag 0 btree |> wider in
  build (1-(min_x wider_btree)) 1 wider_btree
  
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
