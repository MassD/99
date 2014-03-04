(*

Node degree and graph coloration. (medium)

Write a function degree graph node that determines the degree of a given node.

Write a function that generates a list of all nodes of a graph sorted according to decreasing degree.

Use Welsh-Powell's algorithm to paint the nodes of a graph in such a way that adjacent nodes have different colors.

*)

type 'a grpah = { nodes: 'a list; edges: ('a * 'a) list}

let degree g v = List.filter (fun (x,y) -> x = v || y = v) g.edges |> List.length

let sorted_nodes_dg g =
  List.map (fun v -> (v,degree g v)) g.nodes |> List.sort (fun (v1,d1) (v2,d2) -> -(compare d1 d2))



