(*

Given a list of integer numbers, find a correct way of inserting arithmetic signs (operators) such that the result is a correct equation. 

Example: With the list of numbers [2;3;5;7;11] we can form the equations 2-3+5+7 = 11 or 2 = (3*5+7)/11 (and ten others!).

*)

open Tries

type op = Add | Sub | Mul | Div

type expr = 
  | Num of int
  | App of expr * op * expr

let rev_flatten l = 
  List.fold_left (fun acc x -> List.fold_left (fun acc y -> y::acc) acc x) [] l

let ops = [Add;Sub;Mul;Div]

let apply x op y =
  match op with
    | Add -> x + y
    | Sub -> x - y
    | Mul -> x * y
    | Div -> x / y

let rec value = function
  | Num x -> x
  | App (x, op, y) -> apply (value x) op (value y)

let legal x op y =
  match op with
    | Add -> true
    | Sub -> true
    | Mul -> true
    | Div -> y <> 0 && x mod y = 0

let splits l = 
  let rec split front acc = function
    | [] | _::[] -> acc
    | hd::tl -> 
      let new_front = hd::front in split new_front ((List.rev new_front, tl)::acc) tl
  in 
  split [] [] l

let combine (e1,v1) (e2,v2) =
  let rec comb acc = function
    | [] -> acc
    | op::tl when legal v1 op v2 -> comb ((App (e1,op,e2),apply v1 op v2)::acc) tl
    | op::tl -> comb acc tl
  in 
  comb [] ops

let fuse f l1 l2 = 
  List.rev_map (
    fun x -> List.rev_map (fun y -> f x y) l2 |> rev_flatten) l1 |> rev_flatten

let rec make_expr = function
  | [] -> []
  | x::[] -> [(Num x, x)]
  | _ as l -> splits l |> List.rev_map (fun (a,b) -> fuse combine (make_expr a) (make_expr b)) |> rev_flatten

let eq (e1,v1) (e2,v2) = if v1 = v2 then [Some (e1,e2,v1)] else [None]

let find_eq l =
  splits l |> List.rev_map (fun (a,b) -> fuse eq (make_expr a) (make_expr b) |> List.filter ((<>)None)) |> rev_flatten

(* ================================ *)

let rec make_expr' l t = 
  match get l t with
    | Some evs -> evs, t
    | None ->
      match l with 
	| [] -> [],t
	| x::[] -> let evs = [(Num x, x)] in evs, add l evs t
	| _ as l -> 
	  let evs, new_t = 
	    splits l |> 
	      List.fold_left (
		fun (acc,t) (a,b) -> 
		  let evs1, t1 = make_expr' a t in 
		  let evs2, t2 = make_expr' b t1 in
		  let evs = fuse combine evs1 evs2 in
		  List.rev_append evs acc, t2
	      ) ([], t)
	  in 
	  evs, add l evs new_t

let find_eq' l =
    splits l |> 
	List.fold_left (
	  fun (acc,t) (a,b) -> 
	    let evs1, t1 = make_expr' a t in 
	    let evs2, t2 = make_expr' b t1 in
	    let evs = fuse eq evs1 evs2 |> List.filter ((<>)None) in
	    List.rev_append evs acc, t2
	) ([], empty) |> fst


let l = [2;3;5;7;11] (*13;15;17;19*)

let _ = 
  let t1 = Sys.time() in
  let len1 = find_eq l |> List.length in
  let t2 = Sys.time() in
  let len2 = find_eq' l |> List.length in
  let t3 = Sys.time() in
  Printf.printf "slow: Found %d equations, cost %f sec.\nfast: Found %d equations, cost %f secs\n" len1 (t2-.t1) len2 (t3-.t2)
