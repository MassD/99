(*

Run-length encoding of a list. (easy)

If you need so, refresh your memory about run-length encoding.

*)

let encoding l =
  if l = [] then [] (* you can't put l here as you will ruin the type system *)
  else 
    let hd = List.hd l in
    let acc,s = List.fold_left (fun (acc,(c,x)) y -> if y = x then acc,(c+1,x) else (c,x)::acc,(1,y)) ([],(1,hd)) (List.tl l)
    in 
    List.rev (s::acc)

let l1 = ["a";"a";"a";"a";"b";"c";"c";"a";"a";"d";"e";"e";"e";"e"];;
let l2 = []
let l3 = [1;2;2;3;1;4]
