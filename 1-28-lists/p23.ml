(*

Extract a given number of randomly selected elements from a list. (medium)

The selected items shall be returned in a list. We use the Random module but do not initialize it with Random.self_init for reproducibility.

*)

let extract k l =
  let rec extr i acc = function
    | [] -> raise Not_found
    | hd::tl when i = k -> hd, List.rev_append acc tl
    | hd::tl -> extr (i+1) (hd::acc) tl
  in 
  extr 0 [] l

let rand_select l n =
  let rec select i acc l len =
    if i = n then acc
    else 
      let s, l = extract (Random.int len) l in
      select (i+1) (s::acc) l (len-1)
  in 
  select 0 [] l (List.length l) |> List.rev

let l,k = ["a";"b";"c";"d";"e";"f";"g";"h"],3
  
