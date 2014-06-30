(*

Bipartite graphs. (medium)

Write a predicate that finds out whether a given graph is bipartite

*)

type 'a grpah = { nodes: 'a list; edges: ('a * 'a) list}

(*let neighbours es v =
  let rec collect acc = function
  | [] -> acc
  | (x,y)::tl -> 
    if x = v then collect (y::acc) tl
    else if y = v then collect (x::acc) tl
    else collect acc tl
  in 
  collect [] es

let rev_concat_map f l = List.fold ~f:(fun acc x -> List.rev_append (f x) acc) ~init:[] l

let (--) l1 l2 = List.filter ~f:(fun x -> not (List.mem x l2)) l1

let is_overlap l1 l2 = List.filter ~f:(fun x -> List.mem x l2) l1 |> List.length > 0

let rm_dup l =
  let rec aux acc = function
    | [] -> acc
    | hd::(hd'::_ as tl) when hd = hd' -> aux acc tl
    | hd::tl -> aux (hd::acc) tl
  in 
  List.sort compare l |> aux []
	
let bipartite g =
  let rec breath_fst vs p q = 
    let nvs = (rev_concat_map (neighbours g.edges) vs |> rm_dup) -- p in
    if nvs = [] then Some (p,q)
    else if is_overlap nvs q then None
    else breath_fst nvs q (List.rev_append nvs p)
  in 
  let vs = [List.hd g.nodes] in
  breath_fst vs [] vs*)


let find_end g x =
  List.fold ~init:[] ~f:(fun acc (a,b) -> if a = x then b::acc else if b = x then a::acc else acc) g.edges

let is_overlap l1 l2 = List.filter ~f:(fun x -> List.mem l2 x) l1 |> List.length > 0
let swap = function None -> None | Some (x,y) -> Some (y,x)

let bipartite_better g =
  let rec build_from xs (sl, sr) =
    List.fold ~init:(Some (sl, sr)) ~f:(fun acc x ->
      match acc with
	| None -> None
	| Some (sl, sr) ->
	  if List.mem sl x || List.mem sr x then Some (sl, sr)
	  else 
	    let ys = find_end g x in
	    if is_overlap ys sl then None
	    else build_from ys (sr, x::sl) |> swap
    ) xs
	
  in 
  build_from g.nodes ([], [])
				      
      
  

let g1 = 
  {
    nodes = ['a';'b';'c';'d';'e';'f';'g';'h'];
    edges = ['a','f';
	     'a','h';
	     'b','e';
	     'b','g';
	     'c','f';
	     'c','h';
	     'd','h';
	     'e','a';

	    ]
  }
   
let g2 = 
  {
    nodes = ['a';'b';];
    edges = ['a','b';
	    ]
  }
    
  


