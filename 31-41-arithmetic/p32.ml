(*
 
Determine the greatest common divisor of two positive integer numbers. (medium)

*)

let rec gcd a b =
  if a = b then a
  else if a > b then gcd (a-b) b
  else gcd a (b-a)
