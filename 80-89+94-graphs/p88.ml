(*

Connected components. (medium)

Write a predicate that splits a graph into its connected components.

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
  travel v ([],[]) |> snd

let (--) l1 l2 = List.filter (fun x -> not (List.mem x l2)) l1

let connected_components g =
  let rec collect acc = function
    | [] -> acc
    | v::vs -> 
      let p = depth_traversal g v in
      collect (p::acc) (vs -- p)
  in 
  collect [] g.nodes

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
    
    
  


