(*

Graph isomorphism. (medium)

Two graphs G1(N1,E1) and G2(N2,E2) are isomorphic if there is a bijection f: N1 → N2 such that for any nodes X,Y of N1, X and Y are adjacent if and only if f(X) and f(Y) are adjacent.

Write a function that determines whether two graphs are isomorphic. Hint: Use an open-ended list to represent the function f.

*)

type 'a graph = {nodes : 'a list;
		 edges : ('a * 'a) list
		}

let rev_concat_map f l = List.fold_left (fun acc x -> List.rev_append (f x) acc) [] l

let (--) l x = List.filter ((<>)x) l

let rec permutation = function
  | [] -> []
  | x::[] -> [[x]]
  | l -> rev_concat_map (fun x -> List.map (fun y -> x::y) (permutation (l--x))) l

let mappings l1 l2 = permutation l2 |> List.map (List.combine l1)

let f mapping x = List.assoc x mapping

let is_isomorphism g1 g2 =
  if List.length g1.nodes = List.length g2.nodes && List.length g1.edges = List.length g2.edges then 
    let ms = mappings g1.nodes g2.nodes in
    let test m (a,b) es2 = List.mem (f m a, f m b) es2 in
    let rec test_all m es2 = function
      | [] -> true
      | e::es1 -> test m e es2 && test_all m es2 es1
    in 
    let rec test_all_mappings = function
      | [] -> false
      | m::ms -> test_all m g2.edges g1.edges || test_all_mappings ms
    in 
    test_all_mappings ms
  else 
    false

let g1 = {nodes = [1;2;3];
	  edges = [1,2;2,3]
	 }

let g2 = {nodes = ['a';'b';'c'];
	  edges = ['a','c';'b','c']
	 }
