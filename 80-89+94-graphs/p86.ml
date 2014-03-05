(*

Node degree and graph coloration. (medium)

Write a function degree graph node that determines the degree of a given node.

Write a function that generates a list of all nodes of a graph sorted according to decreasing degree.

Use Welsh-Powell's algorithm to paint the nodes of a graph in such a way that adjacent nodes have different colors.

*)

type 'a grpah = { nodes: 'a list; edges: ('a * 'a) list}

let degree g v = List.filter (fun (x,y) -> x = v || y = v) g.edges |> List.length

let sorted_vs_dg g =
  List.map (fun v -> (v,degree g v)) g.nodes |> List.sort (fun (v1,d1) (v2,d2) -> -(compare d1 d2))

let rec (><) i j = 
  if i > j then j >< i
  else 
    let rec aux acc k =
      if k < i then acc
      else aux (k::acc) (k-1)
    in 
    aux [] j

let (--) l1 x = List.filter ((<>) x) l1

let rec cbinding v = function
  | [] -> None
  | (x,c)::tl -> if x = v then Some (x,c) else cbinding v tl

let coloring g =
  let sv = sorted_vs_dg g in
  let (_,d) = List.hd sv in
  let colors = 1 >< d+1 in
  let rec min_color cl v vs = function
    | [] -> List.hd cl
    | (x,y)::tl -> 
      if v <> x && v <> y then min_color cl v vs tl
      else 
	let vk = if v = x then y else x in
	let c = cbinding vk vs in
	  match c with
	    | None -> min_color cl v vs tl
	    | Some (_,c) -> min_color (cl--c) v vs tl	
  in
  let rec give_color vs es = function
    | [] -> vs
    | (v,_)::tl -> give_color ((v,min_color colors v vs es)::vs) es tl
  in 
  give_color [] g.edges sv |> List.sort (fun (x1,c1) (x2,c2) -> compare c1 c2)

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
    
    
  


