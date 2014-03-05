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

let rec (<>) i j = 
  if i > j then j |<>| i
  else 
    let rec aux acc k =
      if k < i then acc
      else aux (k::acc) (k-1)
    in 
    aux [] j

let coloring g =
  let sv = sorted_vs_dg g in
  let (_,d) = List.hd sv in
  let colors = 1 <> d+1 in
  


