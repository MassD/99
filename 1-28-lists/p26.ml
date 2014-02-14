(*

Generate the combinations of K distinct objects chosen from the N elements of a list. (medium)

In how many ways can a committee of 3 be chosen from a group of 12 people? We all know that there are C(12,3) = 220 possibilities (C(N,K) denotes the well-known binomial coefficients). For pure mathematicians, this result may be great. But we want to really generate all the possibilities in a list.

*)

(* remove all the duplicating elements, ignoring the order *)
let rm_dup l =
  if l = [] then []
  else 
    let sl = List.sort compare l in
    let hd = List.hd sl in
    List.fold_left (fun (acc,x) y -> if y = x then acc,x else y::acc,y) ([hd],hd) (List.tl sl) |> fst

let extract k l =
  let no_dup = rm_dup l in
  let rec extr i = function
    | [] -> []
    | _::_ when i = 0 -> []
    | hd::tl when i = 1 -> List.map (fun x -> [x]) (hd::tl)
    | hd::tl -> List.map (fun x -> hd::x) (extr (i-1) tl) |> List.append (extr k tl)
  in 
  extr k no_dup

let k,l = 2, ["a";"b";"c";"d";"a"]
