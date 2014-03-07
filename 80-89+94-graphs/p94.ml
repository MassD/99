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

let rev_concat_map f l = List.fold_left (fun acc x -> List.rev_append (f x) acc) [] l

let rm_dup f l =
  let rec rm x acc = function
    | [] -> List.rev acc
    | hd::tl when f x hd -> rm x acc tl
    | hd::tl -> rm x (hd::acc) tl 
  in 
  let rec collect acc = function
    | [] -> List.rev acc
    | hd::tl -> collect (hd::acc) (rm hd [] tl)
  in 
  collect [] l

let singleton l = List.rev_map (fun x -> (x,[])) l

let rec pick m = function
  | [] -> []
  | l when m = 1 -> List.map (fun x -> [x]) l
  | hd::tl -> List.map (fun x -> hd::x) (pick (m-1) tl) @ pick m tl

let rec is_valid k v nvs es = function
  | [] -> true
  | hd::tl when List.mem hd nvs -> false
  | hd::tl -> 
    let l = List.assoc hd es in
    (not (List.mem v l)) && 1+(List.length l) <= k && is_valid k v nvs es tl

let link v p es = 
  List.fold_left (
    fun acc (x,ys) ->
      if x = v then (v,List.rev_append ys p)::acc
      else if List.mem x p then (x,v::ys)::acc
      else (x,ys)::acc
  ) [] es
  
let add l k v es =
  let nvs = List.assoc v es in
  let nvs_len = List.length nvs in
  if nvs_len = k then [es]
  else 
    let picks = pick (k-nvs_len) (l--v) |> List.filter (fun p -> is_valid k v nvs es p) 
    in
    List.rev_map (fun p -> link v p es) picks

let create_edges l =
  let sl = List.sort compare l in
  let rec collect acc = function
    | [] -> List.sort compare acc
    | (x,ys)::tl -> collect (List.fold_left (fun acc y -> if List.mem (x,y) acc || List.mem (y,x) acc then acc else (x,y)::acc) acc ys) tl
  in 
  collect [] sl

let dummy_nl n =
  let rec collect acc k =
    if k = 0 then acc
    else collect (k::acc) (k-1)
  in 
  collect [] n

let k_regular n k =
  if k > n - 1 then 0
  else 
    let l = dummy_nl n in
    let rec build ess = function
      | [] -> ess
      | v::vs ->
	build (rev_concat_map (add l k v) ess) vs
    in 
    build [singleton l] l |> List.rev_map (fun x -> {nodes=l;edges=create_edges x}) |> rm_dup is_isomorphism |> List.length




let nl = [1;2;3]
let k = 2
let s = singleton nl
