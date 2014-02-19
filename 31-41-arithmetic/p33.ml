(*

Determine whether two positive integer numbers are coprime. (easy)

Two numbers are coprime if their greatest common divisor equals 1.

*)

let rec gcd a b =
  if a = b then a
  else if a > b then gcd b (a-b)
  else gcd a (b-a)

let coprime a b = (not (a mod 2 = 0 && b mod 2 = 0)) && gcd a b = 1
