(*

Construct all spanning trees. (medium)

![spanning tree](http://ocaml.org/img/spanning-tree-graph1.gif)

Write a function s_tree g to construct (by backtracking) all spanning trees of a given graph g. With this predicate, find out how many spanning trees there are for the graph depicted to the left. The data of this example graph can be found in the test below. When you have a correct solution for the s_tree function, use it to define two other useful functions: is_tree graph and is_connected Graph. Both are five-minutes tasks!

*)

module CharMap = Map.Make (Char)
module CharSet = Set.Make (Char)

type adj_graph = char list CharMap.t


let g1 = 
  CharMap.add 'g' ['h'] (
    CharMap.add 'h' ['g'] (
      CharMap.add 'b' ['f';'c'] (
	CharMap.add 'c' ['f';'b'] (
	  CharMap.add 'f' ['k';'b';'c'] (
	    CharMap.add 'k' ['f'] (
	      CharMap.singleton 'd' []))))))

let cycles g a =
  let rec collect s marked step =
    if s = a && step <> 0 then [[s]]
    else if CharSet.mem s marked then []
    else 
      let edges = CharMap.find s g in
      let m = CharSet.add s marked in
      List.fold_left (fun acc c -> List.rev_append (collect c m (step+1)) acc) [] edges |> List.map (fun x -> s::x)
  in 
  collect a (CharSet.empty) 0

	
 
