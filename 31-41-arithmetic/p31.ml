(*

Determine whether a given integer number is prime. (medium)

*)

let is_prime n =
  if n < 2 then false
  else if n = 2 then true
  else if n mod 2 = 0 then false
  else 
    let sr = float_of_int n |> sqrt |> int_of_float in
    let rec check i = 
      if i > sr then true
      else if n mod i = 0 then false
      else check (i+1)
    in 
    check 3
