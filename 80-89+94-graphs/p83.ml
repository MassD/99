(*

Construct all spanning trees. (medium)

![spanning tree](http://ocaml.org/img/spanning-tree-graph1.gif)

Write a function s_tree g to construct (by backtracking) all spanning trees of a given graph g. With this predicate, find out how many spanning trees there are for the graph depicted to the left. The data of this example graph can be found in the test below. When you have a correct solution for the s_tree function, use it to define two other useful functions: is_tree graph and is_connected Graph. Both are five-minutes tasks!

*)

type 'a graph = { nodes : 'a list; edges : ('a * 'a) list }

let split v tvs es = List.partition (fun (x,y) -> (List.mem x tvs && y = v) || (List.mem y tvs && x = v)) es

let add_edge e = function
  | [] -> [[e]] 
  | es -> List.rev_map (fun x -> e::x) es

let s_tree g =
  let rec collect acc tvs es = function
    | [] -> acc
    | v::tl -> 
      let ps,qs = split v tvs es in
      if ps = [] then [] (* graph is not connected *)
      else 
	collect (List.fold_left (fun new_acc p -> List.rev_append (add_edge p acc) new_acc) [] ps) (v::tvs) qs tl
  in 
  collect [] [List.hd g.nodes] g.edges (List.tl g.nodes)

let is_tree g = List.length (s_tree g) > 0

let is_connected g = List.length (s_tree g) > 0

let g1 = 
  { nodes = ['a'; 'b'; 'c'; 'd'; 'e'; 'f'; 'g'; 'h'];
    edges = [('a', 'b'); ('a', 'd'); ('b', 'c'); ('b', 'e');
             ('c', 'e'); ('d', 'e'); ('d', 'f'); ('d', 'g');
             ('e', 'h'); ('f', 'g'); ('g', 'h')] }

	
 
