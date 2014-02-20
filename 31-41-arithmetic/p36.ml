(*

Determine the prime factors of a given positive integer (2). (medium)

Construct a list containing the prime factors and their multiplicity. Hint: The problem is similar to problem Run-length encoding of a list (direct solution).

*)

let factors m =
  let rec accum x i c acc =
    if i >= x then List.rev ((x,1)::acc)
    else if x mod i = 0 then accum (x/i) i (c+1) acc
    else if c >= 1 then accum x (i+1) 0 ((i,c)::acc)
    else accum x (i+1) 0 acc
  in 
  accum m 2 0 []
