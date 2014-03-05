(*

Depth-first order graph traversal. (medium)

Write a function that generates a depth-first order graph traversal sequence. The starting point should be specified, and the output should be a list of nodes that are reachable from this starting point (in depth-first order).

*)

type 'a grpah = { nodes: 'a list; edges: ('a * 'a) list}

let depth_traversal g v =
  let rec neighbours v acc = function
    | [] -> acc
    | (x,y)::tl -> 
      if x = v then neighbours v (y::acc) tl
      else if y = v then neighbours v (x::acc) tl
      else neighbours v acc tl
  in 
  let rec travel s (m,p) = 
    if List.mem s m then m,p
    else List.fold_left (fun (m,p) x -> travel x (m,p)) (s::m, s::p) (neighbours s [] g.edges)
  in 
  travel v ([],[]) |> snd |> List.rev

let g1 = 
  {
    nodes = ['a';'b';'c';'d';'e';'f';'g';'h';'i';'j';'k'];
    edges = ['a','b';
	     'a','h';
	     'b','d';
	     'c','d';
	     'd','i';
	     'd','k';
	     'e','k';
	     'e','f';
	     'f','g';
	     'g','h';
	     'g','k';
	     'h','i';
	     'h','j';
	     'i','j';
	     'j','k']
  }
    
    
  


