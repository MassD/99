type ('a,'b) ternary_tries = Leaf | Node of 'a * ('a,'b) ternary_tries * ('a,'b) ternary_tries * ('a,'b) ternary_tries * 'b option

let empty = Leaf

let rec add kl vl tt =
  match kl,tt with
    | [], _ -> tt
    | hd::[], Leaf -> Node (hd, Leaf, Leaf, Leaf, Some vl)
    | hd::tl, Leaf -> Node (hd, Leaf, add tl vl Leaf, Leaf, None)
    | hd::tl, Node (k,l,m,r,v) -> 
      if hd = k && tl = [] then Node (k,l,m,r,Some vl)
      else if hd = k then Node (k,l,add tl vl m,r,v)
      else if hd < k then Node (k, add kl vl l, m,r,v)
      else Node (k,l,m,add kl vl r,v)

let rec get kl tt =
  match kl,tt with
    | [], _ | _, Leaf -> None
    | hd::tl, Node (k,l,m,r,v) ->
      if hd = k && tl = [] then v
      else if hd = k then get tl m
      else if hd < k then get kl l
      else get kl r

let rec del kl tt = 
  let del_useless = function
    | Node (_,Leaf,Leaf,Leaf,None) -> Leaf
    | _ as node -> node
  in 
  match kl,tt with
    | [], _ -> tt
    | _, Leaf -> Leaf
    | hd::tl, Node (k,l,m,r,v) ->
	if hd = k && tl = [] then Node (k,l,m,r,None) |> del_useless
	else if hd = k then Node (k,l,del tl m,r,v) |> del_useless
	else if hd < k then Node (k,del kl l,m,r,v) |> del_useless
	else Node (k,l,m,del kl r,v) |> del_useless

let tt1 = add [1;2;3;4] 'y' empty 

let tt2 = add [1;2;3] 'x' tt1

let tt3 = add [5;1;2;3] 'z' tt2
