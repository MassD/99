(*

Generate a random permutation of the elements of a list. (easy)

*)

let extract k l = 
  let rec extr i acc = function
    | [] -> raise Not_found
    | hd::tl when i = k -> hd, List.rev_append acc tl
    | hd::tl -> extr (i+1) (hd::acc) tl
  in 
  extr 0 [] l

let rand_select n l =
  let rec select acc i l len = 
    if i = n then acc
    else 
      let r,l' = extract (Random.int len) l in
      select (r::acc) (i+1) l' (len-1)
  in 
  select [] 0 l (List.length l)

let permutation l = rand_select (List.length l) l

let l = ["a"; "b"; "c"; "d"; "e"; "f"]
