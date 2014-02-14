(*

Group the elements of a set into disjoint subsets. (medium)

1. In how many ways can a group of 9 people work in 3 disjoint subgroups of 2, 3 and 4 persons? Write a function that generates all the possibilities and returns them in a list.

2. Generalize the above function in a way that we can specify a list of group sizes and the function will return a list of groups

*)

exception Cannot_group

let sum l = List.fold_left (+) 0 l

let extract k l = 
  let rec extr rest k = function
  | [] -> []
  | _ when k = 0 -> []
  | hd::tl when k = 1 -> ([hd],rest@tl)::(extr (hd::rest) 1 tl)
  | hd::tl -> List.map (fun x -> hd::(fst x),(snd x)) (extr rest (k-1) tl) |> List.append (extr (hd::rest) k tl)
  in 
  extr [] k l
  

let group l kl =
  if List.length l < sum kl then raise Cannot_group
  else 
    let rec grp l = function
      | [] -> [[]]
      | k::tl ->
	extract k l |> List.map (fun (cs, rest) -> grp rest tl |> List.map (fun y -> cs::y)) |> List.flatten
    in 
    grp l kl

let l,kl = [1;2;3;4], [2;1]
    
