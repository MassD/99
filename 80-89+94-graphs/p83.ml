(*

Construct all spanning trees. (medium)

![spanning tree](http://ocaml.org/img/spanning-tree-graph1.gif)

Write a function s_tree g to construct (by backtracking) all spanning trees of a given graph g. With this predicate, find out how many spanning trees there are for the graph depicted to the left. The data of this example graph can be found in the test below. When you have a correct solution for the s_tree function, use it to define two other useful functions: is_tree graph and is_connected Graph. Both are five-minutes tasks!

*)

type 'a graph = { nodes : 'a list; edges : ('a * 'a) list }

let s_tree g =
  let v = List.length (g.nodes) in
  let add_edge l (x,y) = 
    if List.mem x l && List.mem y l then l
    else if List.mem x l then y::l
    else if List.mem y l then x::l
    else x::y::l
  in 
  


let g1 = 
  { nodes = ['a'; 'b'; 'c'; 'd'; 'e'; 'f'; 'g'; 'h'];
    edges = [('a', 'b'); ('a', 'd'); ('b', 'c'); ('b', 'e');
             ('c', 'e'); ('d', 'e'); ('d', 'f'); ('d', 'g');
             ('e', 'h'); ('f', 'g'); ('g', 'h')] }

	
 
