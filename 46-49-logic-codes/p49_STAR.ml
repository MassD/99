(*

Huffman coding

*)

(*
  The following implementation considers performance, so we use a leftist heap. Choosing leftist tree as heap can make it more functional way. Also, it provides functions to build huffman from a string.
*)

exception Empty_heap

type 'a leftist = Empty | Node of 'a leftist * int * 'a * 'a leftist * int

let empty_heap = Empty

let rank = function Empty -> 0 | Node (_,_,_,_,r) -> r

let singleton k v = Node (Empty, k, v, Empty, 0)

let rec merge t1 t2 = 
  match t1,t2 with
    | Empty, t | t, Empty -> t
    | Node (l1,k1,v1,r1,_), Node (_,k2,_,_,_) ->
      if k1 > k2 then merge t2 t1
      else 
	let new_r = merge r1 t2 in
	if rank new_r > rank l1 then Node (new_r,k1,v1,l1,1+rank l1)
	else Node (l1,k1,v1,new_r,1+rank new_r)

let add k v h = merge h (singleton k v)

let min = function Empty -> raise Empty_heap | Node (_,k,v,_,_) -> (k,v)

let remove_min = function
  | Empty -> raise Empty_heap
  | Node (l,k,v,r,_) -> merge l r



module CharMap = Map.Make (struct type t = char let compare = compare end)

let char_list s =
  let len = String.length s in
  let rec accum acc i =
    if i < len then accum (s.[i]::acc) (i+1)
    else List.rev acc
  in
  accum [] 0

let frequencies s =
  let rec accum m_acc = function
    | [] -> CharMap.bindings m_acc
    | hd::tl -> 
      if CharMap.mem hd m_acc then accum (CharMap.add hd (1+(CharMap.find hd m_acc)) m_acc) tl
      else accum (CharMap.add hd 1 m_acc) tl
  in 
  char_list s |> accum CharMap.empty

type huffman_tree = Leaf of char * int | Node of huffman_tree * huffman_tree * int

let frequencies_heap s = 
  frequencies s |> List.fold_left (fun acc (c,freq) -> add freq c acc) empty_heap

let rec merge_huffman x y =
  match x,y with
    | Leaf (_,f1), Leaf (_,f2) 
    | Leaf (_,f1), Node (_,_,f2) 
    | Node (_,_,f1), Leaf (_,f2)
    | Node (_,_,f1), Node (_,_,f2) -> 
      if f1 < f2 then Node (x,y,f1+f2)
      else Node (y,x,f1+f2)

let freq = function Leaf (_,f) -> f | Node (_,_,f) -> f

let huffman fs =
  let fh = List.fold_left (fun acc (c,fc) -> add fc (Leaf (c,fc)) acc) empty_heap fs in
  let rec fold = function
    | Empty -> (print_endline "empty";raise Empty_heap)
    | Node (Empty,_,root,Empty,_) -> root
    | h -> (
      print_endline "not empty";
      let (fx,x) = min h in 
      let h = remove_min h in
      let (fy,y) = min h in
      Printf.printf "fx = %d, fy = %d" fx fy;
      let new_node = merge_huffman x y in
      fold (add (freq new_node) new_node (remove_min h)))
  in 
  fold fh

let huffman_of_str s = frequencies s |> huffman

let list_of_huffman fs = 
  let rec accum bit_acc = function
    | Leaf (c,fc) -> [(c,bit_acc)]
    | Node (l,r,_) -> (accum (bit_acc^"0") l) @ (accum (bit_acc^"1") r)
  in 
  accum "" (huffman fs)

let fs = [('a',45); ('b',13); ('c',12); ('d',16); ('e',9); ('f',5)]
      

