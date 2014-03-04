(*

![weighted tree](http://ocaml.org/img/spanning-tree-graph2.gif)

Write a function ms_tree graph to construct the minimal spanning tree of a given labelled graph. A labelled graph will be represented as follows:

type ('a, 'b) labeled_graph = { nodes : 'a list;
                                edges : ('a * 'a * 'b) list }
(Beware that from now on nodes and edges mask the previous fields of the same name.)

Hint: Use the algorithm of Prim. A small modification of the solution of P83 does the trick. The data of the example graph to the right can be found below.

*)

type 'a graph = { nodes : 'a list; edges : ('a * 'a * int) list }

let split v tvs es = List.partition (fun (x,y,_) -> (List.mem x tvs && y = v) || (List.mem y tvs && x = v)) es

let compare_weight (x1,y1,w1) (x2,y2,w2) = compare w1 w2

let min_weight l = List.fold_left (fun min x -> if compare_weight x min < 0 then x else min) (List.hd l) (List.tl l)

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
	collect (add_edge (min_weight ps) acc) (v::tvs) qs tl
  in 
  collect [] [List.hd g.nodes] g.edges (List.tl g.nodes)


let g1 = { nodes = ['a'; 'b'; 'c'; 'd'; 'e'; 'f'; 'g'; 'h'];
          edges = [('a', 'b', 5); ('a', 'd', 3); ('b', 'c', 2);
                   ('b', 'e', 4); ('c', 'e', 6); ('d', 'e', 7);
                   ('d', 'f', 4); ('d', 'g', 3); ('e', 'h', 5);
                   ('f', 'g', 4); ('g', 'h', 1)] };;

	
 
