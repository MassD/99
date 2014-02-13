(*

12. Decode a run-length encoded list. (medium)

Given a run-length code list generated as specified in the previous problem 11, construct its uncompressed version.

*)

type 'a rle =
    | One of 'a
    | Many of int * 'a

let decode l = 
  let rec duplicates a n i acc =
    if i = n then acc
    else duplicates a n (i+1) (a::acc)
  in 
  List.fold_left (fun acc x -> match x with One x -> x::acc | Many (c,x) -> List.rev_append (duplicates x c 0 []) acc) [] l |> List.rev

let l = [Many (4,"a"); One "b"; Many (2,"c"); Many (2,"a"); One "d"; Many (4,"e")]
let l1 = []
