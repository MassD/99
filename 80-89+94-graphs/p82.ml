(*

Cycle from a given node. (easy)

Write a functions cycle g a that returns a closed path (cycle) p starting at a given node a in the graph g. The predicate should return the list of all cycles via backtracking.

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

let cycles g a =
  let rec collect s marked step =
    if s = a && step <> 0 then [[s]]
    else if CharSet.mem s marked then []
    else 
      let edges = CharMap.find s g in
      let m = CharSet.add s marked in
      List.fold_left (fun acc c -> List.rev_append (collect c m (step+1)) acc) [] edges |> List.map (fun x -> s::x)
  in 
  collect a (CharSet.empty) 0

	
 
