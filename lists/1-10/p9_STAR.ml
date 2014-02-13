(*

Pack consecutive duplicates of list elements into sublists. (medium)

*)

let pack l =
  if l = [] then [] (* you can't put l here, it will ruin the type system *)
  else 
    let hd = List.hd l in
    let acc,(sub,_) = 
      List.fold_left (fun (acc,(sub,x)) y -> if y = x then acc,(y::sub,x) else sub::acc,([y],y)) ([],([hd],hd)) (List.tl l) 
    in
    List.rev (sub::acc)

let l1 = ["a";"a";"a";"a";"b";"c";"c";"a";"a";"d";"d";"e";"e";"e";"e"]
let l2 = []
let l3 = [1;2;1;3;2;1;1]
