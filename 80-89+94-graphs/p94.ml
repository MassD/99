(*

Generate K-regular simple graphs with N nodes. (hard)

In a K-regular graph all nodes have a degree of K; i.e. the number of edges incident in each node is K. How many (non-isomorphic!) 3-regular graphs with 6 nodes are there?

*)

let rec pick m = function
  | [] -> []
  | l when m = 1 -> List.map (fun x -> [x]) l
  | hd::tl -> List.map (fun x -> hd::x) (pick (m-1) tl) @ pick m tl

let check_endpoint v es = function
  | [] -> true
  | hd::tl -> 
    let l = List.assoc hd es in
    List.mem v l && List.length l < 3 && check_endpoint v es tl



let k_regular l k =
  if k > List.length l - 1 then []
  else 
    let rec build ess es = function
      | [] -> ess
      | v::vs ->
	let picks = pick k l |> List.filter (fun p -> check_endpoint v es p) in
	let 
	
