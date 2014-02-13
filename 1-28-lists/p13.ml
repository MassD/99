(*

13. Run-length encoding of a list (direct solution). (medium)

Implement the so-called run-length encoding data compression method directly. I.e. don't explicitly create the sublists containing the duplicates, as in problem "Pack consecutive duplicates of list elements into sublists", but only count them. As in problem "Modified run-length encoding", simplify the result list by replacing the singleton lists (1 X) by X.

    # encode ["a";"a";"a";"a";"b";"c";"c";"a";"a";"d";"e";"e";"e";"e"];;
    - : string rle list = [Many (4, "a"); One "b"; Many (2, "c"); Many (2, "a"); One "d"; Many (4, "e")]

*)

type 'a rle = One of 'a | Many of int * 'a;;

let encode l =
  if l = [] then []
  else 
    let add (c,x) l = if c = 1 then One x::l else Many (c,x)::l in
    let acc, s = 
      List.fold_left (fun (acc,(c,x)) y -> if y = x then acc, (c+1,x) else add (c,x) acc, (1,y)) ([], (1, List.hd l)) (List.tl l) 
    in
    List.rev (add s acc)
  
let l = ["a";"a";"a";"a";"b";"c";"c";"a";"a";"d";"e";"e";"e";"e"]
