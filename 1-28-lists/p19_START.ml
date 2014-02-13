(*

Rotate a list N places to the left. (medium)

*)

let rotate l n =
  let roll l k = List.fold_left (fun (a,b,c) x -> if c < abs k then x::a,b,c+1 else a,x::b,c+1) ([],[],0) l in
  if n < 0 then
    let a,b,_ = roll (List.rev l) n in
    List.rev_append (List.rev a) b
  else 
    let a,b,_ = roll l n in 
    List.rev a |> List.rev_append b
