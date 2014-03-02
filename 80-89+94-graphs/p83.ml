(*

Construct all spanning trees. (medium)

![spanning tree](http://ocaml.org/img/spanning-tree-graph1.gif)

Write a function s_tree g to construct (by backtracking) all spanning trees of a given graph g. With this predicate, find out how many spanning trees there are for the graph depicted to the left. The data of this example graph can be found in the test below. When you have a correct solution for the s_tree function, use it to define two other useful functions: is_tree graph and is_connected Graph. Both are five-minutes tasks!

*)

module CharWeighted = struct 
  type t = char
  type et = (char * int) list
  let compare = compare
end

module CharWGraph = Graph.Make_adj (CharWeighted)
module Marker = Set.Make (Char)

let s_tree g =
  if CharWGraph.is_empty g then []
  else 
    let rec collect s m = 
      if Marker.mem s then []
      else 
	let m = Marker.add s m in
	let ts, m = List.fold_left (fun (acc,m) x -> (collect (fst x) m):acc) ([],m) (CharWGraph.find s g) in
	List.map (fun x -> s::x) ts, m
    in 
    


let g1 = 
  CharWGraph.add 'a' ['d',0;'b',0] (
    CharWGraph.add 'b' ['a',0;'c',0;'e',0] (
      CharWGraph.add 'c' ['b',0;'e',0] (
	CharWGraph.add 'd' ['a',0;'e',0] (
	  CharWGraph.add 'e' ['b',0;'c',0;'d',0] (
	    CharWGraph.add 'f' ['d',0;'g',0] (
	      CharWGraph.add 'g' ['d',0;'f',0;'h',0] (
		CharWGraph.singleton 'h' ['e',0;'g',0])))))))
	

