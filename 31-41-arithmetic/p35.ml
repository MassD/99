(*

Determine the prime factors of a given positive integer. (medium)

Construct a flat list containing the prime factors in ascending order.

*)

let factors m =
  let rec accum x i acc =
    if i >= x then List.rev (x::acc)
    else if x mod i = 0 then accum (x/i) i (i::acc)
    else accum x (i+1) acc
  in 
  accum m 2 []


