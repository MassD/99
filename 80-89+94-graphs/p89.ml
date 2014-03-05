(*

Bipartite graphs. (medium)

Write a predicate that finds out whether a given graph is bipartite

*)

type 'a grpah = { nodes: 'a list; edges: ('a * 'a) list}

let neighbours v es =
  let rec collect acc = function
  | [] -> acc
  | (x,y)::tl -> 
    if x = v then collect (y::acc) tl
    else if y = v then collect (x::acc) tl
    else collect acc tl
  in 
  collect [] es
	
let bipartite g =
  let rec breath_fst s (m, (p1,p2)) = 
    if List.mem s m then m,(p1,p2)
    else List.fold_left (fun (m,(p1,p2)) x -> travel x (m,(p2,p1))) (s::m,(s::p1,p2)) (neighbours s g.edges)
  in 
  travel v ([],[]) |> snd |> List.sort compare

let bipartite g =
  

let g1 = 
  {
    nodes = ['a';'b';'c';'d';'e';'f';'g';'h';'i';'j';'k'];
    edges = ['a','b';
	     'a','h';
	     'c','d';
	     'e','f';
	     'g','h';
	     'g','k';
	     'h','i';
	     'h','j';
	     'i','j';
	     'j','k']
  }
    
    
  


