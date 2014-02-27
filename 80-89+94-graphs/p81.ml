(*

Path from one node to another one. (medium)

Write a function paths g a b that returns all acyclic path p from node a to node b ≠ a in the graph g. The function should return the list of all paths via backtracking.

*)

module CharMap = Map.Make (Char)
module CharSet = Set.Make (Char)

type adj_graph = char list CharMap.t


let g1 = 
  CharMap.add 'g' ['h'] (
    CharMap.add 'h' ['g'] (
      CharMap.add 'b' ['f';'c'] (
	CharMap.add 'c' ['f';'b'] (
	  CharMap.add 'f' ['k';'b';'c'] (
	    CharMap.add 'k' ['f'] (
	      CharMap.singleton 'd' []))))))

let paths g a b =
  let rec collect s marked =
    if s = b then [[s]]
    else if CharSet.mem s marked then []
    else 
      let edges = CharMap.find s g in
      let m = CharSet.add s marked in
      List.fold_left (fun acc c -> List.rev_append (collect c m) acc) [] edges |> List.map (fun x -> s::x)
  in 
  collect a (CharSet.empty)

	
 
