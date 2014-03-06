(*

Generate K-regular simple graphs with N nodes. (hard)

In a K-regular graph all nodes have a degree of K; i.e. the number of edges incident in each node is K. How many (non-isomorphic!) 3-regular graphs with 6 nodes are there?

*)

let rev_concat_map f l = List.fold_left (fun acc x -> List.rev_append (f l) acc) l

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
	
