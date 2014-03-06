(*

Generate K-regular simple graphs with N nodes. (hard)

In a K-regular graph all nodes have a degree of K; i.e. the number of edges incident in each node is K. How many (non-isomorphic!) 3-regular graphs with 6 nodes are there?

*)

(* for isomorphism *)

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

(* for k-regular *)

let rev_concat_map f l = List.fold_left (fun acc x -> List.rev_append (f l) acc) l

let singleton l = List.map (fun x -> (x,[])) l

let rec pick m = function
  | [] -> []
  | l when m = 1 -> List.map (fun x -> [x]) l
  | hd::tl -> List.map (fun x -> hd::x) (pick (m-1) tl) @ pick m tl

let rec check_endpoint k v es = function
  | [] -> true
  | hd::tl -> 
    let l = List.assoc hd es in
    (not (List.mem v l)) && List.length l < k && check_endpoint k v es tl

let link v p es = 
  let rec create_es acc = function
    | [] -> acc
    | (x,ys)::tl when List.mem x p -> create_es ((x,v::ys)::acc) tl
    | e::tl -> create_es (e::acc) tl
  in 
  (create_es [] es)
  

let k_regular l k =
  if k > List.length l - 1 then []
  else 
    let rec build es = function
      | [] -> []
      | v::vs ->
	let picks = pick k l |> List.filter (fun p -> check_endpoint k v es p) in
	rev_concat_map (fun p -> build (link v p es) vs) picks
    in 
    build (List.map (fun x -> x,[])) l
	
